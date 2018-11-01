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

@interface WDDiagnoseCommentViewController ()

@end

@implementation WDDiagnoseCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"查看评价";
    [self setBackBarButton];
    
    [self getCarOwnerComment];
}

-(void)getCarOwnerComment
{
    __weak typeof(self) weakSelf = self;
    WDGetDiagnoseCommentApi *mfApi = [WDGetDiagnoseCommentApi new];
    mfApi.commentType = WDDiagnose_commentType_10;
    mfApi.diagnoseId = self.diagnoseId;
    
    mfApi.animatingView = self.view;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
//        NSMutableArray *kpiArray = [NSMutableArray array];
//        NSArray *kpiLists = mfApi.responseNetworkData;
//        for (int i = 0; i < kpiLists.count; i++) {
//            NSDictionary *kpi = kpiLists[i];
//            [kpiArray addObject:kpi];
//        }
//
//        m_commentKpiArray = kpiArray;
//        [strongSelf initDefaultCommentKpi];
//        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
