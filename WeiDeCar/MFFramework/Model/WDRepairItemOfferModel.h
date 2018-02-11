//
//  WDRepairItemOfferModel.h
//  WeiDeCar
//
//  Created by EEKA on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDRepairItemModel.h"

extern NSInteger const WDRepairItemOfferStatus_10;   //未选择
extern NSInteger const WDRepairItemOfferStatus_20;  //已选择

@interface WDRepairItemOfferModel : NSObject

@property (nonatomic,strong) NSString *createDate;
@property (nonatomic,strong) NSString *createUserId;
@property (nonatomic,strong) NSString *diagnoseId; //诊断任务ID
@property (nonatomic,strong) NSString *repairItemOfferId; //维修项目报价ID
@property (nonatomic,assign) CGFloat offerOf4s;  //4S店报价
@property (nonatomic,assign) CGFloat offerOfBetter;  //维德报价
@property (nonatomic,assign) CGFloat offerOfSpecialty;  //豪车专修店报价
@property (nonatomic,strong) WDRepairItemModel *repairItem; //维修项目
@property (nonatomic,strong) NSString *repairItemId; //维修项目ID
@property (nonatomic,strong) NSString *repairItemOfferName; //报价项目名称（配件/工时）
@property (nonatomic,strong) NSString *updateDate;
@property (nonatomic,strong) NSString *updateUserId;

@end
