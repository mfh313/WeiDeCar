//
//  WDRepairStepModel.m
//  WeiDeCar
//
//  Created by EEKA on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairStepModel.h"

NSInteger const WDRepairStepQualifiedStatus_10 = 10;   //初始状态
NSInteger const WDRepairStepQualifiedStatus_20 = 20;  //开始维修
NSInteger const WDRepairStepQualifiedStatus_30 = 30;  //检验不合格
NSInteger const WDRepairStepQualifiedStatus_40 = 40;  //检验合格

@implementation WDRepairStepModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"repairStepId" : @"id"
             };
}

@end
