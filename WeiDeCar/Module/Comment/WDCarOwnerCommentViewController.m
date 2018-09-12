//
//  WDCarOwnerCommentViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/9/11.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDCarOwnerCommentViewController.h"
#import "WDListCommentKpiApi.h"
#import "WDCommentKpiResultVO.h"
#import "WDAddDiagnoseCommentApi.h"
#import "WDiagnoseCommentCellView.h"
#import "WDCarOwnerCommentContentCellView.h"

@interface WDCarOwnerCommentViewController () <UITableViewDataSource,UITableViewDelegate,WDiagnoseCommentCellViewDelegate,WDCarOwnerCommentContentCellViewDelegate>
{
    MFUITableView *m_tableView;
    NSMutableArray<NSDictionary *> *m_commentKpiArray;
    
    NSMutableDictionary *m_commentKpiInfo;
    
    NSString *m_commentContent;
}

@end

@implementation WDCarOwnerCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"车主评价";
    [self setBackBarButton];
    [self setRightNaviButtonWithTitle:@"维修厂" action:@selector(submitCarOwnerComment)];
    
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
    
    m_cellInfos = [NSMutableArray array];
    m_commentKpiInfo = [NSMutableDictionary dictionary];
    
    [self getCommentKpiList];
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
    
    if ([identifier isEqualToString:@"diagnoseComment"])
    {
        return [self tableView:tableView diagnoseCommentCellForIndex:indexPath];
    }
    else if ([identifier isEqualToString:@"carOwnerComment"])
    {
        return [self tableView:tableView carOwnerCommentCellForIndex:indexPath];
    }
    else if ([identifier isEqualToString:@"division"])
    {
        return [self tableView:tableView divisionForIndex:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView carOwnerCommentCellForIndex:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDCarOwnerCommentContentCellView *cellView = [[WDCarOwnerCommentContentCellView alloc] initWithFrame:cell.contentView.bounds];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    WDCarOwnerCommentContentCellView *cellView = (WDCarOwnerCommentContentCellView *)cell.m_subContentView;
    [cellView setCommentContent:m_commentContent];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView diagnoseCommentCellForIndex:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    NSInteger attachIndex = cellInfo.attachIndex;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDiagnoseCommentCellView *cellView = [[WDiagnoseCommentCellView alloc] initWithFrame:cell.contentView.bounds];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    NSDictionary *kpiInfo = m_commentKpiArray[attachIndex];
    
    WDiagnoseCommentCellView *cellView = (WDiagnoseCommentCellView *)cell.m_subContentView;
    cellView.attachDataIndex = attachIndex;
    
    NSString *dicValue = kpiInfo[@"dicValue"];
    NSString *scoreKey = [NSString stringWithFormat:@"%@",@(attachIndex)];
    NSNumber *scoreValue = m_commentKpiInfo[scoreKey];
    [cellView setCommentValue:dicValue score:scoreValue.floatValue];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView divisionForIndex:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    return cellInfo.cellHeight;
}

-(void)getCommentKpiList
{
    __weak typeof(self) weakSelf = self;
    WDListCommentKpiApi *mfApi = [WDListCommentKpiApi new];
    mfApi.commentType = WDDiagnose_commentType_10;
    
    mfApi.animatingView = self.view;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSMutableArray *kpiArray = [NSMutableArray array];
        NSArray *kpiLists = mfApi.responseNetworkData;
        for (int i = 0; i < kpiLists.count; i++) {
            NSDictionary *kpi = kpiLists[i];
            [kpiArray addObject:kpi];
        }
        
        m_commentKpiArray = kpiArray;
        [strongSelf initDefaultCommentKpi];
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
    
    [m_cellInfos addObject:[self divisionCellObject:15.0f]];
    
    for (int i = 0; i < m_commentKpiArray.count; i++) {
        MFTableViewCellObject *diagnoseComment = [MFTableViewCellObject new];
        diagnoseComment.cellHeight = 50.0f;
        diagnoseComment.cellReuseIdentifier = @"diagnoseComment";
        diagnoseComment.attachIndex = i;
        [m_cellInfos addObject:diagnoseComment];
    }
    
    MFTableViewCellObject *carOwnerComment = [MFTableViewCellObject new];
    carOwnerComment.cellHeight = 120.0f;
    carOwnerComment.cellReuseIdentifier = @"carOwnerComment";
    [m_cellInfos addObject:carOwnerComment];
}

-(MFTableViewCellObject *)divisionCellObject:(CGFloat)cellHeight
{
    MFTableViewCellObject *division = [MFTableViewCellObject new];
    division.cellHeight = cellHeight;
    division.cellReuseIdentifier = @"division";
    return division;
}

-(void)initDefaultCommentKpi
{
    for (int i = 0; i < m_commentKpiArray.count; i++) {
        NSString *key = [NSString stringWithFormat:@"%@",@(i)];
        [m_commentKpiInfo safeSetObject:@(1) forKey:key];
    }
}

#pragma mark - WDiagnoseCommentCellViewDelegate
-(void)onClickChangeScore:(CGFloat)score attachDataIndex:(NSInteger)index cellView:(WDiagnoseCommentCellView *)cellView
{
    NSString *key = [NSString stringWithFormat:@"%@",@(index)];
    [m_commentKpiInfo safeSetObject:@(score) forKey:key];
}

#pragma mark - WDCarOwnerCommentContentCellViewDelegate
-(void)onInputComment:(NSString *)commentContent inputView:(WDCarOwnerCommentContentCellView *)inputView
{
    m_commentContent = commentContent;
}

-(void)submitCarOwnerComment
{
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    WDAddDiagnoseCommentApi *mfApi = [WDAddDiagnoseCommentApi new];
    mfApi.diagnoseId = self.diagnoseId;
    mfApi.userId = loginService.currentUserInfo.userId;
    mfApi.commentType = WDDiagnose_commentType_10;
    mfApi.commentContent = m_commentContent;
    
    mfApi.animatingView = self.view;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        
        
    } failure:^(YTKBaseRequest * request) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
