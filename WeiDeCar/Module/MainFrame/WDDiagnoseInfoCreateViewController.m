//
//  WDDiagnoseInfoCreateViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/10.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDDiagnoseInfoCreateViewController.h"
#import "WDDiagnoseModel.h"
#import "WDDiagnosisAddHeaderView.h"
#import "WDDiagnoseCauseJudgementCellView.h"
#import "WDMechanicJudgementInputView.h"

@interface WDDiagnoseInfoCreateViewController () <UITableViewDataSource,UITableViewDelegate,WDDiagnosisAddHeaderViewDelegate,WDMechanicJudgementInputViewDelegate>
{
    MFUITableView *m_tableView;
    
    WDDiagnosisAddHeaderView *m_headerView;
    
    WDDiagnoseItemFaultAppearanceModel *m_faultAppearances;
    NSMutableArray<WDDiagnoseCauseJudgementModel *> *m_causeJudgements;
    
    WDUserInfoModel *m_currentUserInfo;
}

@end


@implementation WDDiagnoseInfoCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"现场诊断-新增";
    [self setBackBarButton];
    
    m_cellInfos = [NSMutableArray array];
    
    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    m_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    m_tableView.backgroundColor = [UIColor hx_colorWithHexString:@"f5f5f5"];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    [self.view addSubview:m_tableView];
    
    m_headerView = [WDDiagnosisAddHeaderView nibView];
    m_headerView.m_delegate = self;
    m_headerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 350);
    m_tableView.tableHeaderView = m_headerView;
    
    m_causeJudgements = [NSMutableArray array];
    
    m_faultAppearances = [WDDiagnoseItemFaultAppearanceModel new];
    m_faultAppearances.causeJudgements = m_causeJudgements;
    
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    m_currentUserInfo = loginService.currentUserInfo;
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
    
    if ([identifier isEqualToString:@"causeJudgement"])
    {
        return [self tableView:tableView causeJudgementItemCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"judgementInput"])
    {
        return [self tableView:tableView judgementInputCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"submitButton"])
    {
        return [self tableView:tableView createButtonCellForIndexPath:indexPath];
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
    WDDiagnoseCauseJudgementModel *judgementModel = m_causeJudgements[attachIndex];

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

-(UITableViewCell *)tableView:(UITableView *)tableView judgementInputCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDMechanicJudgementInputView *cellView = [WDMechanicJudgementInputView nibView];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    WDMechanicJudgementInputView *cellView = (WDMechanicJudgementInputView *)cell.m_subContentView;
    [cellView setRepairPlan:m_faultAppearances.repairPlanName memo:m_faultAppearances.memo];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView createButtonCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((CGRectGetWidth(cell.contentView.frame) - 120) /2 , 0, 120, CGRectGetHeight(cell.contentView.frame));
        button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setBackgroundImage:MFImageStretchCenter(@"registerButton") forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onClickSubmitDiagnoseInfo) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    return cellInfo.cellHeight;
}

#pragma mark - WDDiagnosisAddHeaderViewDelegate
-(BOOL)onClickAddFaultAppearanceName:(NSString *)faultAppearanceName
                          headerView:(WDDiagnosisAddHeaderView *)view
{
    if ([MFStringUtil isBlankString:faultAppearanceName]) {
        LGAlertView *alertView = [LGAlertView alertViewWithTitle:@"提示" message:@"请输入故障现象" style:LGAlertViewStyleAlert buttonTitles:@[@"确定"] cancelButtonTitle:nil
                                          destructiveButtonTitle:nil
                                                   actionHandler:nil
                                                   cancelHandler:nil
                                              destructiveHandler:nil];
        
        [alertView showAnimated:YES completionHandler:nil];
        
        return NO;
    }
    
    m_faultAppearances.faultAppearanceName = faultAppearanceName;
    
    return YES;
}

