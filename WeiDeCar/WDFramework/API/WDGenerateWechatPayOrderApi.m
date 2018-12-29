//
//  WDGenerateWechatPayOrderApi.m
//  WeiDeCar
//
//  Created by EEKA on 2018/12/29.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDGenerateWechatPayOrderApi.h"

@implementation WDGenerateWechatPayOrderApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger wechatPayGenerateOrder];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    
    [requestArgument safeSetObject:self.diagnoseId forKey:@"diagnoseId"];
    
    return requestArgument;
}

@end
