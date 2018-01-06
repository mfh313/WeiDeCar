//
//  WDCreateDiagnoseByCarOwnerApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/10.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDCreateDiagnoseByCarOwnerApi.h"

@implementation WDCreateDiagnoseByCarOwnerApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger createDiagnoseByCarOwner];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"carOwnerId"] = self.carOwnerId;
    return requestArgument;
}

@end
