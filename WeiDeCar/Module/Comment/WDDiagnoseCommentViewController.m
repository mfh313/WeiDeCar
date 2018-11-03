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
    
    [self getCarOwnerAndExpertComment];
}

-(void)getCarOwnerAndExpertComment
{
    __weak typeof(self) weakSelf = self;
    WDGetDiagnoseCommentApi *mfApi = [WDGetDiagnoseCommentApi new];
    mfApi.diagnoseId = self.diagnoseId;
    
    mfApi.animatingView = self.view;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        
    } failure:^(YTKBaseRequest * request) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
