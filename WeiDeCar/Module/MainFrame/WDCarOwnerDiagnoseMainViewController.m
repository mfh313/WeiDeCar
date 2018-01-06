//
//  WDCarOwnerDiagnoseMainViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/10.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDCarOwnerDiagnoseMainViewController.h"
#import "WDCreateDiagnoseByCarOwnerApi.h"
#import "WDDiagnosisMainAddView.h"
#import "WDListDiagnoseByCarOwnerApi.h"
#import "WDDiagnoseModel.h"
#import "WDDiagnoseItemCellView.h"
#import "WDConfirmDiagnoseByCarOwnerApi.h"
#import "WDReconfirmAfterExpertDiagnosedApi.h"

@interface WDCarOwnerDiagnoseMainViewController () <UITableViewDataSource,UITableViewDelegate,WDDiagnoseItemCellViewDelegate,WDDiagnosisMainAddViewDelegate>
{
    MFUITableView *m_tableView;
    
    WDUserInfoModel *m_currentUserInfo;
    NSMutableArray<WDDiagnoseModel *> *m_diagnoseArray;
}

@property (nonatomic,strong) NSString *carOwnerId;

@end

@implementation WDCarOwnerDiagnoseMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"现场诊断-车主";
    [self setBackBarButton];
    
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    m_currentUserInfo = loginService.currentUserInfo;
    
    WDDiagnosisMainAddView *addView = [WDDiagnosisMainAddView nibView];
    addView.m_delegate = self;
    [self.view addSubview:addView];
    [addView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(60);
    }];
    
    UIView *separator = [UIView new];
    separator.backgroundColor = MFCustomLineColor;
    [addView addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(addView.mas_bottom);
        make.width.equalTo(addView.mas_width);
        make.height.mas_equalTo(MFOnePixHeight);
    }];
    
    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    m_tableView.backgroundColor = [UIColor hx_colorWithHexString:@"f5f5f5"];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    [self.view addSubview:m_tableView];
    [m_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addView.mas_bottom);
        make.width.equalTo(self.view.mas_width);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    __weak typeof(self) weakSelf = self;
    [m_tableView addPullToRefreshWithActionHandler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf getListDiagnoseByCarOwner];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getListDiagnoseByCarOwner];
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
    
    if ([identifier isEqualToString:@"diagnoseItem"])
    {
        return [self tableView:tableView diagnoseItemCellForIndexPath:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView diagnoseItemCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        WDDiagnoseItemCellView *cellView = [WDDiagnoseItemCellView nibView];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    NSInteger attachIndex = cellInfo.attachIndex;
    WDDiagnoseModel *diagnosisModel = m_diagnoseArray[attachIndex];
    
    WDDiagnoseItemCellView *cellView = (WDDiagnoseItemCellView *)cell.m_subContentView;
    [cellView setDiagnoseModel:diagnosisModel];
    
    if (diagnosisModel.status == WDDiagnoseStatus_MECHANIC_DIAGNOSED
        || diagnosisModel.status == WDDiagnoseStatus_EXPERT_DIAGNOSED)
    {
        [cellView setTipsHidden:NO];
    }
    else
    {
        [cellView setTipsHidden:YES];
    }
    
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

#pragma mark - WDDiagnosisMainAddViewDelegate
-(void)onClickAddNewRecord:(WDDiagnosisMainAddView *)view
{
    [self createDiagnoseByCarOwner];
}

-(void)createDiagnoseByCarOwner
{
    __weak typeof(self) weakSelf = self;
    WDCreateDiagnoseByCarOwnerApi *mfApi = [WDCreateDiagnoseByCarOwnerApi new];
    mfApi.carOwnerId = m_currentUserInfo.userId;
    mfApi.animatingText = @"正在创建维修任务...";
    mfApi.animatingView = MFAppWindow;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        [strongSelf getListDiagnoseByCarOwner];
        
    } failure:^(YTKBaseRequest * request) {
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.requestOperationError.code),[request.requestOperationError localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)getListDiagnoseByCarOwner
{
    __weak typeof(self) weakSelf = self;
    WDListDiagnoseByCarOwnerApi *mfApi = [WDListDiagnoseByCarOwnerApi new];
    mfApi.carOwnerId = m_currentUserInfo.userId;
    mfApi.animatingText = @"正在获取维修任务列表...";
    mfApi.animatingView = MFAppWindow;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *diagnoses = request.responseJSONObject[@"data"];
        NSMutableArray *diagnoseArray = [NSMutableArray array];
        for (int i = 0; i < diagnoses.count; i++) {
            WDDiagnoseModel *itemModel = [WDDiagnoseModel yy_modelWithDictionary:diagnoses[i]];
            [diagnoseArray addObject:itemModel];
        }
        
        m_diagnoseArray = diagnoseArray;
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.requestOperationError.code),[request.requestOperationError localizedDescription]];
        [self showTips:errorDesc];
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
    
    for (int i = 0; i < m_diagnoseArray.count; i++) {
        WDDiagnoseModel *itemModel  = m_diagnoseArray[i];
        
        MFTableViewCellObject *diagnoseModel = [MFTableViewCellObject new];
        diagnoseModel.cellHeight = 150.0f;
        diagnoseModel.cellReuseIdentifier = @"diagnoseItem";
        diagnoseModel.attachIndex = i;
        [m_cellInfos addObject:diagnoseModel];
        
        MFTableViewCellObject *separator = [MFTableViewCellObject new];
        separator.cellHeight = MFOnePixHeight;
        separator.cellReuseIdentifier = @"separator";
        separator.attachIndex = i;
        [m_cellInfos addObject:separator];
    }
}

