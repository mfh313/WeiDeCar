//
//  WDRepairItemModel.m
//  WeiDeCar
//
//  Created by EEKA on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairItemModel.h"

NSInteger const WDRepairItemStatus_10 = 10;   //未选择
NSInteger const WDRepairItemStatus_20 = 20;  //已选择

@implementation WDRepairItemModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"repairItemId" : @"id"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"repairTask" : [WDRepairTaskModel class]};
}

@end
