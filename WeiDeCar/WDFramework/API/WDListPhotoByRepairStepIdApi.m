//
//  WDListPhotoByRepairStepIdApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/3/12.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDListPhotoByRepairStepIdApi.h"

@implementation WDListPhotoByRepairStepIdApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger listPhotoByRepairStepId];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"repairStepId"] = self.repairStepId;
    return requestArgument;
}

@end
