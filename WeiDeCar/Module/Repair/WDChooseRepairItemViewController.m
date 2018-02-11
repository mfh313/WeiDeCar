//
//  WDChooseRepairItemViewController.m
//  WeiDeCar
//
//  Created by EEKA on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDChooseRepairItemViewController.h"
#import "WDListRepairItemOffersApi.h"
#import "WDRepairItemOfferListModel.h"
#import "WDRepairItemOfferHeaderView.h"
#import "WDRepairOfferHeaderTitleView.h"
#import "WDChooseRepairItemOffersApi.h"

@interface WDChooseRepairItemViewController () <UITableViewDataSource,UITableViewDelegate,WDRepairItemOfferHeaderViewDelegate>
{
    MFUITableView *m_tableView;
    
    NSMutableArray<WDRepairItemOfferListModel *> *m_repairItemOffers;
}

@end

@implementation WDChooseRepairItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"维修报价表";
    [self setBackBarButton];
    
    self.view.backgroundColor = [UIColor hx_colorWithHexString:@"f5f5f5"];
    
    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    m_tableView.backgroundColor = [UIColor hx_colorWithHexString:@"f5f5f5"];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    [self.view addSubview:m_tableView];
    [m_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.width.equalTo(self.view.mas_width);
        make.bottom.equalTo(self.view.mas_bottom).offset(-60);;
    }];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"确认并结算" forState:UIControlStateNormal];
    [submitButton setBackgroundImage:MFImageStretchCenter(@"btn_blue_normal") forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(onClickChooseRepairItemOffers) forControlEvents:UIControlEventTouchUpInside];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:submitButton];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
    }];

    [self getListRepairItemOffers];
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
    
    if ([identifier isEqualToString:@"repairManInfo"])
    {
        return [self tableView:tableView repairManInfoCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"repairItemHeader"])
    {
        return [self tableView:tableView repairItemHeaderCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"repairItemHeaderTitle"])
    {
        return [self tableView:tableView repairItemHeaderTitleCellForIndexPath:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView repairItemHeaderCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDRepairItemOfferHeaderView *cellView = [WDRepairItemOfferHeaderView nibView];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    NSInteger attachIndex = cellInfo.attachIndex;
    WDRepairItemOfferListModel *repairItemOffer = m_repairItemOffers[attachIndex];
    
    WDRepairItemOfferHeaderView *cellView = (WDRepairItemOfferHeaderView *)cell.m_subContentView;
    [cellView setRepairItemOfferListModel:repairItemOffer];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView repairItemHeaderTitleCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    NSArray *titleArray = @[@"配件/工时",@"价格",@"维修方"];
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDRepairOfferHeaderTitleView *cellView = [[WDRepairOfferHeaderTitleView alloc] initWithFrame:cell.contentView.bounds columnCount:titleArray.count];
        cell.m_subContentView = cellView;
    }
    
    WDRepairOfferHeaderTitleView *cellView = (WDRepairOfferHeaderTitleView *)cell.m_subContentView;
    [cellView setTitleArray:titleArray];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView repairManInfoCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((CGRectGetWidth(cell.contentView.frame) - 200) /2 , 0, 200, CGRectGetHeight(cell.contentView.frame));
        button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        [button setTitle:@"查看维修人员详情" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor hx_colorWithHexString:@"242834"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onClickShowRepairManInfo) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
        
        UIImageView *accessoryImageView = [[UIImageView alloc] initWithImage:MFImage(@"common_btn_next_nor")];
        [cell.contentView addSubview:accessoryImageView];
        [accessoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(cell.contentView.mas_right).offset(-15);
            make.centerY.mas_equalTo(cell.contentView.mas_centerY);
            make.width.mas_equalTo(22);
            make.height.mas_equalTo(22);
        }];
    }
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

-(void)getListRepairItemOffers
{
    __weak typeof(self) weakSelf = self;
    WDListRepairItemOffersApi *mfApi = [WDListRepairItemOffersApi new];
    mfApi.diagnoseId = self.diagnoseId;
    
    mfApi.animatingView = self.view;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *responseNetworkData = mfApi.responseNetworkData;
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = 0; i < responseNetworkData.count; i++) {
            WDRepairItemOfferListModel *itemModel = [WDRepairItemOfferListModel yy_modelWithDictionary:responseNetworkData[i]];
            itemModel.status = WDRepairItemOfferStatus_20;
            [tempArray addObject:itemModel];
        }

        m_repairItemOffers = tempArray;

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
    
    MFTableViewCellObject *repairManInfo = [MFTableViewCellObject new];
    repairManInfo.cellHeight = 50.0f;
    repairManInfo.cellReuseIdentifier = @"repairManInfo";
    [m_cellInfos addObject:repairManInfo];
    
    [m_cellInfos addObject:[self divisionCellObject:15.0f]];
    
    for (int i = 0; i < m_repairItemOffers.count; i++) {
        
        MFTableViewCellObject *repairItemHeader = [MFTableViewCellObject new];
        repairItemHeader.cellHeight = 70.0f;
        repairItemHeader.cellReuseIdentifier = @"repairItemHeader";
        repairItemHeader.attachIndex = i;
        [m_cellInfos addObject:repairItemHeader];
        [m_cellInfos addObject:[self separatorCellObject:i]];
        
        MFTableViewCellObject *repairItemHeaderTitle = [MFTableViewCellObject new];
        repairItemHeaderTitle.cellHeight = 40.0f;
        repairItemHeaderTitle.cellReuseIdentifier = @"repairItemHeaderTitle";
        repairItemHeaderTitle.attachIndex = i;
        [m_cellInfos addObject:repairItemHeaderTitle];
        
        [self setInnerRepairItemOffer:i];
        
        [m_cellInfos addObject:[self divisionCellObject:15.0f]];
    }
}

