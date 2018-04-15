//
//  WDDiagnoseModel.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/10.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDDiagnoseModel.h"

NSInteger const WDDiagnoseStatus_ABORT = 0;   //终止
NSInteger const WDDiagnoseStatus_INIT = 10;  //初始状态
NSInteger const WDDiagnoseStatus_MECHANIC_DIAGNOSED = 20;  //技师诊断完成，返回给车主查看
NSInteger const WDDiagnoseStatus_CAR_OWNER_CONFIRMED = 25;  //技师诊断完成后，车主确认诊断结果
NSInteger const WDDiagnoseStatus_EXPERT_DIAGNOSED = 30;  //专家复诊完成
NSInteger const WDDiagnoseStatus_CAR_OWNER_RECONFIRMED_AFTER_EXPERT_DIAGNOSED = 35;  //诊断完成
NSInteger const WDDiagnoseStatus_REPAIR_TASK_CREATED = 40;  //维修任务已创建
NSInteger const WDDiagnoseStatus_MECHANIC_ASSIGNED = 41;  //维修任务已分配技师
NSInteger const WDDiagnoseStatus_MECHANIC_CERTIFICATED = 4101;  //维修技师能力被评定
NSInteger const WDDiagnoseStatus_OFFER_TO_BE_ACCEPTED = 42;  //维修任务已报价，等待车主接受
NSInteger const WDDiagnoseStatus_OFFER_ACCEPTED = 45;  //车主接受报价，待支付
NSInteger const WDDiagnoseStatus_PAYMENT_SUCCESS = 50;  //支付成功，等待维修
NSInteger const WDDiagnoseStatus_PAYMENT_FAILURE = 51;  //支付失败，等待重新支付
NSInteger const WDDiagnoseStatus_REPAIR_PROCESSING = 55;  //正在维修
NSInteger const WDDiagnoseStatus_QA_SUCCESS = 60;  //质检合格，待评价
NSInteger const WDDiagnoseStatus_QA_FAILURE = 61;  //质检不合格
NSInteger const WDDiagnoseStatus_FINISHED = 100;  //完成

#pragma mark - WDDiagnoseCauseJudgementModel
@implementation WDDiagnoseCauseJudgementModel


@end

#pragma mark - WDDiagnoseItemFaultAppearanceModel
@implementation WDDiagnoseItemFaultAppearanceModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"causeJudgements" : [WDDiagnoseCauseJudgementModel class]};
}

@end

#pragma mark - WDDiagnoseItemModel
@implementation WDDiagnoseItemModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"faultAppearances" : [WDDiagnoseItemFaultAppearanceModel class]};
}

@end

#pragma mark - WDDiagnoseModel
@implementation WDDiagnoseModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"diagnoseId" : @"id",
             @"diagnoseItems" : @"diagnoseRequest"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"diagnoseItems" : [WDDiagnoseItemModel class]};
}

@end
