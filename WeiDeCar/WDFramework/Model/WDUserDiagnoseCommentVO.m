//
//  WDUserDiagnoseCommentVO.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/11/3.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDUserDiagnoseCommentVO.h"

@implementation WDUserDiagnoseCommentVO

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"comment" : [WDDiagnoseCommentVO class],
             @"details" : [WDDiagnoseCommentDetailVO class],
             };
}

@end
