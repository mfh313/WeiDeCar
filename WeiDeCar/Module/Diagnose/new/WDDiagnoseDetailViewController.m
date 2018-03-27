//
//  WDDiagnoseDetailViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/3/27.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDDiagnoseDetailViewController.h"
#import "WDConfirmDiagnoseByCarOwnerApi.h"
#import "WDReconfirmAfterExpertDiagnosedApi.h"

@interface WDDiagnoseDetailViewController ()
{
    UIButton *m_submitButton;
}

@end

@implementation WDDiagnoseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    m_currentUserInfo = loginService.currentUserInfo;
    
    [self setFooterView];
    
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
        
    } failure:^(YTKBaseRequest * request) {

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
