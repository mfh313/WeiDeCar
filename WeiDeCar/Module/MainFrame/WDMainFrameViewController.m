//
//  WDMainFrameViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/11/27.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDMainFrameViewController.h"
#import "WDMainFrameMenuView.h"
#import "WDIPCameraPlayViewController.h"
#import "WDIPCameraService.h"
#import "WDJPUSHService.h"
#import "WDRepairFactoriesViewController.h"
#import "WDRepairItemListViewController.h"
#import "WDCarOwnerDiagnoseListViewController.h"
#import "WDMechanicDiagnoseListViewController.h"
#import "WDExpertDiagnoseListViewController.h"

@interface WDMainFrameViewController () <UITableViewDataSource,UITableViewDelegate,WDMainFrameMenuViewDelegate>
{
    MFUITableView *m_tableView;
    NSMutableArray<MFTableViewCellObject *> *m_cellInfos;
    
    NSMutableArray *m_actionMenus;
}

@end

@implementation WDMainFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    WDUserInfoModel *currentUserInfo = loginService.currentUserInfo;
    self.title = [NSString stringWithFormat:@"维德专修 (%@)",currentUserInfo.realName];
    
    [self setRightBarButtonTitle:@"退出"];
    
    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    m_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    m_tableView.backgroundColor = [UIColor whiteColor];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    [self.view addSubview:m_tableView];
    
    m_cellInfos = [NSMutableArray array];
    [self initActionMenus];
    
    [self makeCellObjects];
    [m_tableView reloadData];
    
    WDIPCameraService *cameraService = [[MMServiceCenter defaultCenter] getService:[WDIPCameraService class]];
    [cameraService getYs7AccessToken];
}

-(void)onClickRightButton:(id)sender
{
    [self onClickMainGo];
}

