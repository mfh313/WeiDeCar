//
//  WDCommentKpiResultVO.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/9/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const WDDiagnose_commentType_10;
extern NSString * const WDDiagnose_commentType_20;

@interface WDCommentKpiResultVO : NSObject

@property (nonatomic,strong) NSString *commentKpi;
@property (nonatomic,assign) NSInteger commentKpiResult;

@end
