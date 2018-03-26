//
//  WDMechanicDiagnoseListViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/3/26.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDMechanicDiagnoseListViewController.h"
#import "WDListDiagnoseByMechanicApi.h"
#import "WDMechanicDiagnoseMainCreateViewController.h"

@interface WDMechanicDiagnoseListViewController ()

@end

@implementation WDMechanicDiagnoseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"诊断任务列表-技师";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initTableView];
    
    [m_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.width.equalTo(self.view.mas_width);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    __weak typeof(self) weakSelf = self;
    [m_tableView addPullToRefreshWithActionHandler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf getListDiagnoseByMechanic];
    }];
}

- (void)handleJPUSHServiceNotification:(NSNotification *)notification {
    [self getListDiagnoseByMechanic];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getListDiagnoseByMechanic];
}

-(void)getListDiagnoseByMechanic
{
    __weak typeof(self) weakSelf = self;
    WDListDiagnoseByMechanicApi *mfApi = [WDListDiagnoseByMechanicApi new];
    mfApi.mechanicId = m_currentUserInfo.userId;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *diagnoses = request.responseJSONObject[@"data"];
        NSMutableArray *diagnoseArray = [NSMutableArray array];
        for (int i = 0; i < diagnoses.count; i++) {
            WDDiagnoseModel *itemModel = [WDDiagnoseModel yy_modelWithDictionary:diagnoses[i]];
            [diagnoseArray addObject:itemModel];
        }
        
        m_diagnoseArray = diagnoseArray;
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
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
    
    for (int i = 0; i < m_diagnoseArray.count; i++) {
        
        MFTableViewCellObject *diagnoseModel = [MFTableViewCellObject new];
        diagnoseModel.cellHeight = 150.0f;
        diagnoseModel.cellReuseIdentifier = @"diagnoseItem";
        diagnoseModel.attachIndex = i;
        [m_cellInfos addObject:diagnoseModel];
        
        MFTableViewCellObject *separator = [MFTableViewCellObject new];
        separator.cellHeight = MFOnePixHeight;
        separator.cellReuseIdentifier = @"separator";
        separator.attachIndex = i;
        [m_cellInfos addObject:separator];
    }
}

#pragma mark - WDDiagnoseItemCellViewDelegate
-(void)onClickDiagnoseItemCellView:(WDDiagnoseModel *)itemModel
{
    WDMechanicDiagnoseMainCreateViewController *diagnoseCreateVC = [WDMechanicDiagnoseMainCreateViewController new];
    diagnoseCreateVC.diagnoseModel = itemModel;
    [self.navigationController pushViewController:diagnoseCreateVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
