//
//  WDDiagnoseCommentViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/11/1.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDDiagnoseCommentViewController.h"
#import "WDGetDiagnoseCommentApi.h"
#import "WDCommentKpiResultVO.h"
#import "WDCarOwnerCommentViewController.h"
#import "WDExpertCommentViewController.h"
#import "WDUserDiagnoseCommentVO.h"
#import "WDiagnoseCommentCellView.h"
#import "WDiagnoseCommentContentCellView.h"

@interface WDDiagnoseCommentViewController () <UITableViewDataSource,UITableViewDelegate,WDiagnoseCommentCellViewDelegate>
{
    WDUserDiagnoseCommentVO *m_carOwnerComment;
    WDUserDiagnoseCommentVO *m_expertComment;
    
    MFUITableView *m_tableView;
}

@end


@implementation WDDiagnoseCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"评价";
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
    
    m_cellInfos = [NSMutableArray array];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getCarOwnerAndExpertComment];
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
    else if ([identifier isEqualToString:@"kpiComment"])
    {
        return [self tableView:tableView kpiCommentCellForIndex:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView diagnoseCommentCellForIndex:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    NSString *attachKey = cellInfo.attachKey;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDiagnoseCommentContentCellView *cellView = [[WDiagnoseCommentContentCellView alloc] initWithFrame:cell.contentView.bounds];
        cell.m_subContentView = cellView;
    }
    
    WDiagnoseCommentContentCellView *cellView = (WDiagnoseCommentContentCellView *)cell.m_subContentView;
    if ([attachKey isEqualToString:@"carOwner"]) {
        WDDiagnoseCommentVO *comment = m_carOwnerComment.comment;
        [cellView setUserTitle:@"车主的评价" commentContent:comment.commentContent];
    }
    else if ([attachKey isEqualToString:@"expert"])
    {
        WDDiagnoseCommentVO *comment = m_expertComment.comment;
        [cellView setUserTitle:@"专家的评价" commentContent:comment.commentContent];
    }
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView kpiCommentCellForIndex:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    NSString *attachKey = cellInfo.attachKey;
    NSInteger attachIndex = cellInfo.attachIndex;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDiagnoseCommentCellView *cellView = [[WDiagnoseCommentCellView alloc] initWithFrame:cell.contentView.bounds];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    WDiagnoseCommentCellView *cellView = (WDiagnoseCommentCellView *)cell.m_subContentView;
    cellView.attachDataIndex = attachIndex;
    
    cellView.userInteractionEnabled = NO;
    
    if ([attachKey isEqualToString:@"carOwner"])
    {
        NSMutableArray<WDDiagnoseCommentDetailVO *> *details = m_carOwnerComment.details;
        WDDiagnoseCommentDetailVO *itemDetail = details[attachIndex];
        
        [cellView setCommentValue:itemDetail.kpiKeyName score:itemDetail.kpiResult];
    }
    else if ([attachKey isEqualToString:@"expert"])
    {
        NSMutableArray<WDDiagnoseCommentDetailVO *> *details = m_expertComment.details;
        WDDiagnoseCommentDetailVO *itemDetail = details[attachIndex];
        
        [cellView setCommentValue:itemDetail.kpiKeyName score:itemDetail.kpiResult];
    }

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

-(void)setRightAddCommentButton
{
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    WDUserInfoModel *currentUserInfo = loginService.currentUserInfo;
    
    if (currentUserInfo.userType == WDUserInfoType_CarOwner && m_carOwnerComment == nil)
    {
        [self setRightNaviButtonWithTitle:@"新增" action:@selector(showCarOwnerCommentVC)];
    }
    else if (currentUserInfo.userType == WDUserInfoType_Expert && m_expertComment == nil)
    {
        [self setRightNaviButtonWithTitle:@"新增" action:@selector(showExpertCommentVC)];
    }
}

-(void)getCarOwnerAndExpertComment
{
    __weak typeof(self) weakSelf = self;
    WDGetDiagnoseCommentApi *mfApi = [WDGetDiagnoseCommentApi new];
    mfApi.diagnoseId = self.diagnoseId;
    
    mfApi.animatingView = self.view;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSDictionary *responseNetworkData = mfApi.responseNetworkData;
        m_carOwnerComment = [WDUserDiagnoseCommentVO yy_modelWithDictionary:responseNetworkData[@"carOwner"]];
        
        m_expertComment = [WDUserDiagnoseCommentVO yy_modelWithDictionary:responseNetworkData[@"expert"]];
        
        [strongSelf reloadTableView];
        [strongSelf setRightAddCommentButton];
        
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
    
    if (m_carOwnerComment)
    {
        NSMutableArray<WDDiagnoseCommentDetailVO *> *carOwnerDetails = m_carOwnerComment.details;
        
        for (int i = 0; i < carOwnerDetails.count; i++) {
            MFTableViewCellObject *kpiComment = [MFTableViewCellObject new];
            kpiComment.cellHeight = 50.0f;
            kpiComment.cellReuseIdentifier = @"kpiComment";
            kpiComment.attachKey = @"carOwner";
            kpiComment.attachIndex = i;
            [m_cellInfos addObject:kpiComment];
        }
        
        MFTableViewCellObject *carOwnerComment = [MFTableViewCellObject new];
        carOwnerComment.cellHeight = 90.0f;
        carOwnerComment.cellReuseIdentifier = @"diagnoseComment";
        carOwnerComment.attachKey = @"carOwner";
        [m_cellInfos addObject:carOwnerComment];
    }
    
    if (m_expertComment)
    {
        [m_cellInfos addObject:[self divisionCellObject:15.0f]];
        
        NSMutableArray<WDDiagnoseCommentDetailVO *> *expertDetails = m_expertComment.details;
        
        for (int i = 0; i < expertDetails.count; i++) {
            MFTableViewCellObject *kpiComment = [MFTableViewCellObject new];
            kpiComment.cellHeight = 50.0f;
            kpiComment.cellReuseIdentifier = @"kpiComment";
            kpiComment.attachKey = @"expert";
            kpiComment.attachIndex = i;
            [m_cellInfos addObject:kpiComment];
        }
        
        MFTableViewCellObject *expertComment = [MFTableViewCellObject new];
        expertComment.cellHeight = 90.0f;
        expertComment.cellReuseIdentifier = @"diagnoseComment";
        expertComment.attachKey = @"expert";
        [m_cellInfos addObject:expertComment];
    }
    
}

-(MFTableViewCellObject *)divisionCellObject:(CGFloat)cellHeight
{
    MFTableViewCellObject *division = [MFTableViewCellObject new];
    division.cellHeight = cellHeight;
    division.cellReuseIdentifier = @"division";
    return division;
}

-(void)showCarOwnerCommentVC
{
    WDCarOwnerCommentViewController *carOwnerCommentVC = [WDCarOwnerCommentViewController new];
    carOwnerCommentVC.diagnoseId = self.diagnoseId;
    [self.navigationController pushViewController:carOwnerCommentVC animated:YES];
}

-(void)showExpertCommentVC
{
    WDExpertCommentViewController *expertCommentVC = [WDExpertCommentViewController new];
    expertCommentVC.diagnoseId = self.diagnoseId;
    [self.navigationController pushViewController:expertCommentVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
