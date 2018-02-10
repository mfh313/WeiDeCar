//
//  WDGetRepairItemsApi.m
//  WeiDeCar
//
//  Created by EEKA on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDGetRepairItemsApi.h"

@implementation WDGetRepairItemsApi

-(NSString *)requestUrl
{
    NSInteger userType = self.currentUser.userType;
    if (self.currentUser.userType == WDUserInfoType_CarOwner)
    {
        return [WeiDeApiManger listDiagnoseByCarOwner];
    }
    else if (self.currentUser.userType == WDUserInfoType_Mechanic)
    {
        return [WeiDeApiManger listDiagnoseByMechanic];
    }
    else if (self.currentUser.userType == WDUserInfoType_Expert)
    {
        return [WeiDeApiManger listDiagnoseByExpert];
    }
    
    return nil;
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    
    NSString *userId = self.userInfo.userId;
    
    if (self.userInfo.userType == WDUserInfoType_CarOwner)
    {
        requestArgument[@"carOwnerId"] = userId;
    }
    else if (self.userInfo.userType == WDUserInfoType_Mechanic)
    {
        requestArgument[@"mechanicId"] = userId;
    }
    else if (self.userInfo.userType == WDUserInfoType_Expert)
    {
        requestArgument[@"expertId"] = userId;
    }
    
    return requestArgument;
}

@end
