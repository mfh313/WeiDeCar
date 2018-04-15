//
//  WDDiagnoseModel.h
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/10.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSInteger const WDDiagnoseStatus_ABORT;   //终止
extern NSInteger const WDDiagnoseStatus_INIT;  //初始状态
extern NSInteger const WDDiagnoseStatus_MECHANIC_DIAGNOSED;  //技师诊断完成，返回给车主查看
extern NSInteger const WDDiagnoseStatus_CAR_OWNER_CONFIRMED;  //技师诊断完成后，车主确认诊断结果
extern NSInteger const WDDiagnoseStatus_EXPERT_DIAGNOSED;  //专家复诊完成
extern NSInteger const WDDiagnoseStatus_CAR_OWNER_RECONFIRMED_AFTER_EXPERT_DIAGNOSED;  //诊断完成
extern NSInteger const WDDiagnoseStatus_REPAIR_TASK_CREATED;  //维修任务已创建
extern NSInteger const WDDiagnoseStatus_MECHANIC_ASSIGNED;  //维修任务已分配技师
extern NSInteger const WDDiagnoseStatus_MECHANIC_CERTIFICATED;  //维修技师能力被评定
extern NSInteger const WDDiagnoseStatus_OFFER_TO_BE_ACCEPTED;  //维修任务已报价，等待车主接受
extern NSInteger const WDDiagnoseStatus_OFFER_ACCEPTED;  //车主接受报价，待支付
extern NSInteger const WDDiagnoseStatus_PAYMENT_SUCCESS;  //支付成功，等待维修
extern NSInteger const WDDiagnoseStatus_PAYMENT_FAILURE;  //支付失败，等待重新支付
extern NSInteger const WDDiagnoseStatus_REPAIR_PROCESSING;  //正在维修
extern NSInteger const WDDiagnoseStatus_QA_SUCCESS;  //质检合格，待评价
extern NSInteger const WDDiagnoseStatus_QA_FAILURE;  //质检不合格
extern NSInteger const WDDiagnoseStatus_FINISHED;  //完成

#pragma mark - WDDiagnoseCauseJudgementModel
@interface WDDiagnoseCauseJudgementModel : NSObject

@property (nonatomic,strong) NSString *causeJudgeExpertId; //诊断专家ID（如果本条原因是由专家添加的话）
@property (nonatomic,strong) NSString *causeJudgeMechanicId; //诊断技师ID（如果本条原因是由技师添加的话
@property (nonatomic,strong) NSString *causeJudgementCode; //原因判断编码（预留）
@property (nonatomic,strong) NSString *causeJudgementName; //原因判断名称
@property (nonatomic,strong) NSString *expertDiagnoseResult; //专家复诊结果（Y/N）
@property (nonatomic,strong) NSString *isCertain; //确定原因（Y/N）
@property (nonatomic,strong) NSString *isCheapest; //确定原因（Y/N）
@property (nonatomic,strong) NSString *isMostPossible; //最可能原因（Y/N）
@property (nonatomic,assign) NSInteger judgementSource;  //判断来源（10：技师；20：专家）

@end

#pragma mark - WDDiagnoseItemFaultAppearanceModel
@interface WDDiagnoseItemFaultAppearanceModel : NSObject

@property (nonatomic,strong) NSMutableArray<WDDiagnoseCauseJudgementModel *> *causeJudgements;
@property (nonatomic,strong) NSString *expertAdvices;   //专家意见
@property (nonatomic,strong) NSString *faultAppearanceCode;   //故障现象编码（预留）
@property (nonatomic,strong) NSString *faultAppearanceName;   //故障现象名称
@property (nonatomic,strong) NSString *memo;   //技师备注
@property (nonatomic,strong) NSString *repairPlanCode;   //维修方案编码（预留）
@property (nonatomic,strong) NSString *repairPlanName;   //维修方案名称

@end

#pragma mark - WDDiagnoseItemModel
@interface WDDiagnoseItemModel : NSObject

@property (nonatomic,strong) NSMutableArray<WDDiagnoseItemFaultAppearanceModel *> *faultAppearances;

@end

#pragma mark - WDDiagnoseModel
@interface WDDiagnoseModel : NSObject

@property (nonatomic,strong) NSString *carOwnerDesc;   //车主描述
@property (nonatomic,strong) NSString *carOwnerId;    //车主ID
@property (nonatomic,strong) NSString *createDate;    //创建日期
@property (nonatomic,strong) WDDiagnoseItemModel *diagnoseItems;   //诊断数据
@property (nonatomic,strong) NSString *expertDiagnoseDate;  //专家诊断日期
@property (nonatomic,strong) NSString *expertId;    //专家ID
@property (nonatomic,strong) NSString *diagnoseId;
@property (nonatomic,strong) NSString *mechanicDiagnoseDate; //技师诊断日期
@property (nonatomic,strong) NSString *mechanicId; //技师ID
@property (nonatomic,strong) NSString *repairFactoryId; //修理厂ID
@property (nonatomic,assign) NSInteger status;
@property (nonatomic,strong) NSString *updateDate; //更新日期
@property (nonatomic,strong) NSString *statusName;

@end
