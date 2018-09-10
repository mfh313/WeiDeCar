//
//  WDListCommentKpiApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/9/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDListCommentKpiApi.h"

@implementation WDListCommentKpiApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger listCommentKpi];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    
    [requestArgument safeSetObject:self.commentType forKey:@"commentType"];
    
    return requestArgument;
}

@end
