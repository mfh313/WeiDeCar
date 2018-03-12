//
//  WeiDeApiManger.h
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/7.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMService.h"

@interface WeiDeApiManger : MMService

//根据维修步骤ID查询图片接口
+(NSString *)listPhotoByRepairStepId;

//维修步骤图片上传接口
+(NSString *)uploadRepairStepPhoto;

//维修项目整体完成
+(NSString *)finishRepairItem;

//模拟支付成功接口
+(NSString *)repairPayTest;

//更新维修步骤状态，技师/专家可用
+(NSString *)updateRepairStep;

//获取维修项目步骤
+(NSString *)listRepairStep;

//获取维修项目列表
+(NSString *)listRepairItem;

//技师开始维修项目
+(NSString *)mechanicStartRepairItem;

//根据用户ID查询维修任务列表
+(NSString *)listRepairTaskByUser;

//车主选择维修项目报价接口
+(NSString *)chooseRepairItemOffers;

//获取维修项目报价
+(NSString *)listRepairItemOffers;

//获取修理厂列表
+(NSString *)listRepairFactories;

//获取七牛Token
+(NSString *)getQiniuToken;

//获取萤石平台AccessToken
+(NSString *)getYs7AccessToken;

//用户登录接口
+(NSString *)userLogin;

//车主注册接口
+(NSString *)carOwnerRegister;

//车主创建维修任务接口
+(NSString *)createDiagnoseByCarOwner;

//技师诊断接口
+(NSString *)mechanicDiagnose;

//车主确认诊断结果接口
+(NSString *)confirmDiagnoseByCarOwner;

//专家诊断接口
+(NSString *)expertDiagnose;

//车主获取维修列表接口
+(NSString *)listDiagnoseByCarOwner;

//专家获取维修列表接口
+(NSString *)listDiagnoseByExpert;

//技师获取维修列表接口
+(NSString *)listDiagnoseByMechanic;

//专家复诊后，用户重新确认
+(NSString *)reconfirmAfterExpertDiagnosed;

+(BOOL)packageIsAppStoreChannel;

@end



/*
 网页
http://112.74.184.45:8080/better-api/interfaces
 */
