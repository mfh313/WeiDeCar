//
//  WDCarOwnerDiagnoseDetailViewController.m
//  WeiDeCar
//
//  Created by EEKA on 2018/6/30.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDCarOwnerDiagnoseDetailViewController.h"
#import "WDDiagnoseDetailHeaderView.h"
#import "WDDiagnoseDetailResultView.h"
#import "WDExpertDiagnoseAdviceCellView.h"
#import "WDMechanicJudgementInputView.h"
#import "WDConfirmDiagnoseByCarOwnerApi.h"
#import "WDReconfirmAfterExpertDiagnosedApi.h"

@interface WDCarOwnerDiagnoseDetailViewController () <UITableViewDataSource,UITableViewDelegate>
{
    MFUITableView *m_tableView;
    UIButton *m_submitButton;
    
    NSMutableArray<WDDiagnoseItemFaultAppearanceModel *> *m_faultAppearances;
}

@end

@implementation WDCarOwnerDiagnoseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"诊断详情";
    [self setBackBarButton];
    
    self.view.backgroundColor = [UIColor hx_colorWithHexString:@"f5f5f5"];
    
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    m_currentUserInfo = loginService.currentUserInfo;
    
    m_faultAppearances = self.diagnoseModel.diagnoseItems.faultAppearances;
    
    [self initTableView];
    [self setFooterView];
    
    [self reloadTableView];
    
    if (self.diagnoseModel.status == WDDiagnoseStatus_INIT)
    {
        LGAlertView *alertView = [LGAlertView alertViewWithTitle:@"提示" message:@"诊断任务当前为初始状态，请等待技师诊断" style:LGAlertViewStyleAlert buttonTitles:@[@"确定"] cancelButtonTitle:nil
                                          destructiveButtonTitle:nil
                                                   actionHandler:nil
                                                   cancelHandler:nil
                                              destructiveHandler:nil];
        
        [alertView showAnimated:YES completionHandler:nil];
    }
}

-(void)initTableView
{
    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    m_tableView.backgroundColor = [UIColor hx_colorWithHexString:@"f5f5f5"];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    [self.view addSubview:m_tableView];
    
    [m_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.width.equalTo(self.view.mas_width);
        make.bottom.equalTo(self.view.mas_bottom).offset(-60);
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
    
    if ([identifier isEqualToString:@"detailHeader"])
    {
        return [self tableView:tableView detailHeaderForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"detailResult"])
    {
        return [self tableView:tableView diagnoseDetailResultViewCellForIndexPath:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView detailHeaderForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDDiagnoseDetailHeaderView *cellView = [[WDDiagnoseDetailHeaderView alloc] initWithFrame:cell.contentView.bounds];
        cell.m_subContentView = cellView;
    }
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView diagnoseDetailResultViewCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDDiagnoseDetailResultView *cellView = [[WDDiagnoseDetailResultView alloc] initWithFrame:cell.contentView.bounds];
        cell.m_subContentView = cellView;
    }
    
    NSInteger attachIndex = cellInfo.attachIndex;
    WDDiagnoseItemFaultAppearanceModel *appearanceModel = m_faultAppearances[attachIndex];
    
    WDDiagnoseDetailResultView *cellView = (WDDiagnoseDetailResultView *)cell.m_subContentView;
    [cellView setDiagnoseModel:self.diagnoseModel appearanceModel:appearanceModel];
    
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
    
    [cellView setAdviceTitle:@"第三方专家低成本维修方案："];
    [cellView setUserInteractionEnabled:NO];
    
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
        division.cellHeight = 15.0f;
        division.cellReuseIdentifier = @"division";
        [m_cellInfos addObject:division];
        
        MFTableViewCellObject *detailHeader = [MFTableViewCellObject new];
        detailHeader.cellHeight = 70.0f;
        detailHeader.cellReuseIdentifier = @"detailHeader";
        [m_cellInfos addObject:detailHeader];
        
        CGFloat detailResultCellHeight = appearanceModel.causeJudgements.count * 50.0f;
        
        MFTableViewCellObject *detailResult = [MFTableViewCellObject new];
        detailResult.cellHeight = detailResultCellHeight;
        detailResult.cellReuseIdentifier = @"detailResult";
        detailResult.attachIndex = i;
        [m_cellInfos addObject:detailResult];
        
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

-(void)setFooterView
{
    m_submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [m_submitButton setBackgroundImage:MFImageStretchCenter(@"registerButton") forState:UIControlStateNormal];
    [m_submitButton addTarget:self action:@selector(onClickSubmitButton) forControlEvents:UIControlEventTouchUpInside];
    m_submitButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:m_submitButton];
    [m_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
    }];
    
    if (self.diagnoseModel.status == WDDiagnoseStatus_MECHANIC_DIAGNOSED)
    {
        [m_submitButton setTitle:@"确认技师诊断结果" forState:UIControlStateNormal];
    }
    else if (self.diagnoseModel.status == WDDiagnoseStatus_EXPERT_DIAGNOSED)
    {
        [m_submitButton setTitle:@"确认专家复诊结果" forState:UIControlStateNormal];
    }
    else
    {
        [m_submitButton setHidden:YES];
        
        [m_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top);
            make.width.equalTo(self.view.mas_width);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
    }
}

-(void)onClickSubmitButton
{
    if (self.diagnoseModel.status == WDDiagnoseStatus_MECHANIC_DIAGNOSED)
    {
        [self confirmDiagnoseByCarOwner];
    }
    else if (self.diagnoseModel.status == WDDiagnoseStatus_EXPERT_DIAGNOSED)
    {
        [self reconfirmAfterExpertDiagnosed];
    }
}

-(void)confirmDiagnoseByCarOwner
{
    __weak typeof(self) weakSelf = self;
    WDConfirmDiagnoseByCarOwnerApi *mfApi = [WDConfirmDiagnoseByCarOwnerApi new];
    mfApi.carOwnerId = m_currentUserInfo.userId;
    mfApi.diagnoseId = self.diagnoseModel.diagnoseId;
    
    mfApi.animatingText = @"确认技师诊断结果...";
    mfApi.animatingView = MFAppWindow;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        [strongSelf showTips:mfApi.errorMessage];
        
        [self hiddenSubmitButton];
        
    } failure:^(YTKBaseRequest * request) {
        
    }];
}

-(void)reconfirmAfterExpertDiagnosed
{
    __weak typeof(self) weakSelf = self;
    WDReconfirmAfterExpertDiagnosedApi *mfApi = [WDReconfirmAfterExpertDiagnosedApi new];
    mfApi.carOwnerId = m_currentUserInfo.userId;
    mfApi.diagnoseId = self.diagnoseModel.diagnoseId;
    
    mfApi.animatingText = @"确认专家复诊结果...";
    mfApi.animatingView = MFAppWindow;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        [strongSelf showTips:mfApi.errorMessage];
        [strongSelf hiddenSubmitButton];
        
    } failure:^(YTKBaseRequest * request) {
        
    }];
}

-(void)hiddenSubmitButton
{
    [m_submitButton setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
