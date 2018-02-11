//
//  WDRepairItemListViewController.m
//  WeiDeCar
//
//  Created by EEKA on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairItemListViewController.h"
#import "WDRepairTaskListCellView.h"
#import "WDListRepairTaskByUserApi.h"
#import "WDDiagnoseModel.h"
#import "WDChooseRepairItemViewController.h"
#import "WDRepairListViewController.h"

@interface WDRepairItemListViewController () <UITableViewDataSource,UITableViewDelegate,WDRepairTaskListCellViewDelegate>
{
    MFUITableView *m_tableView;
    
    NSMutableArray *m_repairItems;
}

@end

@implementation WDRepairItemListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"维修任务列表";
    [self setBackBarButton];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    m_tableView.backgroundColor = [UIColor hx_colorWithHexString:@"f5f5f5"];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    [self.view addSubview:m_tableView];
    [m_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.width.equalTo(self.view.mas_width);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    __weak typeof(self) weakSelf = self;
    [m_tableView addPullToRefreshWithActionHandler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf getListRepairTaskByUser];
    }];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getListRepairTaskByUser];
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
    
    if ([identifier isEqualToString:@"repairTask"])
    {
        return [self tableView:tableView repairTaskCellForIndexPath:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView repairTaskCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        WDRepairTaskListCellView *cellView = [WDRepairTaskListCellView nibView];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    NSInteger attachIndex = cellInfo.attachIndex;
    WDDiagnoseModel *diagnosisModel = m_repairItems[attachIndex];
    
    WDRepairTaskListCellView *cellView = (WDRepairTaskListCellView *)cell.m_subContentView;
    [cellView setRepairDiagnoseModel:diagnosisModel];
    
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

-(void)getListRepairTaskByUser
{
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    WDListRepairTaskByUserApi *mfApi = [WDListRepairTaskByUserApi new];
    mfApi.currentUser = loginService.currentUserInfo;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *responseNetworkData = mfApi.responseNetworkData;
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (int i = 0; i < responseNetworkData.count; i++) {
            WDDiagnoseModel *itemModel = [WDDiagnoseModel yy_modelWithDictionary:responseNetworkData[i]];
            [tempArray addObject:itemModel];
        }
        
        m_repairItems = tempArray;
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        [m_tableView.pullToRefreshView stopAnimating];
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
    
    for (int i = 0; i < m_repairItems.count; i++) {

        MFTableViewCellObject *repairTask = [MFTableViewCellObject new];
        repairTask.cellHeight = 150.0f;
        repairTask.cellReuseIdentifier = @"repairTask";
        repairTask.attachIndex = i;
        [m_cellInfos addObject:repairTask];

        MFTableViewCellObject *separator = [MFTableViewCellObject new];
        separator.cellHeight = MFOnePixHeight;
        separator.cellReuseIdentifier = @"separator";
        separator.attachIndex = i;
        [m_cellInfos addObject:separator];
    }
}

#pragma mark - WDRepairTaskListCellViewDelegate
-(void)onClickRepairTaskCellView:(WDDiagnoseModel *)itemModel
{
    [self showRepairListVC:itemModel];
//    [self showChooseRepairItemVC:itemModel];
}

-(void)showChooseRepairItemVC:(WDDiagnoseModel *)itemModel
{
    WDChooseRepairItemViewController *chooseRepairVC = [WDChooseRepairItemViewController new];
    chooseRepairVC.diagnoseId = itemModel.diagnoseId;
    [self.navigationController pushViewController:chooseRepairVC animated:YES];
}

-(void)showRepairListVC:(WDDiagnoseModel *)itemModel
{
    WDRepairListViewController *repairVC = [WDRepairListViewController new];
    repairVC.diagnoseId = itemModel.diagnoseId;
    [self.navigationController pushViewController:repairVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
