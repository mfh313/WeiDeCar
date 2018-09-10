//
//  WDListCommentBonusApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/9/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDListCommentBonusApi.h"

@implementation WDListCommentBonusApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger listCommentBonus];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    
    [requestArgument safeSetObject:self.commentType forKey:@"commentType"];

    return requestArgument;
}

@end
