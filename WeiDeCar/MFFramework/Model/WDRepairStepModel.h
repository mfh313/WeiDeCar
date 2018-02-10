//
//  WDRepairStepModel.h
//  WeiDeCar
//
//  Created by EEKA on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDRepairStepModel : NSObject

@property (nonatomic,strong) NSString *createDate;
@property (nonatomic,strong) NSString *createUserId;
@property (nonatomic,strong) NSString *repairStepId;
@property (nonatomic,strong) NSString *repairItemId; //维修项目ID
@property (nonatomic,assign) NSInteger repairOrder; //步骤顺序
@property (nonatomic,strong) NSString *repairStepDesc; //步骤描述
@property (nonatomic,strong) NSString *updateDate;
@property (nonatomic,strong) NSString *updateUserId;

@end
