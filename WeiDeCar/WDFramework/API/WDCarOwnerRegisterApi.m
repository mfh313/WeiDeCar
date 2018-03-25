//
//  WDCarOwnerRegisterApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/8.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDCarOwnerRegisterApi.h"

@implementation WDCarOwnerRegisterApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger carOwnerRegister];
}

-(id)requestArgument
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    [requestArgument addEntriesFromDictionary:self.registerInfo];
    return requestArgument;
}

@end
