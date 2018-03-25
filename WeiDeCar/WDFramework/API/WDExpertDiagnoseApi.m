//
//  WDExpertDiagnoseApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/10.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDExpertDiagnoseApi.h"
#import "WDDiagnoseModel.h"

@implementation WDExpertDiagnoseApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger expertDiagnose];
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
    requestArgument[@"expertId"] = self.expertId;
    
    return requestArgument;
}

@end
