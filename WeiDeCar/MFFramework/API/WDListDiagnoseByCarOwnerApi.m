//
//  WDListDiagnoseByCarOwnerApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/10.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDListDiagnoseByCarOwnerApi.h"

@implementation WDListDiagnoseByCarOwnerApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger listDiagnoseByCarOwner];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"carOwnerId"] = self.carOwnerId;
    return requestArgument;
}

@end
