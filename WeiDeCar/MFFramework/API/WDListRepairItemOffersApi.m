//
//  WDListRepairItemOffersApi.m
//  WeiDeCar
//
//  Created by EEKA on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDListRepairItemOffersApi.h"

@implementation WDListRepairItemOffersApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger listRepairItemOffers];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"diagnoseId"] = self.diagnoseId;
    return requestArgument;
}

@end
