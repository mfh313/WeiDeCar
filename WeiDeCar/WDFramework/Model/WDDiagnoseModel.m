//
//  WDDiagnoseModel.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/10.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDDiagnoseModel.h"

NSInteger const WDDiagnoseStatus_ABORT = 0;   //终止
NSInteger const WDDiagnoseStatus_INIT = 1000;  //初始状态
NSInteger const WDDiagnoseStatus_MECHANIC_DIAGNOSED = 2000;  //技师诊断完成，返回给车主查看
NSInteger const WDDiagnoseStatus_CAR_OWNER_CONFIRMED = 2500;  //技师诊断完成后，车主确认诊断结果
NSInteger const WDDiagnoseStatus_EXPERT_DIAGNOSED = 3000;  //专家复诊完成
NSInteger const WDDiagnoseStatus_CAR_OWNER_RECONFIRMED_AFTER_EXPERT_DIAGNOSED = 3500;  //诊断完成
NSInteger const WDDiagnoseStatus_REPAIR_TASK_CREATED = 4000;  //维修任务已创建
NSInteger const WDDiagnoseStatus_MECHANIC_ASSIGNED = 4100;  //维修任务已分配技师
NSInteger const WDDiagnoseStatus_MECHANIC_CERTIFICATED = 4101;  //维修技师能力被评定
NSInteger const WDDiagnoseStatus_OFFER_TO_BE_ACCEPTED = 4200;  //维修任务已报价，等待车主接受
NSInteger const WDDiagnoseStatus_OFFER_ACCEPTED = 4500;  //车主接受报价，待支付
NSInteger const WDDiagnoseStatus_PAYMENT_SUCCESS = 5000;  //支付成功，等待维修
NSInteger const WDDiagnoseStatus_PAYMENT_FAILURE = 5100;  //支付失败，等待重新支付
NSInteger const WDDiagnoseStatus_REPAIR_PROCESSING = 5500;  //正在维修
NSInteger const WDDiagnoseStatus_QA_SUCCESS = 6000;  //质检合格，待评价
NSInteger const WDDiagnoseStatus_QA_FAILURE = 6100;  //质检不合格
NSInteger const WDDiagnoseStatus_FINISHED = 10000;  //完成

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
