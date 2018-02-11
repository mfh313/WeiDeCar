//
//  WDRepairStepListViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/11.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairStepListViewController.h"
#import "WDRepairStepModel.h"
#import "WDRepairStepListHeaderView.h"
#import "WDRepairStepUploadImageCellView.h"
#import "WDRepairStepQualifiedCellView.h"

@interface WDRepairStepListViewController () <WDRepairStepListHeaderViewDelegate,WDRepairStepUploadImageCellViewDelegate>
{
    
}

@end

@implementation WDRepairStepListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"维修任务详情";
    [self setBackBarButton];
}

#pragma mark - WDRepairStepListHeaderViewDelegate
-(void)onClickFinishRepairStep:(WDRepairStepModel *)repairStep cellView:(WDRepairStepListHeaderView *)cellView
{
    
}

#pragma mark - WDRepairStepUploadImageCellViewDelegate
-(void)onClickUploadImageRepairStep:(WDRepairStepModel *)repairStep cellView:(WDRepairStepUploadImageCellView *)cellView
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
