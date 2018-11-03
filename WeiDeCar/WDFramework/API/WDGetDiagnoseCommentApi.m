//
//  WDGetDiagnoseCommentApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/11/1.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDGetDiagnoseCommentApi.h"

@implementation WDGetDiagnoseCommentApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger getDiagnoseComment];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    
    [requestArgument safeSetObject:self.diagnoseId forKey:@"diagnoseId"];
    
    return requestArgument;
}

@end