-(void)onClickAddCauseJudgementName:(NSString *)causeJudgementName
                          isCertain:(NSString *)isCertain
                         isCheapest:(NSString *)isCheapest
                     isMostPossible:(NSString *)isMostPossible
                         headerView:(WDDiagnosisAddHeaderView *)view
{
    if ([MFStringUtil isBlankString:causeJudgementName]) {
        LGAlertView *alertView = [LGAlertView alertViewWithTitle:@"提示" message:@"请输入原因判断" style:LGAlertViewStyleAlert buttonTitles:@[@"确定"] cancelButtonTitle:nil
                                          destructiveButtonTitle:nil
                                                   actionHandler:nil
                                                   cancelHandler:nil
                                              destructiveHandler:nil];
        
        [alertView showAnimated:YES completionHandler:nil];
        return;
    }
    
    WDDiagnoseCauseJudgementModel *judgementModel = [WDDiagnoseCauseJudgementModel new];
    judgementModel.causeJudgeMechanicId = m_currentUserInfo.userId;
    judgementModel.judgementSource = WDUserInfoType_Mechanic;
    judgementModel.causeJudgementName = causeJudgementName;
    judgementModel.isCertain = isCertain;
    judgementModel.isCheapest = isCheapest;
    judgementModel.isMostPossible = isMostPossible;
    [m_causeJudgements addObject:judgementModel];
    
    [m_headerView resetInputJudgementContent];
    
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
    
    for (int i = 0; i < m_causeJudgements.count; i++) {
        WDDiagnoseCauseJudgementModel *itemModel  = m_causeJudgements[i];
        
        MFTableViewCellObject *causeJudgement = [MFTableViewCellObject new];
        causeJudgement.cellHeight = 48.0f;
        causeJudgement.cellReuseIdentifier = @"causeJudgement";
        causeJudgement.attachIndex = i;
        [m_cellInfos addObject:causeJudgement];
        
        MFTableViewCellObject *separator = [MFTableViewCellObject new];
        separator.cellHeight = MFOnePixHeight;
        separator.cellReuseIdentifier = @"separator";
        separator.attachIndex = i;
        [m_cellInfos addObject:separator];
    }
    
    if (m_causeJudgements.count > 0)
    {
        MFTableViewCellObject *judgementInput = [MFTableViewCellObject new];
        judgementInput.cellHeight = 180.0f;
        judgementInput.cellReuseIdentifier = @"judgementInput";
        [m_cellInfos addObject:judgementInput];
        
        MFTableViewCellObject *submitButton = [MFTableViewCellObject new];
        submitButton.cellHeight = 48.0f;
        submitButton.cellReuseIdentifier = @"submitButton";
        [m_cellInfos addObject:submitButton];
    }
}

#pragma mark - WDMechanicJudgementInputViewDelegate
-(void)onInputRepairPlan:(NSString *)repairPlan inputView:(WDMechanicJudgementInputView *)inputView
{
    m_faultAppearances.repairPlanName = repairPlan;
}

-(void)onInputMemo:(NSString *)memo inputView:(WDMechanicJudgementInputView *)inputView
{
    m_faultAppearances.memo = memo;
}

-(void)onClickSubmitDiagnoseInfo
{
    if ([MFStringUtil isBlankString:m_faultAppearances.repairPlanName]) {
        LGAlertView *alertView = [LGAlertView alertViewWithTitle:@"提示" message:@"请输入维修方案" style:LGAlertViewStyleAlert buttonTitles:@[@"确定"] cancelButtonTitle:nil
                                          destructiveButtonTitle:nil
                                                   actionHandler:nil
                                                   cancelHandler:nil
                                              destructiveHandler:nil];
        
        [alertView showAnimated:YES completionHandler:nil];
        return;
    }
    
    if ([self.m_delegate respondsToSelector:@selector(onCreatFaultAppearance:)]) {
        [self.m_delegate onCreatFaultAppearance:m_faultAppearances];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
