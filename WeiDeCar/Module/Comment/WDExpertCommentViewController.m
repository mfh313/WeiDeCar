//
//  WDExpertCommentViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/9/11.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDExpertCommentViewController.h"
#import "WDListCommentKpiApi.h"
#import "WDCommentKpiResultVO.h"
#import "WDAddDiagnoseCommentApi.h"
#import "WDiagnoseCommentCellView.h"
#import "WDExpertCommentContentCellView.h"
#import "WDListCommentBonusApi.h"

@interface WDExpertCommentViewController () <UITableViewDataSource,UITableViewDelegate,WDiagnoseCommentCellViewDelegate,WDExpertCommentContentCellViewDelegate>
{
    MFUITableView *m_tableView;
    NSMutableArray<NSDictionary *> *m_commentKpiArray;
    NSMutableArray<NSDictionary *> *m_commentBonusArray;
    
    NSMutableDictionary *m_commentKpiInfo;
    
    NSString *m_commentContent;
    NSString *m_bonus;
}

@end

@implementation WDExpertCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"专家评价";
    [self setBackBarButton];
    [self setRightNaviButtonWithTitle:@"确定" action:@selector(submitExpertComment)];
    
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
    [self getCommentBonusList];
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
    else if ([identifier isEqualToString:@"expertComment"])
    {
        return [self tableView:tableView expertCommentCellForIndex:indexPath];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    return cellInfo.cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView expertCommentCellForIndex:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDExpertCommentContentCellView *cellView = [[WDExpertCommentContentCellView alloc] initWithFrame:cell.contentView.bounds];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    WDExpertCommentContentCellView *cellView = (WDExpertCommentContentCellView *)cell.m_subContentView;
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

-(void)getCommentKpiList
{
    __weak typeof(self) weakSelf = self;
    WDListCommentKpiApi *mfApi = [WDListCommentKpiApi new];
    mfApi.commentType = WDDiagnose_commentType_20;
    
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
    
    MFTableViewCellObject *expertComment = [MFTableViewCellObject new];
    expertComment.cellHeight = 120.0f;
    expertComment.cellReuseIdentifier = @"expertComment";
    [m_cellInfos addObject:expertComment];
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

#pragma mark - WDExpertCommentContentCellViewDelegate
-(void)onInputComment:(NSString *)commentContent inputView:(WDExpertCommentContentCellView *)inputView
{
    m_commentContent = commentContent;
}

-(void)submitExpertComment
{
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    
    NSMutableArray<WDCommentKpiResultVO *> *comments = [self submitComments];
    
    __weak typeof(self) weakSelf = self;
    WDAddDiagnoseCommentApi *mfApi = [WDAddDiagnoseCommentApi new];
    mfApi.diagnoseId = self.diagnoseId;
    mfApi.userId = loginService.currentUserInfo.userId;
    mfApi.commentType = WDDiagnose_commentType_20;
    mfApi.comments = comments;
    mfApi.bonus = m_bonus;
    mfApi.commentContent = m_commentContent;
    
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

-(NSMutableArray<WDCommentKpiResultVO *> *)submitComments
{
    NSMutableArray *submitComments = [NSMutableArray array];
    
    for (int i = 0; i < m_commentKpiArray.count; i++) {
        NSDictionary *kpiInfo = m_commentKpiArray[i];
        NSString *commentKpi = kpiInfo[@"dicKey"];
        
        NSString *key = [NSString stringWithFormat:@"%@",@(i)];
        NSNumber *score = m_commentKpiInfo[key];
        
        WDCommentKpiResultVO *resultVO = [WDCommentKpiResultVO new];
        resultVO.commentKpi = commentKpi;
        resultVO.commentKpiResult = score.integerValue;
        
        [submitComments addObject:resultVO];
    }
    
    return submitComments;
}

-(void)getCommentBonusList
{
    __weak typeof(self) weakSelf = self;
    WDListCommentBonusApi *mfApi = [WDListCommentBonusApi new];
    mfApi.commentType = WDDiagnose_commentType_20;
    
    mfApi.animatingView = self.view;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }

        NSMutableArray *bonusArray = [NSMutableArray array];
        NSArray *bonusLists = mfApi.responseNetworkData;
        for (int i = 0; i < bonusLists.count; i++) {
            NSDictionary *bonus = bonusLists[i];
            [bonusArray addObject:bonus];
        }
        
        m_commentBonusArray = bonusArray;
        
    } failure:^(YTKBaseRequest * request) {
        
    }];
}

-(void)onClickSelectBonusList
{
    NSMutableArray *bonusTitleArray = [NSMutableArray array];
    for (int i = 0; i < m_commentBonusArray.count; i++) {
        NSDictionary *bonusInfo = m_commentBonusArray[i];
        NSString *dicValue = bonusInfo[@"dicValue"];
        [bonusTitleArray addObject:dicValue];
    }
    
    NSArray *titleArray = [NSArray arrayWithArray:bonusTitleArray];
    
    LGAlertView *alertView = [LGAlertView alertViewWithTitle:@"提示" message:@"选择技师奖金" style:LGAlertViewStyleAlert buttonTitles:titleArray cancelButtonTitle:@"取消" destructiveButtonTitle:nil actionHandler:^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title)
                              {
                                  NSDictionary *bonusInfo = m_commentBonusArray[index];
                                  NSString *dicKey = bonusInfo[@"dicKey"];
                                  m_bonus = dicKey;
                                  [self submitExpertComment];
                              }
                                               cancelHandler:nil destructiveHandler:nil];
    
    [alertView showAnimated:YES completionHandler:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
