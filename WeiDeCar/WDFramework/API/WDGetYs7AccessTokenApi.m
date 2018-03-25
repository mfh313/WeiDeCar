//
//  WDGetYs7AccessTokenApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/1/2.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDGetYs7AccessTokenApi.h"

@implementation WDGetYs7AccessTokenApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger getYs7AccessToken];
}

-(YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    return requestArgument;
}

@end
