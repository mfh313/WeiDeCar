//
//  WDRepairListViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/11.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairListViewController.h"
#import "WDRepairItemModel.h"
#import "WDListRepairItemApi.h"
#import "WDMechanicStartRepairApi.h"
#import "WDRepairItemCellView.h"
#import "WDRepairItemActionCellView.h"
#import "WDRepairStepListViewController.h"

@interface WDRepairListViewController () <UITableViewDataSource,UITableViewDelegate,WDRepairItemActionCellViewDelegate>
{
    MFUITableView *m_tableView;
    
    NSMutableArray<WDRepairItemModel *> *m_repairItems;
}

@end

@implementation WDRepairListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"维修项目列表";
    [self setBackBarButton];
    
    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    m_tableView.backgroundColor = [UIColor hx_colorWithHexString:@"f5f5f5"];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    [self.view addSubview:m_tableView];
    [m_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.width.equalTo(self.view.mas_width);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    [self getRepairItemList];
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
    
    if ([identifier isEqualToString:@"repairItem"])
    {
        return [self tableView:tableView repairItemCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"repairItemAction"])
    {
        return [self tableView:tableView repairItemActionCellForIndexPath:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView repairItemActionCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    NSInteger attachIndex = cellInfo.attachIndex;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDRepairItemActionCellView *cellView = [[WDRepairItemActionCellView alloc] initWithFrame:cell.contentView.bounds];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    WDRepairItemModel *repairItem = m_repairItems[attachIndex];
    
    WDRepairItemActionCellView *cellView = (WDRepairItemActionCellView *)cell.m_subContentView;
    [cellView setRepairItemModel:repairItem];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView repairItemCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    NSInteger attachIndex = cellInfo.attachIndex;
    NSString *attachKey = cellInfo.attachKey;
    
    WDRepairItemModel *repairItem = m_repairItems[attachIndex];

    NSMutableArray *titleArray = [NSMutableArray array];
    
    NSString *title = @"";
    NSString *subTitle = @"";
    
    if ([attachKey isEqualToString:@"repairItemName"]) {
        title = @"维修项目";
        subTitle = repairItem.repairItemName;
    }
    else if ([attachKey isEqualToString:@"carOwnerName"])
    {
        title = @"车主";
        subTitle = repairItem.repairTask.carOwnerName;
    }
    else if ([attachKey isEqualToString:@"expertName"])
    {
        title = @"指导专家";
        subTitle = repairItem.repairTask.expertName;
    }
    
    [titleArray addObject:title];
    [titleArray addObject:subTitle];
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDRepairItemCellView *cellView = [[WDRepairItemCellView alloc] initWithFrame:cell.contentView.bounds];
        cell.m_subContentView = cellView;
    }
    
    WDRepairItemCellView *cellView = (WDRepairItemCellView *)cell.m_subContentView;
    [cellView setTitleArray:titleArray];
    
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

-(void)getRepairItemList
{
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    WDListRepairItemApi *mfApi = [WDListRepairItemApi new];
    mfApi.userId = loginService.currentUserInfo.userId;
    mfApi.diagnoseId = self.diagnoseId;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *responseNetworkData = mfApi.responseNetworkData;
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = 0; i < responseNetworkData.count; i++) {
            WDRepairItemModel *itemModel = [WDRepairItemModel yy_modelWithDictionary:responseNetworkData[i]];
            [tempArray addObject:itemModel];
        }
        
        m_repairItems = tempArray;
        
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
    
    for (int i = 0; i < m_repairItems.count; i++) {
        
        [m_cellInfos addObject:[self divisionCellObject:15.0f]];
        
        [m_cellInfos addObject:[self separatorCellObject:i]];
        
        MFTableViewCellObject *repairItemName = [MFTableViewCellObject new];
        repairItemName.cellHeight = 40.0f;
        repairItemName.cellReuseIdentifier = @"repairItem";
        repairItemName.attachKey = @"repairItemName";
        repairItemName.attachIndex = i;
        [m_cellInfos addObject:repairItemName];
        
        [m_cellInfos addObject:[self separatorCellObject:i]];
        
        MFTableViewCellObject *carOwnerName = [MFTableViewCellObject new];
        carOwnerName.cellHeight = 40.0f;
        carOwnerName.cellReuseIdentifier = @"repairItem";
        carOwnerName.attachKey = @"carOwnerName";
        carOwnerName.attachIndex = i;
        [m_cellInfos addObject:carOwnerName];
        
        [m_cellInfos addObject:[self separatorCellObject:i]];
        
        MFTableViewCellObject *expertName = [MFTableViewCellObject new];
        expertName.cellHeight = 40.0f;
        expertName.cellReuseIdentifier = @"repairItem";
        expertName.attachKey = @"expertName";
        expertName.attachIndex = i;
        [m_cellInfos addObject:expertName];
        
        [m_cellInfos addObject:[self separatorCellObject:i]];
        
        MFTableViewCellObject *repairItemAction = [MFTableViewCellObject new];
        repairItemAction.cellHeight = 60.0f;
        repairItemAction.cellReuseIdentifier = @"repairItemAction";
        repairItemAction.attachIndex = i;
        [m_cellInfos addObject:repairItemAction];
    }
}

-(MFTableViewCellObject *)separatorCellObject:(NSInteger)index
{
    MFTableViewCellObject *separator = [MFTableViewCellObject new];
    separator.cellHeight = MFOnePixHeight;
    separator.cellReuseIdentifier = @"separator";
    separator.attachIndex = index;
    return separator;
}

-(MFTableViewCellObject *)divisionCellObject:(CGFloat)cellHeight
{
    MFTableViewCellObject *division = [MFTableViewCellObject new];
    division.cellHeight = cellHeight;
    division.cellReuseIdentifier = @"division";
    return division;
}

#pragma mark - WDRepairItemActionCellViewDelegate
-(void)onClickSelectRepairItem:(WDRepairItemModel *)repairItem cellView:(WDRepairItemActionCellView *)cellView
{
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    WDUserInfoModel *currentUserInfo = loginService.currentUserInfo;
    if (currentUserInfo.userType == WDUserInfoType_Mechanic)
    {
        [self startRepairItem:repairItem];
    }
    else
    {
        [self showRepairItemStep:repairItem];
    }
}

-(void)showRepairItemStep:(WDRepairItemModel *)repairItem
{
    WDRepairStepListViewController *repairStepVC = [WDRepairStepListViewController new];
    repairStepVC.repairItemId = repairItem.repairItemId;
    [self.navigationController pushViewController:repairStepVC animated:YES];
}

-(void)startRepairItem:(WDRepairItemModel *)repairItem
{
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    WDMechanicStartRepairApi *mfApi = [WDMechanicStartRepairApi new];
    mfApi.mechanicId = loginService.currentUserInfo.userId;
    mfApi.repairItemId = repairItem.repairItemId;
    
    mfApi.animatingView = self.view;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        [strongSelf showTips:mfApi.errorMessage];
        
        [strongSelf getRepairItemList];
        
    } failure:^(YTKBaseRequest * request) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
