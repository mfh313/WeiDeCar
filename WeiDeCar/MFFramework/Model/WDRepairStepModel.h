//
//  WDRepairStepModel.h
//  WeiDeCar
//
//  Created by EEKA on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSInteger const WDRepairStepQualifiedStatus_10;   //初始状态
extern NSInteger const WDRepairStepQualifiedStatus_20;  //开始维修
extern NSInteger const WDRepairStepQualifiedStatus_30;  //检验不合格
extern NSInteger const WDRepairStepQualifiedStatus_40;  //检验合格

@interface WDRepairStepModel : NSObject

@property (nonatomic,strong) NSString *createDate;
@property (nonatomic,strong) NSString *createUserId;
@property (nonatomic,strong) NSString *repairStepId;
@property (nonatomic,assign) NSInteger onsiteQualified; //现场检查是否合格，字典值
@property (nonatomic,strong) NSString *repairItemId; //维修项目ID
@property (nonatomic,assign) NSInteger repairOrder; //步骤顺序
@property (nonatomic,strong) NSString *repairStepDesc; //步骤描述
@property (nonatomic,assign) NSInteger thirdPartyQualifed; //第三方质检是否合格，字典值
@property (nonatomic,strong) NSString *updateDate;
@property (nonatomic,strong) NSString *updateUserId;

@end
