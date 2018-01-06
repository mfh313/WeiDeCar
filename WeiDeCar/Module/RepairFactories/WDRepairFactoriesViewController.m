//
//  WDRepairFactoriesViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/1/6.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairFactoriesViewController.h"
#import "WDRepairFactoryMapViewController.h"
#import "WDRepairFactoryModel.h"
#import "WDListRepairFactoriesApi.h"

@interface WDRepairFactoriesViewController () <UITableViewDataSource,UITableViewDelegate>
{
    MFUITableView *m_tableView;
    
    NSMutableArray<WDRepairFactoryModel *> *m_repairFactorys;
}

@end

@implementation WDRepairFactoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修理厂列表";
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
        [strongSelf getListRepairFactories];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getListRepairFactories];
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
    
    if ([identifier isEqualToString:@"repairFactory"])
    {
        return [self tableView:tableView repairFactoryItemCellForIndexPath:indexPath];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSInteger attachIndex = cellInfo.attachIndex;
    
    WDRepairFactoryModel *itemModel = m_repairFactorys[attachIndex];
    [self showRepairFactoryLocation:itemModel];
}

-(UITableViewCell *)tableView:(UITableView *)tableView repairFactoryItemCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
//        WDDiagnoseItemCellView *cellView = [WDDiagnoseItemCellView nibView];
//        cellView.m_delegate = self;
//        cell.m_subContentView = cellView;
    }
    
    NSInteger attachIndex = cellInfo.attachIndex;
    WDRepairFactoryModel *itemModel = m_repairFactorys[attachIndex];
    
//    WDDiagnoseItemCellView *cellView = (WDDiagnoseItemCellView *)cell.m_subContentView;
//    [cellView setDiagnoseModel:diagnosisModel];
    
    cell.textLabel.text = itemModel.entityName;
    
    return cell;
}

-(void)getListRepairFactories
{
    __weak typeof(self) weakSelf = self;
    WDListRepairFactoriesApi *mfApi = [WDListRepairFactoriesApi new];
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *datas = request.responseJSONObject[@"data"];
        NSMutableArray *repairFactorys = [NSMutableArray array];
        for (int i = 0; i < datas.count; i++) {
            WDRepairFactoryModel *itemModel = [WDRepairFactoryModel yy_modelWithDictionary:datas[i]];
            [repairFactorys addObject:itemModel];
        }
        
        m_repairFactorys = repairFactorys;
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        
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
    
    for (int i = 0; i < m_repairFactorys.count; i++) {
        WDRepairFactoryModel *itemModel  = m_repairFactorys[i];
        
        MFTableViewCellObject *repairFactory = [MFTableViewCellObject new];
        repairFactory.cellHeight = 60.0f;
        repairFactory.cellReuseIdentifier = @"repairFactory";
        repairFactory.attachIndex = i;
        [m_cellInfos addObject:repairFactory];
    }
}

-(void)showRepairFactoryLocation:(WDRepairFactoryModel *)repairFactory
{
    WDRepairFactoryMapViewController *locationVC = [WDRepairFactoryMapViewController new];
    locationVC.repairFactory = repairFactory;
    [self.navigationController pushViewController:locationVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
