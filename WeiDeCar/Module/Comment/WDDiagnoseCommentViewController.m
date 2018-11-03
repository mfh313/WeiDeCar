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
#import "WDCarOwnerCommentViewController.h"
#import "WDExpertCommentViewController.h"

@interface WDDiagnoseCommentViewController ()

@end

@implementation WDDiagnoseCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"查看评价";
    [self setBackBarButton];
    
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    WDUserInfoModel *currentUserInfo = loginService.currentUserInfo;
    
    if (currentUserInfo.userType == WDUserInfoType_CarOwner)
    {
        [self setRightNaviButtonWithTitle:@"新增评价" action:@selector(showCarOwnerCommentVC)];
    }
    else if (currentUserInfo.userType == WDUserInfoType_Expert)
    {
        [self setRightNaviButtonWithTitle:@"新增评价" action:@selector(showExpertCommentVC)];
    }

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

-(void)showCarOwnerCommentVC
{
    WDCarOwnerCommentViewController *carOwnerCommentVC = [WDCarOwnerCommentViewController new];
    carOwnerCommentVC.diagnoseId = self.diagnoseId;
    [self.navigationController pushViewController:carOwnerCommentVC animated:YES];
}

-(void)showExpertCommentVC
{
    WDExpertCommentViewController *expertCommentVC = [WDExpertCommentViewController new];
    expertCommentVC.diagnoseId = self.diagnoseId;
    [self.navigationController pushViewController:expertCommentVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
