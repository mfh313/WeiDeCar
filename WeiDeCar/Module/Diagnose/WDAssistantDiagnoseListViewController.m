//
//  WDAssistantDiagnoseListViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/4/15.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDAssistantDiagnoseListViewController.h"
#import "WDDiagnoseDetailViewController.h"
#import "WDMechanicDiagnoseViewController.h"
#import "WDExpertDiagnoseMainCreateViewController.h"

@interface WDAssistantDiagnoseListViewController ()

@end

@implementation WDAssistantDiagnoseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"诊断任务列表-助理";
    
    [self initTableView];
    
    [m_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.width.equalTo(self.view.mas_width);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    __weak typeof(self) weakSelf = self;
    [m_tableView addPullToRefreshWithActionHandler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf getListDiagnoseByCarOwner];
    }];
}

- (void)handleJPUSHServiceNotification:(NSNotification *)notification {
    [self getListDiagnoseByCarOwner];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getListDiagnoseByCarOwner];
}

-(void)getListDiagnoseByCarOwner
{
    __weak typeof(self) weakSelf = self;
    WDListDiagnoseByCarOwnerApi *mfApi = [WDListDiagnoseByCarOwnerApi new];
    mfApi.carOwnerId = m_currentUserInfo.userId;
    
    mfApi.animatingView = self.view;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *diagnoses = mfApi.responseNetworkData;
        NSMutableArray *diagnoseArray = [NSMutableArray array];
        for (int i = 0; i < diagnoses.count; i++) {
            WDDiagnoseModel *itemModel = [WDDiagnoseModel yy_modelWithDictionary:diagnoses[i]];
            [diagnoseArray addObject:itemModel];
        }
        
        m_diagnoseArray = diagnoseArray;
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
    }];
}

#pragma mark - WDDiagnoseItemCellViewDelegate
-(void)onClickDiagnoseItemCellView:(WDDiagnoseModel *)itemModel
{
    if (itemModel.status == WDDiagnoseStatus_INIT)
    {
        WDMechanicDiagnoseViewController *diagnoseCreateVC = [WDMechanicDiagnoseViewController new];
        diagnoseCreateVC.diagnoseModel = itemModel;
        [self.navigationController pushViewController:diagnoseCreateVC animated:YES];

        return;
    }
    else if (itemModel.status == WDDiagnoseStatus_CAR_OWNER_CONFIRMED)
    {
        WDExpertDiagnoseMainCreateViewController *diagnoseCreateVC = [WDExpertDiagnoseMainCreateViewController new];
        diagnoseCreateVC.diagnoseModel = itemModel;
        [self.navigationController pushViewController:diagnoseCreateVC animated:YES];

        return;
    }

    WDDiagnoseDetailViewController *diagnoseDetailVC = [WDDiagnoseDetailViewController new];
    diagnoseDetailVC.diagnoseModel = itemModel;
    [self.navigationController pushViewController:diagnoseDetailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
