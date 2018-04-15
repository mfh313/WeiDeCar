//
//  WDRepairStepModel.h
//  WeiDeCar
//
//  Created by EEKA on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSInteger const WDRepairStepQualifiedStatus_UNQUALIFIED;   //检验不合格
extern NSInteger const WDRepairStepQualifiedStatus_QUALIFIED;  //检验合格

extern NSInteger const WDRepairStepStatus_INIT;   //初始状态
extern NSInteger const WDRepairStepStatus_START_REPAIR;  //开始维修
extern NSInteger const WDRepairStepStatus_MECHANIC_FINISHED;  //技师维修完成
extern NSInteger const WDRepairStepStatus_QUALIFIED;  //该步骤合格
extern NSInteger const WDRepairStepStatus_UNQUALIFIED;  //该步骤不合格

@interface WDRepairStepModel : NSObject

@property (nonatomic,strong) NSString *createDate;
@property (nonatomic,strong) NSString *createUserId;
@property (nonatomic,strong) NSString *repairStepId;
@property (nonatomic,assign) NSInteger onsiteQualified; //现场检查是否合格，字典值
@property (nonatomic,strong) NSString *repairItemId; //维修项目ID
@property (nonatomic,assign) NSInteger repairOrder; //步骤顺序
@property (nonatomic,strong) NSString *repairStepDesc; //步骤描述
@property (nonatomic,assign) NSInteger status; //维修状态
@property (nonatomic,strong) NSString *statusName; //维修状态文字
@property (nonatomic,assign) NSInteger thirdPartyQualified; //第三方质检是否合格，字典值
@property (nonatomic,strong) NSString *updateDate;
@property (nonatomic,strong) NSString *updateUserId;

@end
