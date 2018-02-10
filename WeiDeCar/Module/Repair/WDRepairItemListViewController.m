//
//  WDRepairItemListViewController.m
//  WeiDeCar
//
//  Created by EEKA on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairItemListViewController.h"
#import "WDRepairTaskListCellView.h"
#import "WDListRepairTaskByUserApi.h"
#import "WDDiagnoseModel.h"

@interface WDRepairItemListViewController () <WDRepairTaskListCellViewDelegate>
{
    NSMutableArray *m_repairItems;
}

@end

@implementation WDRepairItemListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"维修任务列表";
    [self setBackBarButton];
    
    [self getListRepairTaskByUser];
}

-(void)getListRepairTaskByUser
{
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    WDListRepairTaskByUserApi *mfApi = [WDListRepairTaskByUserApi new];
    mfApi.currentUser = loginService.currentUserInfo;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *responseNetworkData = mfApi.responseNetworkData;
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (int i = 0; i < responseNetworkData.count; i++) {
            WDDiagnoseModel *itemModel = [WDDiagnoseModel yy_modelWithDictionary:responseNetworkData[i]];
            [tempArray addObject:itemModel];
        }
        
        m_repairItems = tempArray;
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        //        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.requestOperationError.code),[request.requestOperationError localizedDescription]];
        //        [self showTips:errorDesc];
    }];
}

-(void)reloadTableView
{
    [self makeCellObjects];
//    [m_tableView reloadData];
}

-(void)makeCellObjects
{
    [m_cellInfos removeAllObjects];
    
//    for (int i = 0; i < m_diagnoseArray.count; i++) {
//        WDDiagnoseModel *itemModel  = m_diagnoseArray[i];
//
//        MFTableViewCellObject *diagnoseModel = [MFTableViewCellObject new];
//        diagnoseModel.cellHeight = 150.0f;
//        diagnoseModel.cellReuseIdentifier = @"diagnoseItem";
//        diagnoseModel.attachIndex = i;
//        [m_cellInfos addObject:diagnoseModel];
//
//        MFTableViewCellObject *separator = [MFTableViewCellObject new];
//        separator.cellHeight = MFOnePixHeight;
//        separator.cellReuseIdentifier = @"separator";
//        separator.attachIndex = i;
//        [m_cellInfos addObject:separator];
//    }
}

#pragma mark - WDRepairTaskListCellViewDelegate
-(void)onClickRepairTaskCellView:(WDDiagnoseModel *)itemModel
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