#pragma mark - WDDiagnoseItemCellViewDelegate
-(void)onClickDiagnoseItemCellView:(WDDiagnoseModel *)itemModel
{
    if (itemModel.status == WDDiagnoseStatus_MECHANIC_DIAGNOSED)
    {
        __weak typeof(self) weakSelf = self;
        LGAlertView *alertView = [LGAlertView alertViewWithTitle:@"提示" message:@"是否确认技师诊断结果?" style:LGAlertViewStyleAlert buttonTitles:@[@"确定"] cancelButtonTitle:@"取消" destructiveButtonTitle:nil actionHandler:^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
            
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf confirmDiagnoseByCarOwner:itemModel];
            
        } cancelHandler:nil destructiveHandler:nil];
        
        [alertView showAnimated:YES completionHandler:nil];
    }
    else if (itemModel.status == WDDiagnoseStatus_EXPERT_DIAGNOSED)
    {
        __weak typeof(self) weakSelf = self;
        LGAlertView *alertView = [LGAlertView alertViewWithTitle:@"提示" message:@"是否确认专家复诊结果?" style:LGAlertViewStyleAlert buttonTitles:@[@"确定"] cancelButtonTitle:@"取消" destructiveButtonTitle:nil actionHandler:^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
            
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf reconfirmAfterExpertDiagnosed:itemModel];
            
        } cancelHandler:nil destructiveHandler:nil];
        
        [alertView showAnimated:YES completionHandler:nil];
    }
}

-(void)confirmDiagnoseByCarOwner:(WDDiagnoseModel *)itemModel
{
    __weak typeof(self) weakSelf = self;
    WDConfirmDiagnoseByCarOwnerApi *mfApi = [WDConfirmDiagnoseByCarOwnerApi new];
    mfApi.carOwnerId = m_currentUserInfo.userId;
    mfApi.diagnoseId = itemModel.diagnoseId;
    mfApi.animatingText = @"确认技师诊断结果...";
    mfApi.animatingView = MFAppWindow;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        [strongSelf showTips:mfApi.errorMessage];
        [strongSelf getListDiagnoseByCarOwner];
        
    } failure:^(YTKBaseRequest * request) {
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.requestOperationError.code),[request.requestOperationError localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)reconfirmAfterExpertDiagnosed:(WDDiagnoseModel *)itemModel
{
    __weak typeof(self) weakSelf = self;
    WDReconfirmAfterExpertDiagnosedApi *mfApi = [WDReconfirmAfterExpertDiagnosedApi new];
    mfApi.carOwnerId = m_currentUserInfo.userId;
    mfApi.diagnoseId = itemModel.diagnoseId;
    mfApi.animatingText = @"确认专家复诊结果...";
    mfApi.animatingView = MFAppWindow;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        [strongSelf showTips:mfApi.errorMessage];
        [strongSelf getListDiagnoseByCarOwner];
        
    } failure:^(YTKBaseRequest * request) {
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.requestOperationError.code),[request.requestOperationError localizedDescription]];
        [self showTips:errorDesc];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
