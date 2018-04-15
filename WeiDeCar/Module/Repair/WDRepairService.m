//
//  WDRepairService.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/4/15.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairService.h"

@implementation WDRepairService

-(BOOL)canStartRepairItem:(WDRepairItemModel *)repairItem
{
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    WDUserInfoModel *currentUserInfo = loginService.currentUserInfo;
    
    if (repairItem.status == WDRepairItemStatus_ACCEPTED)
    {
        if (currentUserInfo.userType == WDUserInfoType_Mechanic
            || currentUserInfo.userType == WDUserInfoType_ASSISTANT)
        {
            return YES;
        }
    }
    
    return NO;
}

-(BOOL)canOperateQualified
{
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    WDUserInfoModel *currentUserInfo = loginService.currentUserInfo;
    if (currentUserInfo.userType == WDUserInfoType_Expert || currentUserInfo.userType == WDUserInfoType_ASSISTANT)
    {
        return YES;
    }
    
    return NO;
}

@end
