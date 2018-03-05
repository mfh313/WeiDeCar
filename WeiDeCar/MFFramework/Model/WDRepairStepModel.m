//
//  WDRepairStepModel.m
//  WeiDeCar
//
//  Created by EEKA on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairStepModel.h"

NSInteger const WDRepairStepQualifiedStatus_UNQUALIFIED = 10;   //检验不合格
NSInteger const WDRepairStepQualifiedStatus_QUALIFIED = 20;  //检验合格

NSInteger const WDRepairStepStatus_INIT = 10;   //初始状态
NSInteger const WDRepairStepStatus_START_REPAIR = 20;  //开始维修
NSInteger const WDRepairStepStatus_MECHANIC_FINISHED = 30;  //技师维修完成
NSInteger const WDRepairStepStatus_QUALIFIED = 40;  //该步骤合格
NSInteger const WDRepairStepStatus_UNQUALIFIED = 50;  //该步骤不合格

@implementation WDRepairStepModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"repairStepId" : @"id"
             };
}

@end
