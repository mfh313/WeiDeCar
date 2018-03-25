//
//  WDMechanicStartRepairApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDMechanicStartRepairApi.h"

@implementation WDMechanicStartRepairApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger mechanicStartRepairItem];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    
    requestArgument[@"repairItemId"] = self.repairItemId;
    requestArgument[@"mechanicId"] = self.mechanicId;
    
    return requestArgument;
}

@end
