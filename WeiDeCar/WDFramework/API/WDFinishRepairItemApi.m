//
//  WDFinishRepairItemApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/3/5.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDFinishRepairItemApi.h"

@implementation WDFinishRepairItemApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger finishRepairItem];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"userId"] = self.userId;
    requestArgument[@"repairItemId"] = self.repairItemId;

    return requestArgument;
}

@end
