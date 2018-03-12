//
//  WDRepairStepItemImageViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/3/12.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairStepItemImageViewController.h"
#import "WDListPhotoByRepairStepIdApi.h"

@interface WDRepairStepItemImageViewController ()
{
    UIImageView *m_imageView;
}

@end

@implementation WDRepairStepItemImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"维修图片详情";
    [self setBackBarButton];
    
    m_imageView = [[UIImageView alloc] init];
    [self.view addSubview:m_imageView];
    
    [self getPhotoByRepairStepId];
}

-(void)getPhotoByRepairStepId
{
    __weak typeof(self) weakSelf = self;
    WDListPhotoByRepairStepIdApi *mfApi = [WDListPhotoByRepairStepIdApi new];
    mfApi.repairStepId = self.repairStep.repairStepId;
    
    mfApi.animatingView = self.view;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        [m_imageView sd_setImageWithURL:[NSURL URLWithString:@""]];
        
    } failure:^(YTKBaseRequest * request) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
