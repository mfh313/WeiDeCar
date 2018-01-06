//
//  WDExpertDiagnoseMainCreateViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/11.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDExpertDiagnoseMainCreateViewController.h"
#import "WDDiagnoseModel.h"
#import "WDExpertDiagnoseApi.h"
#import "WDFaultAppearanceHeaderView.h"
#import "WDDiagnoseCauseJudgementCellView.h"
#import "WDMechanicJudgementInputView.h"
#import "WDExpertDiagnoseResultSelectView.h"
#import "WDExpertDiagnoseAdviceCellView.h"

@interface WDExpertDiagnoseMainCreateViewController () <UITableViewDataSource,UITableViewDelegate>
{
    MFUITableView *m_tableView;
    
    WDDiagnoseItemModel *m_diagnoseData;
    
    NSMutableArray<WDDiagnoseItemFaultAppearanceModel *> *m_faultAppearances;
}

@end

@implementation WDExpertDiagnoseMainCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"专家复诊";
    [self setBackBarButton];
    
    m_diagnoseData = self.diagnoseModel.diagnoseItems;
    
    m_faultAppearances = m_diagnoseData.faultAppearances;
    
    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    m_tableView.backgroundColor = [UIColor hx_colorWithHexString:@"f5f5f5"];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    [self.view addSubview:m_tableView];
    [m_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.width.equalTo(self.view.mas_width);
        make.bottom.equalTo(self.view.mas_bottom).offset(-60);
    }];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"提交复诊信息" forState:UIControlStateNormal];
    [submitButton setBackgroundImage:MFImageStretchCenter(@"registerButton") forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(onClickExpertDiagnose:) forControlEvents:UIControlEventTouchUpInside];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:submitButton];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
    }];
    
    [self reloadTableView];
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
    else if ([identifier isEqualToString:@"expertDiagnoseResult"])
    {
        return [self tableView:tableView expertDiagnoseResultCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"faultAppearance"])
    {
        return [self tableView:tableView faultAppearanceCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"expertAdvices"])
    {
        return [self tableView:tableView expertDiagnoseAdviceCellForIndexPath:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView expertDiagnoseResultCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDExpertDiagnoseResultSelectView *cellView = [WDExpertDiagnoseResultSelectView nibView];
        cell.m_subContentView = cellView;
    }
    
    NSInteger attachIndex = cellInfo.attachIndex;
    NSInteger subAttachIndex = cellInfo.subAttachIndex;
    
    WDDiagnoseItemFaultAppearanceModel *appearanceModel = m_faultAppearances[attachIndex];
    WDDiagnoseCauseJudgementModel *judgementModel = appearanceModel.causeJudgements[subAttachIndex];
    
    WDExpertDiagnoseResultSelectView *cellView = (WDExpertDiagnoseResultSelectView *)cell.m_subContentView;
    [cellView setJudgementModel:judgementModel];
    
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

-(UITableViewCell *)tableView:(UITableView *)tableView expertDiagnoseAdviceCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDExpertDiagnoseAdviceCellView *cellView = [WDExpertDiagnoseAdviceCellView nibView];
        cell.m_subContentView = cellView;
    }
    
    NSInteger attachIndex = cellInfo.attachIndex;
    WDDiagnoseItemFaultAppearanceModel *appearanceModel  = m_faultAppearances[attachIndex];
    
    WDExpertDiagnoseAdviceCellView *cellView = (WDExpertDiagnoseAdviceCellView *)cell.m_subContentView;
    [cellView setFaultAppearanceModel:appearanceModel];
    
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

-(void)onClickExpertDiagnose:(id)sender
{
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    WDUserInfoModel *currentUserInfo = loginService.currentUserInfo;
    
    __weak typeof(self) weakSelf = self;
    WDExpertDiagnoseApi *mfApi = [WDExpertDiagnoseApi new];
    mfApi.diagnoseId = self.diagnoseModel.diagnoseId;
    mfApi.expertId = currentUserInfo.userId;
    mfApi.diagnoseData = m_diagnoseData;
    mfApi.animatingText = @"正在提交专家复诊数据...";
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
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.requestOperationError.code),[request.requestOperationError localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)onSubmitSuccess
{
    [self.navigationController popViewControllerAnimated:YES];
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
        division.cellHeight = 30.0f;
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
            
            MFTableViewCellObject *expertDiagnoseResult = [MFTableViewCellObject new];
            expertDiagnoseResult.cellHeight = 40.0f;
            expertDiagnoseResult.cellReuseIdentifier = @"expertDiagnoseResult";
            expertDiagnoseResult.attachIndex = i;
            expertDiagnoseResult.subAttachIndex = j;
            [m_cellInfos addObject:expertDiagnoseResult];
            
            MFTableViewCellObject *expertSeparator = [MFTableViewCellObject new];
            expertSeparator.cellHeight = MFOnePixHeight;
            expertSeparator.cellReuseIdentifier = @"separator";
            expertSeparator.attachIndex = i;
            [m_cellInfos addObject:expertSeparator];
        }
        
        MFTableViewCellObject *faultAppearance = [MFTableViewCellObject new];
        faultAppearance.cellHeight = 180.0f;
        faultAppearance.cellReuseIdentifier = @"faultAppearance";
        faultAppearance.attachIndex = i;
        [m_cellInfos addObject:faultAppearance];
        
        MFTableViewCellObject *expertAdvices = [MFTableViewCellObject new];
        expertAdvices.cellHeight = 90.0f;
        expertAdvices.cellReuseIdentifier = @"expertAdvices";
        expertAdvices.attachIndex = i;
        [m_cellInfos addObject:expertAdvices];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
