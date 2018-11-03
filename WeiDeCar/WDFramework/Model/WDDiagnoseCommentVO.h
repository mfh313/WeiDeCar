//
//  WDDiagnoseCommentVO.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/11/3.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDDiagnoseCommentVO : NSObject

@property (nonatomic,strong) NSDecimalNumber *bonus; //奖金
@property (nonatomic,strong) NSString *commentContent;
@property (nonatomic,assign) NSInteger commentType; //评价类型：10：车主评价；20：专家评价
@property (nonatomic,strong) NSString *diagnoseId;
@property (nonatomic,strong) NSString *diagnoseCommentId;

@end

#pragma mark - WDDiagnoseCommentDetailVO
@interface WDDiagnoseCommentDetailVO : NSObject

@property (nonatomic,strong) NSString *diagnoseCommentId;
@property (nonatomic,strong) NSString *diagnoseCommentDetailId;
@property (nonatomic,strong) NSString *kpiKey;
@property (nonatomic,strong) NSString *kpiKeyName;
@property (nonatomic,assign) NSInteger kpiResult;

@end


