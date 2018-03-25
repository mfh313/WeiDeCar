//
//  WDListRepairItemApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/11.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDListRepairItemApi.h"

@implementation WDListRepairItemApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger listRepairItem];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"diagnoseId"] = self.diagnoseId;
    requestArgument[@"userId"] = self.userId;
    return requestArgument;
}

@end
