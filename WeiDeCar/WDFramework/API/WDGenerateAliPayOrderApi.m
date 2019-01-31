//
//  WDGenerateAliPayOrderApi.m
//  WeiDeCar
//
//  Created by EEKA on 2019/1/31.
//  Copyright © 2019年 mafanghua. All rights reserved.
//

#import "WDGenerateAliPayOrderApi.h"

@implementation WDGenerateAliPayOrderApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger aliPayGenerateOrder];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    
    [requestArgument safeSetObject:self.diagnoseId forKey:@"diagnoseId"];
    
    return requestArgument;
}

@end
