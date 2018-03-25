//
//  WDConfirmDiagnoseByCarOwnerApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/10.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDConfirmDiagnoseByCarOwnerApi.h"

@implementation WDConfirmDiagnoseByCarOwnerApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger confirmDiagnoseByCarOwner];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    
    requestArgument[@"diagnoseId"] = self.diagnoseId;
    requestArgument[@"carOwnerId"] = self.carOwnerId;
    
    return requestArgument;
}

@end
