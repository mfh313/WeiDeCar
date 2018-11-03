//
//  WDUserDiagnoseCommentVO.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/11/3.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDDiagnoseCommentVO.h"

@interface WDUserDiagnoseCommentVO : NSObject

@property (nonatomic,strong) WDDiagnoseCommentVO *comment;
@property (nonatomic,strong) NSMutableArray<WDDiagnoseCommentDetailVO *> *details;

@end
