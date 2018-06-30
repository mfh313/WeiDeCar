//
//  WDCarOwnerDiagnoseDetailViewController.m
//  WeiDeCar
//
//  Created by EEKA on 2018/6/30.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDCarOwnerDiagnoseDetailViewController.h"
#import "WDDiagnoseDetailHeaderView.h"

@interface WDCarOwnerDiagnoseDetailViewController ()

@end

@implementation WDCarOwnerDiagnoseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"诊断详情";
    [self setBackBarButton];
    
    self.view.backgroundColor = [UIColor hx_colorWithHexString:@"f5f5f5"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
