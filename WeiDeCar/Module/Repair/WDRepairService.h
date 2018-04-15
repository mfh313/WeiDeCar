//
//  WDRepairService.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/4/15.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDRepairItemModel.h"

@interface WDRepairService : MMService

-(BOOL)canStartRepairItem:(WDRepairItemModel *)repairItem;
-(BOOL)canOperateQualified;

@end
