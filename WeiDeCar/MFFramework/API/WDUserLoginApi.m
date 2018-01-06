//
//  WDUserLoginApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/8.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDUserLoginApi.h"

@implementation WDUserLoginApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger userLogin];
}

-(id)requestArgument
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"userName"] = self.userName;
    requestArgument[@"passwd"] = self.passwd;
    return requestArgument;
}

@end
