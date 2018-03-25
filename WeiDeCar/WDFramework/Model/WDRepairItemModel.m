//
//  WDRepairItemModel.m
//  WeiDeCar
//
//  Created by EEKA on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairItemModel.h"

NSInteger const WDRepairItemStatus_DECLINED = 10;   //拒绝报价
NSInteger const WDRepairItemStatus_ACCEPTED = 20;  //接受报价
NSInteger const WDRepairItemStatus_REPAIR_PROCESSING = 30;  //开始维修
NSInteger const WDRepairItemStatus_ALL_QUALIFIED = 40;  //维修项目合格

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
