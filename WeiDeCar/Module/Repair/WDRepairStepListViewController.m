//
//  WDRepairStepListViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/11.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairStepListViewController.h"
#import "WDRepairStepModel.h"
#import "WDRepairStepListHeaderView.h"
#import "WDRepairStepUploadImageCellView.h"
#import "WDRepairStepQualifiedCellView.h"
#import "WDListRepairStepApi.h"
#import "WDFinishRepairItemApi.h"
#import "WDUpdateRepairStepApi.h"
#import "WDQiniuFileService.h"
#import "WDUploadRepairStepPhotoApi.h"
#import "WDRepairStepItemImageViewController.h"

@interface WDRepairStepListViewController () <UITableViewDataSource,UITableViewDelegate,WDRepairStepListHeaderViewDelegate,WDRepairStepUploadImageCellViewDelegate,WDRepairStepQualifiedCellViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    MFUITableView *m_tableView;
    
    NSMutableArray<WDRepairStepModel *> *m_repairSteps;
    
    WDRepairStepModel *m_uploadPhotoRepairStep;
}

@property (nonatomic, strong) UIImage *pickImage;

@end

@implementation WDRepairStepListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"维修任务详情";
    [self setBackBarButton];
    
    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    m_tableView.backgroundColor = [UIColor hx_colorWithHexString:@"f5f5f5"];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    [self.view addSubview:m_tableView];
    
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    WDUserInfoModel *currentUserInfo = loginService.currentUserInfo;
    if (currentUserInfo.userType == WDUserInfoType_Expert)
    {
        [m_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top);
            make.width.equalTo(self.view.mas_width);
            make.bottom.equalTo(self.view.mas_bottom).offset(-60);
        }];
        
        UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [submitButton setTitle:@"维修完成" forState:UIControlStateNormal];
        [submitButton setBackgroundImage:MFImageStretchCenter(@"btn_blue_normal") forState:UIControlStateNormal];
        [submitButton addTarget:self action:@selector(onClickFinishRepairItem) forControlEvents:UIControlEventTouchUpInside];
        submitButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.view addSubview:submitButton];
        [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(20);
            make.centerX.equalTo(self.view.mas_centerX);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        }];
    }
    else
    {
        [m_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top);
            make.width.equalTo(self.view.mas_width);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
    }
    
    [self getRepairStepList];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return m_cellInfos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    if ([identifier isEqualToString:@"repairStepHeader"])
    {
        return [self tableView:tableView repairStepHeaderCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"repairStepQualifiedCellView"])
    {
        return [self tableView:tableView repairStepQualifiedCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"uploadImageCellView"])
    {
        return [self tableView:tableView uploadImageCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"division"])
    {
        return [self tableView:tableView divisionForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"separator"])
    {
        return [self tableView:tableView separatorCellForIndexPath:indexPath];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    cell.textLabel.text = identifier;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    return cellInfo.cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView repairStepHeaderCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    NSInteger attachIndex = cellInfo.attachIndex;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDRepairStepListHeaderView *cellView = [[WDRepairStepListHeaderView alloc] initWithFrame:cell.contentView.bounds];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    WDRepairStepModel *repairItem = m_repairSteps[attachIndex];
    
    WDRepairStepListHeaderView *cellView = (WDRepairStepListHeaderView *)cell.m_subContentView;
    [cellView setRepairStepModel:repairItem];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView repairStepQualifiedCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    NSInteger attachIndex = cellInfo.attachIndex;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDRepairStepQualifiedCellView *cellView = [[WDRepairStepQualifiedCellView alloc] initWithFrame:cell.contentView.bounds];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    WDRepairStepModel *repairItem = m_repairSteps[attachIndex];
    
    WDRepairStepQualifiedCellView *cellView = (WDRepairStepQualifiedCellView *)cell.m_subContentView;
    cellView.attachKey = cellInfo.attachKey;
    [cellView setRepairStepModel:repairItem];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView uploadImageCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    NSInteger attachIndex = cellInfo.attachIndex;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDRepairStepUploadImageCellView *cellView = [[WDRepairStepUploadImageCellView alloc] initWithFrame:cell.contentView.bounds];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    WDRepairStepModel *repairItem = m_repairSteps[attachIndex];
    
    WDRepairStepUploadImageCellView *cellView = (WDRepairStepUploadImageCellView *)cell.m_subContentView;
    [cellView setRepairStepModel:repairItem];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView divisionForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.contentView.backgroundColor = [UIColor hx_colorWithHexString:@"f5f5f5"];
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView separatorCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        UIView *separator = [UIView new];
        separator.frame = CGRectMake(0, 0, CGRectGetWidth(cell.contentView.frame), MFOnePixHeight);
        separator.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        separator.backgroundColor = MFCustomLineColor;
        [cell.contentView addSubview:separator];
    }
    return cell;
}

