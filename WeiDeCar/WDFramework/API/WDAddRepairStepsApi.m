//
//  WDAddRepairStepsApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/7/15.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDAddRepairStepsApi.h"

@implementation WDAddRepairStepsApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger addRepairSteps];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    
    requestArgument[@"repairItemId"] = self.repairItemId;
    requestArgument[@"userId"] = self.userId;
    
    NSMutableArray *repairStepsArray = [NSMutableArray array];
    [repairStepsArray addObject:self.repairSteps];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:repairStepsArray
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    requestArgument[@"repairSteps"] = jsonString;
    
    return requestArgument;
}

@end
