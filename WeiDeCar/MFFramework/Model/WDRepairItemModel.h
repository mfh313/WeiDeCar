//
//  WDRepairItemModel.h
//  WeiDeCar
//
//  Created by EEKA on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDRepairTaskModel.h"

extern NSInteger const WDRepairItemStatus_DECLINED;   //拒绝报价
extern NSInteger const WDRepairItemStatus_ACCEPTED;  //接受报价
extern NSInteger const WDRepairItemStatus_REPAIR_PROCESSING;  //开始维修
extern NSInteger const WDRepairItemStatus_ALL_QUALIFIED;  //维修项目合格

@interface WDRepairItemModel : NSObject

@property (nonatomic,strong) NSString *createDate;
@property (nonatomic,strong) NSString *createUserId;
@property (nonatomic,strong) NSString *diagnoseId; //诊断任务ID
@property (nonatomic,strong) NSString *repairItemId; //维修项目ID
@property (nonatomic,strong) NSString *repairItemName; //维修项目名称
@property (nonatomic,strong) WDRepairTaskModel *repairTask;
@property (nonatomic,assign) NSInteger status;  //维修项目状态，10：未选择，20：已选择
@property (nonatomic,strong) NSString *updateDate;
@property (nonatomic,strong) NSString *updateUserId;

@end


