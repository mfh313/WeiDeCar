//
//  WDListRepairTaskByUserApi.m
//  WeiDeCar
//
//  Created by EEKA on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDListRepairTaskByUserApi.h"

@implementation WDListRepairTaskByUserApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger listRepairTaskByUser];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    
    NSString *userId = self.currentUser.userId;
    
    if (![MFStringUtil isBlankString:userId])
    {
        requestArgument[@"userId"] = userId;
    }
    
    return requestArgument;
}


@end


