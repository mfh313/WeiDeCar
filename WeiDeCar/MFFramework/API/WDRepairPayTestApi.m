//
//  WDRepairPayTestApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/12.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairPayTestApi.h"

@implementation WDRepairPayTestApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger repairPayTest];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"diagnoseId"] = self.diagnoseId;
    requestArgument[@"userId"] = self.userId;
    return requestArgument;
}

@end
