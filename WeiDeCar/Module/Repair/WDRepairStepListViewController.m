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

@interface WDRepairStepListViewController () <UITableViewDataSource,UITableViewDelegate,WDRepairStepListHeaderViewDelegate,WDRepairStepUploadImageCellViewDelegate,WDRepairStepQualifiedCellViewDelegate>
{
    MFUITableView *m_tableView;
    
    NSMutableArray<WDRepairStepModel *> *m_repairSteps;
}

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
            repairStepAction.cellHeight = 60.0f;
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
        mfApi.thirdPartyQualifed = @"20";
    }
    
    mfApi.animatingView = self.view;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        [strongSelf showTips:mfApi.errorMessage];
        
        
    } failure:^(YTKBaseRequest * request) {
        
    }];
}

#pragma mark - WDRepairStepUploadImageCellViewDelegate
-(void)onClickUploadImageRepairStep:(WDRepairStepModel *)repairStep cellView:(WDRepairStepUploadImageCellView *)cellView
{
    [self showTips:@"您点击了上传图片"];
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