-(void)getRepairStepList
{
    __weak typeof(self) weakSelf = self;
    WDListRepairStepApi *mfApi = [WDListRepairStepApi new];
    mfApi.repairItemId = self.repairItemId;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *responseNetworkData = mfApi.responseNetworkData;
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = 0; i < responseNetworkData.count; i++) {
            WDRepairStepModel *itemModel = [WDRepairStepModel yy_modelWithDictionary:responseNetworkData[i]];
            [tempArray addObject:itemModel];
        }
        
        m_repairSteps = tempArray;
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
    }];
}

-(void)reloadTableView
{
    [self makeCellObjects];
    [m_tableView reloadData];
}

-(void)makeCellObjects
{
    [m_cellInfos removeAllObjects];
    
    for (int i = 0; i < m_repairSteps.count; i++) {
        
        [m_cellInfos addObject:[self divisionCellObject:15.0f]];
        [m_cellInfos addObject:[self separatorCellObject]];
        
        MFTableViewCellObject *repairStepHeader = [MFTableViewCellObject new];
        repairStepHeader.cellHeight = 40.0f;
        repairStepHeader.cellReuseIdentifier = @"repairStepHeader";
        repairStepHeader.attachIndex = i;
        [m_cellInfos addObject:repairStepHeader];
        
        [m_cellInfos addObject:[self separatorCellObject]];
        
        MFTableViewCellObject *onsiteQualified = [MFTableViewCellObject new];
        onsiteQualified.cellHeight = 40.0f;
        onsiteQualified.cellReuseIdentifier = @"repairStepQualifiedCellView";
        onsiteQualified.attachKey = @"onsiteQualified";
        onsiteQualified.attachIndex = i;
        [m_cellInfos addObject:onsiteQualified];
        
        [m_cellInfos addObject:[self separatorCellObject]];
        
        MFTableViewCellObject *thirdPartyQualifed = [MFTableViewCellObject new];
        thirdPartyQualifed.cellHeight = 40.0f;
        thirdPartyQualifed.cellReuseIdentifier = @"repairStepQualifiedCellView";
        thirdPartyQualifed.attachKey = @"thirdPartyQualifed";
        thirdPartyQualifed.attachIndex = i;
        [m_cellInfos addObject:thirdPartyQualifed];
        
        [m_cellInfos addObject:[self separatorCellObject]];
        
        WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
        WDUserInfoModel *currentUserInfo = loginService.currentUserInfo;
        if (currentUserInfo.userType != WDUserInfoType_CarOwner)
        {
            MFTableViewCellObject *repairStepAction = [MFTableViewCellObject new];
            repairStepAction.cellHeight = 80.0f;
            repairStepAction.cellReuseIdentifier = @"uploadImageCellView";
            repairStepAction.attachIndex = i;
            [m_cellInfos addObject:repairStepAction];
            
            [m_cellInfos addObject:[self separatorCellObject]];
        }
    }
}

-(MFTableViewCellObject *)separatorCellObject
{
    MFTableViewCellObject *separator = [MFTableViewCellObject new];
    separator.cellHeight = MFOnePixHeight;
    separator.cellReuseIdentifier = @"separator";
    return separator;
}

-(MFTableViewCellObject *)divisionCellObject:(CGFloat)cellHeight
{
    MFTableViewCellObject *division = [MFTableViewCellObject new];
    division.cellHeight = cellHeight;
    division.cellReuseIdentifier = @"division";
    return division;
}

