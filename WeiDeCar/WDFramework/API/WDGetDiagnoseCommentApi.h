//
//  WDGetDiagnoseCommentApi.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/11/1.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface WDGetDiagnoseCommentApi : MMNetworkRequest

@property (nonatomic,strong) NSString *diagnoseId;
@property (nonatomic,strong) NSString *commentType;  //评价类型，10：车主；20：专家

@end
