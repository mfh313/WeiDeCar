//
//  WDMechanicDiagnoseViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/11.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDMechanicDiagnoseViewController.h"
#import "WDDiagnoseModel.h"
#import "WDDiagnoseInfoCreateViewController.h"
#import "WDDiagnoseMainAddView.h"
#import "WDDiagnoseCauseJudgementCellView.h"
#import "WDMechanicJudgementInputView.h"
#import "WDFaultAppearanceHeaderView.h"
#import "WDMechanicDiagnoseApi.h"

@interface WDMechanicDiagnoseViewController () <UITableViewDataSource,UITableViewDelegate,WDDiagnoseMainAddViewDelegate,WDDiagnoseInfoCreateViewControllerDelegate>
{
    MFUITableView *m_tableView;
    
    NSMutableArray<WDDiagnoseItemFaultAppearanceModel *> *m_faultAppearances;
}

@end

@implementation WDMechanicDiagnoseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"现场诊断";
    [self setBackBarButton];
    
    m_faultAppearances = [NSMutableArray array];
    
    WDDiagnoseItemModel *diagnoseData = [WDDiagnoseItemModel new];
    self.diagnoseModel.diagnoseItems = diagnoseData;
    
    diagnoseData.faultAppearances = m_faultAppearances;
    
    WDDiagnoseMainAddView *addView = [WDDiagnoseMainAddView nibView];
    addView.m_delegate = self;
    [addView setAddDescString:@"新增诊断"];
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
        make.bottom.equalTo(self.view.mas_bottom).offset(-60);;
    }];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"提交诊断" forState:UIControlStateNormal];
    [submitButton setBackgroundImage:MFImageStretchCenter(@"registerButton") forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(onClickMechanicDiagnose) forControlEvents:UIControlEventTouchUpInside];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:submitButton];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
    }];
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
    
    if ([identifier isEqualToString:@"faultAppearanceHeader"])
    {
        return [self tableView:tableView faultAppearanceHeaderForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"causeJudgement"])
    {
        return [self tableView:tableView causeJudgementItemCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"faultAppearance"])
    {
        return [self tableView:tableView faultAppearanceCellForIndexPath:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView faultAppearanceHeaderForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDFaultAppearanceHeaderView *cellView = [WDFaultAppearanceHeaderView nibView];
        cell.m_subContentView = cellView;
    }
    
    NSInteger attachIndex = cellInfo.attachIndex;
    WDDiagnoseItemFaultAppearanceModel *appearanceModel  = m_faultAppearances[attachIndex];
    
    WDFaultAppearanceHeaderView *cellView = (WDFaultAppearanceHeaderView *)cell.m_subContentView;
    [cellView setFaultAppearance:appearanceModel.faultAppearanceName];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView causeJudgementItemCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDDiagnoseCauseJudgementCellView *cellView = [WDDiagnoseCauseJudgementCellView nibView];
        cell.m_subContentView = cellView;
    }
    
    NSInteger attachIndex = cellInfo.attachIndex;
    NSInteger subAttachIndex = cellInfo.subAttachIndex;
    
    WDDiagnoseItemFaultAppearanceModel *appearanceModel = m_faultAppearances[attachIndex];
    WDDiagnoseCauseJudgementModel *judgementModel = appearanceModel.causeJudgements[subAttachIndex];
    
    WDDiagnoseCauseJudgementCellView *cellView = (WDDiagnoseCauseJudgementCellView *)cell.m_subContentView;
    NSString *causeJudgeType = nil;
    if ([judgementModel.isCertain isEqualToString:@"Y"]) {
        causeJudgeType = @"确定原因";
    }
    else if ([judgementModel.isCheapest isEqualToString:@"Y"])
    {
        causeJudgeType = @"最廉价原因";
    }
    else if ([judgementModel.isMostPossible isEqualToString:@"Y"])
    {
        causeJudgeType = @"最可能原因";
    }
    [cellView setName:judgementModel.causeJudgementName type:causeJudgeType];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView faultAppearanceCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDMechanicJudgementInputView *cellView = [WDMechanicJudgementInputView nibView];
        cell.m_subContentView = cellView;
    }
    
    NSInteger attachIndex = cellInfo.attachIndex;
    WDDiagnoseItemFaultAppearanceModel *appearanceModel  = m_faultAppearances[attachIndex];
    
    WDMechanicJudgementInputView *cellView = (WDMechanicJudgementInputView *)cell.m_subContentView;
    cellView.userInteractionEnabled = NO;
    [cellView setRepairPlan:appearanceModel.repairPlanName memo:appearanceModel.memo];
    
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

