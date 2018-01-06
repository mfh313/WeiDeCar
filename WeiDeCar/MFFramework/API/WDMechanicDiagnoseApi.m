//
//  WDMechanicDiagnoseApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/10.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDMechanicDiagnoseApi.h"
#import "WDDiagnoseModel.h"

@implementation WDMechanicDiagnoseApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger mechanicDiagnose];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    
    NSDictionary *modelJSON = [self.diagnoseData yy_modelToJSONObject];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:modelJSON
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    requestArgument[@"diagnoseData"] = jsonString;
    requestArgument[@"diagnoseId"] = self.diagnoseId;
    requestArgument[@"mechanicId"] = self.mechanicId;
    
    return requestArgument;
}

@end