#pragma mark - WDRepairStepListHeaderViewDelegate
-(void)onClickFinishRepairStep:(WDRepairStepModel *)repairStep cellView:(WDRepairStepListHeaderView *)cellView
{
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    WDUpdateRepairStepApi *mfApi = [WDUpdateRepairStepApi new];
    mfApi.userId = loginService.currentUserInfo.userId;
    mfApi.repairStepId = repairStep.repairStepId;
    
    WDUserInfoModel *currentUserInfo = loginService.currentUserInfo;
    if (currentUserInfo.userType == WDUserInfoType_Expert)
    {
        mfApi.isExpert = YES;
        mfApi.onsiteQualified = @"20";
        mfApi.thirdPartyQualified = @"20";
    }
    
    mfApi.animatingView = self.view;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        [strongSelf showTips:mfApi.errorMessage];
        
        [strongSelf getRepairStepList];
        
    } failure:^(YTKBaseRequest * request) {
        
    }];
}

#pragma mark - WDRepairStepUploadImageCellViewDelegate
-(void)onClickSeeImageRepairStep:(WDRepairStepModel *)repairStep cellView:(WDRepairStepUploadImageCellView *)cellView;
{
    WDRepairStepItemImageViewController *imageVC = [WDRepairStepItemImageViewController new];
    imageVC.repairStep = repairStep;
    [self.navigationController pushViewController:imageVC animated:YES];
}

-(void)onClickUploadImageRepairStep:(WDRepairStepModel *)repairStep cellView:(WDRepairStepUploadImageCellView *)cellView
{
    m_uploadPhotoRepairStep = repairStep;
    
    NSArray *actionArray = @[@"拍照",@"从手机相册选择"];
    
    __weak typeof(self) weakSelf = self;
    LGAlertView *alertView = [LGAlertView alertViewWithTitle:nil message:nil style:LGAlertViewStyleActionSheet buttonTitles:actionArray cancelButtonTitle:@"取消" destructiveButtonTitle:nil actionHandler:^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (index == 0)
        {
            [strongSelf openCameraImagePickerController];
        }
        else if (index == 1)
        {
            [strongSelf openImageLibrary];
        }
        
    } cancelHandler:^(LGAlertView * _Nonnull alertView) {
        
    } destructiveHandler:nil];
    
    [alertView showAnimated:YES completionHandler:nil];
}

-(void)openCameraImagePickerController
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)openImageLibrary
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"访问图片库错误"
                              message:@""
                              delegate:nil
                              cancelButtonTitle:@"OK!"
                              otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    self.pickImage = image;
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    
    if (self.pickImage == nil) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"还未选择图片"
                              message:@""
                              delegate:nil
                              cancelButtonTitle:@"OK!"
                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [self uploadImageToQNiu:self.pickImage];
    }
}

-(void)uploadImageToQNiu:(UIImage *)image
{
    __weak typeof(self) weakSelf = self;
    [self showMBStatusInViewController:@"正在上传..."];
    
    WDQiniuFileService *qiniuService = [[MMServiceCenter defaultCenter] getService:[WDQiniuFileService class]];
    [qiniuService uploadImageToQNiu:image complete:^(NSString *url, NSString *name)
     {
         __strong typeof(weakSelf) strongSelf = weakSelf;
         [strongSelf hiddenMBStatus];
         
         [strongSelf uploadRepairStepPhoto:url];
     }];
}

-(void)uploadRepairStepPhoto:(NSString *)photoUrl
{
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    WDUploadRepairStepPhotoApi *mfApi = [WDUploadRepairStepPhotoApi new];
    mfApi.repairStepId = m_uploadPhotoRepairStep.repairStepId;
    mfApi.photoUrl = photoUrl;
    mfApi.userId = loginService.currentUserInfo.userId;
    
    mfApi.animatingView = self.view;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        [strongSelf showTips:mfApi.errorMessage];
        [strongSelf getRepairStepList];
        
    } failure:^(YTKBaseRequest * request) {
        
    }];
}

-(void)onClickFinishRepairItem
{
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    WDFinishRepairItemApi *mfApi = [WDFinishRepairItemApi new];
    mfApi.userId = loginService.currentUserInfo.userId;
    mfApi.repairItemId = self.repairItemId;
    
    mfApi.animatingView = self.view;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        [strongSelf showTips:mfApi.errorMessage];
        [strongSelf.navigationController popViewControllerAnimated:YES];
        
    } failure:^(YTKBaseRequest * request) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
