//
//  WDDiagnoseMechanicCertificationsDetailViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/7/15.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDDiagnoseMechanicCertificationsDetailViewController.h"
#import "WDListDiagnoseMechanicCertificationsApi.h"
#import "WDRepairItemAssignmentModel.h"
#import "WDMechanicCertificationsDetailCellHeaderView.h"
#import "WDMechanicCertificationsDetailCellView.h"

@interface WDDiagnoseMechanicCertificationsDetailViewController () <UITableViewDataSource,UITableViewDelegate>
{
    MFUITableView *m_tableView;
    NSMutableArray<WDRepairItemAssignmentModel *> *m_repairItemAssignmentArray;
}

@end

@implementation WDDiagnoseMechanicCertificationsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"技师认证";
    [self setBackBarButton];
    
    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    m_tableView.backgroundColor = [UIColor hx_colorWithHexString:@"f5f5f5"];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    [self.view addSubview:m_tableView];
    
    [self getDiagnoseMechanicCertifications];
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
    
    if ([identifier isEqualToString:@"assignmentHeader"])
    {
        return [self tableView:tableView repairItemAssignmentHeaderCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"repairItemAssignment"])
    {
        return [self tableView:tableView repairItemAssignmentCellForIndexPath:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView repairItemAssignmentHeaderCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDMechanicCertificationsDetailCellHeaderView *cellView = [[WDMechanicCertificationsDetailCellHeaderView alloc] initWithFrame:cell.contentView.bounds];
        cell.m_subContentView = cellView;
    }
        
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView repairItemAssignmentCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    NSInteger attachIndex = cellInfo.attachIndex;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDMechanicCertificationsDetailCellView *cellView = [[WDMechanicCertificationsDetailCellView alloc] initWithFrame:cell.contentView.bounds];
        cell.m_subContentView = cellView;
    }
    
    WDRepairItemAssignmentModel *repairItemAssignment = m_repairItemAssignmentArray[attachIndex];
    
    WDMechanicCertificationsDetailCellView *cellView = (WDMechanicCertificationsDetailCellView *)cell.m_subContentView;
    [cellView setRepairItemAssignmentModel:repairItemAssignment];
    
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

-(void)getDiagnoseMechanicCertifications
{
    __weak typeof(self) weakSelf = self;
    WDListDiagnoseMechanicCertificationsApi *mfApi = [WDListDiagnoseMechanicCertificationsApi new];
    mfApi.diagnoseId = self.diagnoseId;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSMutableArray *assignmentModelArray = [NSMutableArray array];
        
        NSArray *repairItemAssignments = mfApi.responseNetworkData;
        for (int i = 0; i < repairItemAssignments.count; i++) {
            WDRepairItemAssignmentModel *itemModel = [WDRepairItemAssignmentModel yy_modelWithDictionary:repairItemAssignments[i]];
            [assignmentModelArray addObject:itemModel];
        }
        
        m_repairItemAssignmentArray = assignmentModelArray;
        
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
    
    MFTableViewCellObject *division = [MFTableViewCellObject new];
    division.cellHeight = 15.0f;
    division.cellReuseIdentifier = @"division";
    [m_cellInfos addObject:division];
    
    MFTableViewCellObject *assignmentHeader = [MFTableViewCellObject new];
    assignmentHeader.cellHeight = 70.0f;
    assignmentHeader.cellReuseIdentifier = @"assignmentHeader";
    [m_cellInfos addObject:assignmentHeader];
    
    for (int i = 0; i < m_repairItemAssignmentArray.count; i++) {
        
        MFTableViewCellObject *repairItemAssignment = [MFTableViewCellObject new];
        repairItemAssignment.cellHeight = 150.0f;
        repairItemAssignment.cellReuseIdentifier = @"repairItemAssignment";
        repairItemAssignment.attachIndex = i;
        [m_cellInfos addObject:repairItemAssignment];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