-(void)initActionMenus
{
    m_actionMenus = [NSMutableArray array];
    
    NSMutableDictionary *faultDiagnosis = [NSMutableDictionary dictionary];
    faultDiagnosis[@"key"] = @"faultDiagnosis";
    faultDiagnosis[@"title"] = @"故障诊断维修";
    
    NSMutableDictionary *regularVideo = [NSMutableDictionary dictionary];
    regularVideo[@"key"] = @"regular";
    regularVideo[@"title"] = @"维修现场-直播";
    
    NSMutableDictionary *repairFactories = [NSMutableDictionary dictionary];
    repairFactories[@"key"] = @"repairFactories";
    repairFactories[@"title"] = @"修理厂列表";
    
    NSMutableDictionary *repairItems = [NSMutableDictionary dictionary];
    repairItems[@"key"] = @"repairItems";
    repairItems[@"title"] = @"维修任务列表";
    
    NSMutableDictionary *troubleCar = [NSMutableDictionary dictionary];
    troubleCar[@"key"] = @"troubleCar";
    troubleCar[@"title"] = @"故障车";
    
    NSMutableDictionary *cosmetology = [NSMutableDictionary dictionary];
    cosmetology[@"key"] = @"cosmetology";
    cosmetology[@"title"] = @"亮车美容";
    
    [m_actionMenus addObject:faultDiagnosis];
    [m_actionMenus addObject:repairItems];
    [m_actionMenus addObject:repairFactories];
    [m_actionMenus addObject:regularVideo];
    [m_actionMenus addObject:troubleCar];
    [m_actionMenus addObject:cosmetology];
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
    
    if ([identifier isEqualToString:@"acitonMenu"])
    {
        return [self tableView:tableView acitonMenuCellForIndex:indexPath];
    }
    else if ([identifier isEqualToString:@"blankCell"])
    {
        return [self tableView:tableView blankCellForIndex:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView blankCellForIndex:(NSIndexPath *)indexPath
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

-(UITableViewCell *)tableView:(UITableView *)tableView acitonMenuCellForIndex:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;

    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDMainFrameMenuView *cellView = [WDMainFrameMenuView nibView];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = CGRectMake((CGRectGetWidth(cell.contentView.frame) - 240) /2 , 0, 240, CGRectGetHeight(cell.contentView.frame));
    
    NSInteger attachIndex = cellInfo.attachIndex;
    NSMutableDictionary *menuInfo = m_actionMenus[attachIndex];
    NSString *title = menuInfo[@"title"];
    
    WDMainFrameMenuView *cellView = (WDMainFrameMenuView *)cell.m_subContentView;
    [cellView setMenuTitle:title index:attachIndex];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    return cellInfo.cellHeight;
}

-(void)makeCellObjects
{
    MFTableViewCellObject *blank = [MFTableViewCellObject new];
    blank.cellHeight = 30.0f;
    blank.cellReuseIdentifier = @"blankCell";
    [m_cellInfos addObject:blank];
    
    for (int i = 0; i < m_actionMenus.count; i++)
    {
        MFTableViewCellObject *acitonMenu = [MFTableViewCellObject new];
        acitonMenu.cellHeight = 50.0f;
        acitonMenu.cellReuseIdentifier = @"acitonMenu";
        acitonMenu.attachIndex = i;
        [m_cellInfos addObject:acitonMenu];
        
        if (i != m_actionMenus.count - 1)
        {
            MFTableViewCellObject *blank = [MFTableViewCellObject new];
            blank.cellHeight = 10.0f;
            blank.cellReuseIdentifier = @"blankCell";
            [m_cellInfos addObject:blank];
        }
    }
}

-(void)onClickMainGo
{
    LGAlertView *alertView = [LGAlertView alertViewWithTitle:@"提示" message:@"是否退出登录？" style:LGAlertViewStyleAlert buttonTitles:@[@"确定"] cancelButtonTitle:@"取消" destructiveButtonTitle:nil actionHandler:^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title)
    {
        WDJPUSHService *pushService = [[MMServiceCenter defaultCenter] getService:[WDJPUSHService class]];
        [pushService deletePUSHAlias];
        
        [[WDAppViewControllerManager getAppViewControllerManager] launchGuideViewController];
    }
                                               cancelHandler:nil destructiveHandler:nil];
    
    [alertView showAnimated:YES completionHandler:nil];
}

#pragma mark - WDMainFrameMenuViewDelegate
-(void)onClickMainFrameMenuViewIndex:(NSInteger)actionIndex view:(WDMainFrameMenuView *)view;
{
    NSMutableDictionary *menuInfo = m_actionMenus[actionIndex];
    NSString *actionKey = menuInfo[@"key"];
    if ([actionKey isEqualToString:@"faultDiagnosis"])
    {
        [self showDiagnosisMainVC];
    }
    else if ([actionKey isEqualToString:@"regular"])
    {
        [self showCameraPlayVC];
    }
    else if ([actionKey isEqualToString:@"repairFactories"])
    {
        [self storeRepairFactoriesVC];
    }
    else if ([actionKey isEqualToString:@"repairItems"])
    {
        [self repairItemListVC];
    }
    else
    {
        NSString *title = menuInfo[@"title"];
        [self showTips:title];
    }
}

-(void)showDiagnosisMainVC
{
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    WDUserInfoModel *currentUserInfo = loginService.currentUserInfo;
    
    if (currentUserInfo.userType == WDUserInfoType_CarOwner)
    {
        WDCarOwnerDiagnoseListViewController *carOwnerDiagnoseVC = [WDCarOwnerDiagnoseListViewController new];
        [self.navigationController pushViewController:carOwnerDiagnoseVC animated:YES];
    }
    else if (currentUserInfo.userType == WDUserInfoType_Mechanic)
    {
        WDMechanicDiagnoseListViewController *mechanicDiagnoseVC = [WDMechanicDiagnoseListViewController new];
        [self.navigationController pushViewController:mechanicDiagnoseVC animated:YES];
    }
    else if (currentUserInfo.userType == WDUserInfoType_Expert)
    {
        WDExpertDiagnoseListViewController *expertDiagnoseVC = [WDExpertDiagnoseListViewController new];
        [self.navigationController pushViewController:expertDiagnoseVC animated:YES];
    }
}

-(void)showCameraPlayVC
{
    WDIPCameraService *cameraService = [[MMServiceCenter defaultCenter] getService:[WDIPCameraService class]];
    
    WDIPCameraPlayViewController *cameraPlayVC = [WDIPCameraPlayViewController new];
    cameraPlayVC.appKey = EZUIKitAppKey;
    cameraPlayVC.accessToken = [cameraService getYs7AccessToken];
    cameraPlayVC.urlStr = EZUIKitUrlStr;
    [self.navigationController pushViewController:cameraPlayVC animated:YES];
}

-(void)storeRepairFactoriesVC
{
    WDRepairFactoriesViewController *factoriesVC = [WDRepairFactoriesViewController new];
    [self.navigationController pushViewController:factoriesVC animated:YES];
}

-(void)repairItemListVC
{
    WDRepairItemListViewController *repairItemsVC = [WDRepairItemListViewController new];
    [self.navigationController pushViewController:repairItemsVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
