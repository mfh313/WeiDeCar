//
//  WDUploadRepairStepPhotoApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/3/12.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDUploadRepairStepPhotoApi.h"

@implementation WDUploadRepairStepPhotoApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger uploadRepairStepPhoto];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"repairStepId"] = self.repairStepId;
    requestArgument[@"photoUrl"] = self.photoUrl;
    requestArgument[@"userId"] = self.userId;
    return requestArgument;
}

@end
