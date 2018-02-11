//
//  WDListRepairStepApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/11.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDListRepairStepApi.h"

@implementation WDListRepairStepApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger listRepairStep];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"repairItemId"] = self.repairItemId;
    return requestArgument;
}

@end