-(void)setInnerRepairItemOffer:(NSInteger)index
{
    WDRepairItemOfferListModel *repairItem = m_repairItemOffers[index];
    NSMutableArray<WDRepairItemOfferModel *> *repairItemOffers = repairItem.repairItemOffers;
    
    for (int i = 0; i < repairItemOffers.count; i++)
    {
        [m_cellInfos addObject:[self separatorCellObject:i]];
        
        MFTableViewCellObject *offerOfBetter = [MFTableViewCellObject new];
        offerOfBetter.cellHeight = 40.0f;
        offerOfBetter.cellReuseIdentifier = @"repairItem";
        offerOfBetter.attachKey = @"offerOfBetter";
        offerOfBetter.attachIndex = i;
        [m_cellInfos addObject:offerOfBetter];
        
        [m_cellInfos addObject:[self separatorCellObject:i]];
        
        MFTableViewCellObject *offerOf4s = [MFTableViewCellObject new];
        offerOf4s.cellHeight = 40.0f;
        offerOf4s.cellReuseIdentifier = @"repairItem";
        offerOf4s.attachKey = @"offerOf4s";
        offerOf4s.attachIndex = i;
        [m_cellInfos addObject:offerOf4s];
        
        [m_cellInfos addObject:[self separatorCellObject:i]];
        
        MFTableViewCellObject *offerOfSpecialty = [MFTableViewCellObject new];
        offerOfSpecialty.cellHeight = 40.0f;
        offerOfSpecialty.cellReuseIdentifier = @"repairItem";
        offerOfSpecialty.attachKey = @"offerOfSpecialty";
        offerOfSpecialty.attachIndex = i;
        [m_cellInfos addObject:offerOfSpecialty];
        
        [m_cellInfos addObject:[self divisionCellObject:5]];
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

#pragma mark - WDRepairItemOfferHeaderViewDelegate
-(void)onClickSelectRepairItemOffer:(WDRepairItemOfferListModel *)itemModel headerView:(WDRepairItemOfferHeaderView *)headerView
{
    if (itemModel.status == WDRepairItemOfferStatus_10)
    {
        itemModel.status = WDRepairItemOfferStatus_20;
    }
    else
    {
        itemModel.status = WDRepairItemOfferStatus_10;
    }
    
    [headerView setRepairItemOfferStatus:itemModel];
}

-(void)onClickShowRepairManInfo
{
    [self showTips:@"查看维修人员详情"];
}

-(void)onClickChooseRepairItemOffers
{
    NSMutableArray<WDRepairItemOfferListModel *> *selectRepairItemOffers = [NSMutableArray array];
    
    for (int i = 0; i < m_repairItemOffers.count; i++) {
        
        WDRepairItemOfferListModel *itemModel = m_repairItemOffers[i];
        
        if (itemModel.status == WDRepairItemOfferStatus_20)
        {
            [selectRepairItemOffers addObject:itemModel];
        }
    }
    
    if (selectRepairItemOffers.count == 0) {
        [self showTips:@"请选择维修项目"];
        return;
    }
    
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    WDChooseRepairItemOffersApi *mfApi = [WDChooseRepairItemOffersApi new];
    mfApi.carOwnerId = loginService.currentUserInfo.userId;
    mfApi.diagnoseId = self.diagnoseId;
    mfApi.selectOfferItems = selectRepairItemOffers;
    
    mfApi.animatingView = self.view;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *responseNetworkData = mfApi.responseNetworkData;
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = 0; i < responseNetworkData.count; i++) {
            WDRepairItemOfferListModel *itemModel = [WDRepairItemOfferListModel yy_modelWithDictionary:responseNetworkData[i]];
            itemModel.status = WDRepairItemOfferStatus_20;
            [tempArray addObject:itemModel];
        }
        
        m_repairItemOffers = tempArray;
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
