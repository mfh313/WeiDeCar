//
//  WDReconfirmAfterExpertDiagnosedApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/11.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDReconfirmAfterExpertDiagnosedApi.h"

@implementation WDReconfirmAfterExpertDiagnosedApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger reconfirmAfterExpertDiagnosed];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    
    requestArgument[@"diagnoseId"] = self.diagnoseId;
    requestArgument[@"carOwnerId"] = self.carOwnerId;
    
    return requestArgument;
}

@end
