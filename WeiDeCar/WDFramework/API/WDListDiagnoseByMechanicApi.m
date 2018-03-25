//
//  WDListDiagnoseByMechanicApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/10.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDListDiagnoseByMechanicApi.h"

@implementation WDListDiagnoseByMechanicApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger listDiagnoseByMechanic];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"mechanicId"] = self.mechanicId;
    return requestArgument;
}

@end
