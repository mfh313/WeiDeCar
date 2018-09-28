//
//  WDRepairAliPrePayApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/9/28.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairAliPrePayApi.h"

@implementation WDRepairAliPrePayApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger repairWxPrePay];
}

-(id)requestArgument
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    
    [requestArgument safeSetObject:self.orderId forKey:@"orderId"];
    [requestArgument safeSetObject:self.price forKey:@"price"];
    [requestArgument safeSetObject:self.userId forKey:@"userId"];
    [requestArgument safeSetObject:self.number forKey:@"number"];
    [requestArgument safeSetObject:self.body forKey:@"body"];
    [requestArgument safeSetObject:self.detail forKey:@"detail"];
    
    return requestArgument;
}

@end
