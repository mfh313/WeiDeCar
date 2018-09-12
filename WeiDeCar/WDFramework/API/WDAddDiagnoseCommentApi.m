//
//  WDAddDiagnoseCommentApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/9/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDAddDiagnoseCommentApi.h"

@implementation WDAddDiagnoseCommentApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger addDiagnoseComment];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    
    [requestArgument safeSetObject:self.diagnoseId forKey:@"diagnoseId"];
    [requestArgument safeSetObject:self.userId forKey:@"userId"];
    [requestArgument safeSetObject:self.commentType forKey:@"commentType"];
    [requestArgument safeSetObject:self.bonus forKey:@"bonus"];
    [requestArgument safeSetObject:self.commentContent forKey:@"commentContent"];
    
    NSMutableArray *commentsArray = [NSMutableArray array];
    for (int i = 0; i < self.comments.count; i++) {
        WDCommentKpiResultVO *resultVO = self.comments[i];
        [commentsArray addObject:[resultVO yy_modelToJSONObject]];
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:commentsArray
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [requestArgument safeSetObject:jsonString forKey:@"comments"];
    
    return requestArgument;
}

@end
