//
//  WDCarOwnerCommentViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/9/11.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDCarOwnerCommentViewController.h"
#import "WDListCommentKpiApi.h"
#import "WDCommentKpiResultVO.h"
#import "WDAddDiagnoseCommentApi.h"

@interface WDCarOwnerCommentViewController ()
{
    NSMutableArray<NSDictionary *> *m_commentKpiArray;
}

@end

@implementation WDCarOwnerCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getCommentKpiList];
}

-(void)getCommentKpiList
{
    __weak typeof(self) weakSelf = self;
    WDListCommentKpiApi *mfApi = [WDListCommentKpiApi new];
    mfApi.commentType = WDDiagnose_commentType_10;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSMutableArray *kpiArray = [NSMutableArray array];
        NSArray *kpiLists = mfApi.responseNetworkData;
        for (int i = 0; i < kpiLists.count; i++) {
            NSDictionary *kpi = kpiLists[i];
            [kpiArray addObject:kpi];
        }
        
        m_commentKpiArray = kpiArray;
        
    } failure:^(YTKBaseRequest * request) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
