//
//  WDRepairItemAssignmentModel.m
//  WeiDeCar
//
//  Created by EEKA on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairItemAssignmentModel.h"

@implementation WDRepairItemAssignmentModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"repairItemAssignmentId" : @"id"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"repairItem" : [WDRepairItemModel class]};
}

@end
