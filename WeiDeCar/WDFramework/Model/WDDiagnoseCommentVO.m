//
//  WDDiagnoseCommentVO.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/11/3.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDDiagnoseCommentVO.h"

@implementation WDDiagnoseCommentVO

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"diagnoseCommentId" : @"id",
             };
}

@end


#pragma mark - WDDiagnoseCommentDetailVO
@implementation WDDiagnoseCommentDetailVO

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"diagnoseCommentDetailId" : @"id",
             };
}

@end
