//
//  WDRepairItemAssignmentModel.h
//  WeiDeCar
//
//  Created by EEKA on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDRepairItemModel.h"

@interface WDRepairItemAssignmentModel : NSObject

@property (nonatomic,strong) NSString *assignedMechanicId; //分配技师ID
@property (nonatomic,strong) NSString *createDate;
@property (nonatomic,strong) NSString *createUserId;
@property (nonatomic,strong) NSString *diagnoseId; //诊断任务ID
@property (nonatomic,strong) NSString *hasRepairExperience; //有维修经验（Y/N）
@property (nonatomic,strong) NSString *repairItemAssignmentId; //维修项目分配ID
@property (nonatomic,strong) NSString *knowProcess; //技师了解该流程
@property (nonatomic,strong) NSString *needExpertGuide; //需要专家指导（Y/N）
@property (nonatomic,strong) NSString *qualified; //是否合格
@property (nonatomic,strong) WDRepairItemModel *repairItem; //维修项目
@property (nonatomic,strong) NSString *repairItemId; //维修项目ID
@property (nonatomic,strong) NSString *updateDate;
@property (nonatomic,strong) NSString *updateUserId;

@end
