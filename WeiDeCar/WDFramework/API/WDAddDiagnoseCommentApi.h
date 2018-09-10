//
//  WDAddDiagnoseCommentApi.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/9/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"
#import "WDCommentKpiResultVO.h"

@interface WDAddDiagnoseCommentApi : MMNetworkRequest

@property (nonatomic,strong) NSString *diagnoseId;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *commentType;  //评价类型，10：车主；20：专家
@property (nonatomic,strong) WDCommentKpiResultVO *comments;
@property (nonatomic,strong) NSString *bonus;
@property (nonatomic,strong) NSString *commentContent;

@end
