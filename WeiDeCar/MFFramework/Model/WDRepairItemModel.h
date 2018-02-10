//
//  WDRepairItemModel.h
//  WeiDeCar
//
//  Created by EEKA on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSInteger const WDRepairItemStatus_10;   //未选择
extern NSInteger const WDRepairItemStatus_20;  //已选择

@interface WDRepairItemModel : NSObject

@property (nonatomic,strong) NSString *createDate;
@property (nonatomic,strong) NSString *createUserId;
@property (nonatomic,strong) NSString *diagnoseId; //诊断任务ID
@property (nonatomic,strong) NSString *repairItemId; //维修项目ID
@property (nonatomic,strong) NSString *repairItemName; //维修项目名称
@property (nonatomic,assign) NSInteger status;  //维修项目状态，10：未选择，20：已选择
@property (nonatomic,strong) NSString *updateDate;
@property (nonatomic,strong) NSString *updateUserId;

@end
