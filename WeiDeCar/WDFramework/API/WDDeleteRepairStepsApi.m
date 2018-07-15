//
//  WDDeleteRepairStepsApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/7/15.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDDeleteRepairStepsApi.h"

@implementation WDDeleteRepairStepsApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger deleteRepairSteps];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    
    requestArgument[@"repairStepIds"] = self.repairStepIds;
    
    return requestArgument;
}

@end
