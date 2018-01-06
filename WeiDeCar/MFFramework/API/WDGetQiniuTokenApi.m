//
//  WDGetQiniuTokenApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/1/2.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDGetQiniuTokenApi.h"

@implementation WDGetQiniuTokenApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger getQiniuToken];
}

-(YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGet;
}

@end
