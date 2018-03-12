//
//  WDRepairStepItemImageViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/3/12.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairStepItemImageViewController.h"

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
