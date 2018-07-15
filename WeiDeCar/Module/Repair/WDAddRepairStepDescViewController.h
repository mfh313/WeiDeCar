//
//  WDAddRepairStepDescViewController.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/7/15.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIViewController.h"

@class WDAddRepairStepDescViewController;
@protocol WDAddRepairStepDescViewControllerDelegate <NSObject>
@optional
-(void)didAddRepairStepDesc:(NSString *)repairStepDesc controller:(WDAddRepairStepDescViewController *)controller;

@end

@interface WDAddRepairStepDescViewController : MMUIViewController

@property (nonatomic,weak) id<WDAddRepairStepDescViewControllerDelegate> m_delegate;

@end