#pragma mark - WDDiagnoseMainAddViewDelegate
-(void)onClickAddNewRecord:(WDDiagnoseMainAddView *)view
{
    WDDiagnoseInfoCreateViewController *createVC = [WDDiagnoseInfoCreateViewController new];
    createVC.m_delegate = self;
    [self.navigationController pushViewController:createVC animated:YES];
}

#pragma mark - WDDiagnoseInfoCreateViewControllerDelegate
-(void)onCreatFaultAppearance:(WDDiagnoseItemFaultAppearanceModel *)faultAppearanceModel
{
    [m_faultAppearances insertObject:faultAppearanceModel atIndex:0];
    [self reloadTableView];
}

-(void)reloadTableView
{
    [self makeCellObjects];
    [m_tableView reloadData];
}

-(void)makeCellObjects
{
    [m_cellInfos removeAllObjects];
    
    for (int i = 0; i < m_faultAppearances.count; i++) {
        WDDiagnoseItemFaultAppearanceModel *appearanceModel  = m_faultAppearances[i];
        
        MFTableViewCellObject *division = [MFTableViewCellObject new];
        division.cellHeight = 10.0f;
        division.cellReuseIdentifier = @"division";
        [m_cellInfos addObject:division];
        
        MFTableViewCellObject *faultAppearanceHeader = [MFTableViewCellObject new];
        faultAppearanceHeader.cellHeight = 50.0f;
        faultAppearanceHeader.cellReuseIdentifier = @"faultAppearanceHeader";
        faultAppearanceHeader.attachIndex = i;
        [m_cellInfos addObject:faultAppearanceHeader];
        
        MFTableViewCellObject *separator = [MFTableViewCellObject new];
        separator.cellHeight = MFOnePixHeight;
        separator.cellReuseIdentifier = @"separator";
        separator.attachIndex = i;
        [m_cellInfos addObject:separator];
        
        NSMutableArray<WDDiagnoseCauseJudgementModel *> *causeJudgements = appearanceModel.causeJudgements;
        for (int j = 0; j < causeJudgements.count; j++) {
            WDDiagnoseCauseJudgementModel *judgementModel = causeJudgements[j];
            
            MFTableViewCellObject *causeJudgement = [MFTableViewCellObject new];
            causeJudgement.cellHeight = 50.0f;
            causeJudgement.cellReuseIdentifier = @"causeJudgement";
            causeJudgement.attachIndex = i;
            causeJudgement.subAttachIndex = j;
            [m_cellInfos addObject:causeJudgement];
            
            MFTableViewCellObject *separator = [MFTableViewCellObject new];
            separator.cellHeight = MFOnePixHeight;
            separator.cellReuseIdentifier = @"separator";
            separator.attachIndex = i;
            [m_cellInfos addObject:separator];
        }
        
        MFTableViewCellObject *faultAppearance = [MFTableViewCellObject new];
        faultAppearance.cellHeight = 180.0f;
        faultAppearance.cellReuseIdentifier = @"faultAppearance";
        faultAppearance.attachIndex = i;
        [m_cellInfos addObject:faultAppearance];
    }
}

-(void)onClickMechanicDiagnose
{
    if (m_faultAppearances.count == 0) {
        [self showTips:@"请录入诊断数据"];
        return;
    }
    
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    WDUserInfoModel *currentUserInfo = loginService.currentUserInfo;
    
    __weak typeof(self) weakSelf = self;
    WDMechanicDiagnoseApi *mfApi = [WDMechanicDiagnoseApi new];
    mfApi.diagnoseId = self.diagnoseModel.diagnoseId;
    mfApi.mechanicId = currentUserInfo.userId;
    mfApi.diagnoseData = self.diagnoseModel.diagnoseItems;
    mfApi.animatingText = @"正在提交技师诊断数据...";
    mfApi.animatingView = MFAppWindow;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        [strongSelf showTips:mfApi.errorMessage];
        [strongSelf onSubmitSuccess];
        
    } failure:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        
    }];
}

-(void)onSubmitSuccess
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
