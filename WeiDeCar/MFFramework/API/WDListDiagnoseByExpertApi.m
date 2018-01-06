//
//  WDListDiagnoseByExpertApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/10.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDListDiagnoseByExpertApi.h"

@implementation WDListDiagnoseByExpertApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger listDiagnoseByExpert];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"expertId"] = self.expertId;
    return requestArgument;
}

@end
