//
//  WDSelectRepairFactoryViewController.h
//  WeiDeCar
//
//  Created by EEKA on 2018/8/22.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIViewController.h"
#import "WDRepairFactoryModel.h"

@class WDSelectRepairFactoryViewController;
@protocol WDSelectRepairFactoryViewControllerDelegate <NSObject>
@optional
-(void)didSelectRepairFactory:(WDRepairFactoryModel *)repairFactory viewController:(WDSelectRepairFactoryViewController *)viewController;

@end

@interface WDSelectRepairFactoryViewController : MMUIViewController

@property (nonatomic,weak) id<WDSelectRepairFactoryViewControllerDelegate> m_delegate;

@end
