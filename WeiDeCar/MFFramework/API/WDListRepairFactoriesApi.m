//
//  WDListRepairFactoriesApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/1/6.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDListRepairFactoriesApi.h"

@implementation WDListRepairFactoriesApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger listRepairFactories];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    return requestArgument;
}

@end
