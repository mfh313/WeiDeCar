//
//  WDListDiagnoseMechanicCertificationsApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/7/15.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDListDiagnoseMechanicCertificationsApi.h"

@implementation WDListDiagnoseMechanicCertificationsApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger listDiagnoseMechanicCertifications];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    
    requestArgument[@"diagnoseId"] = self.diagnoseId;
    
    return requestArgument;
}

@end
