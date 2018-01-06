//
//  WeiDeApiManger.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/7.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WeiDeApiManger.h"

#define MFURL [WeiDeApiManger hostUrl]

#define MFURLWithPara(para) [MFURL stringByAppendingPathComponent:para]

NSString *const WeiDeUrl = @"http://www.5weide.com:8080/better-api/";
NSString *const test_WeiDeUrl = @"http://112.74.184.45:8080/better-api/";

@implementation WeiDeApiManger

+ (NSString *)hostUrl
{
    return WeiDeUrl;
}

//获取修理厂列表
+(NSString *)listRepairFactories
{
    return MFURLWithPara(@"api/entity/listRepairFactories");
}

//获取七牛Token
+(NSString *)getQiniuToken
{
    return MFURLWithPara(@"api/integration/getQiniuToken");
}

//获取萤石平台AccessToken
+(NSString *)getYs7AccessToken
{
    return MFURLWithPara(@"api/integration/getYs7AccessToken");
}

//用户登录接口
+(NSString *)userLogin
{
    return MFURLWithPara(@"api/user/login");
}

//车主注册接口
+(NSString *)carOwnerRegister
{
    return MFURLWithPara(@"api/user/carOwnerRegister");
}

//车主创建维修任务接口
+(NSString *)createDiagnoseByCarOwner
{
    return MFURLWithPara(@"api/diagnose/createDiagnoseByCarOwner");
}

//技师诊断接口
+(NSString *)mechanicDiagnose
{
    return MFURLWithPara(@"api/diagnose/mechanicDiagnose");
}

//车主确认诊断结果接口
+(NSString *)confirmDiagnoseByCarOwner
{
    return MFURLWithPara(@"api/diagnose/confirmDiagnoseByCarOwner");
}

//专家诊断接口
+(NSString *)expertDiagnose
{
    return MFURLWithPara(@"api/diagnose/expertDiagnose");
}

//车主获取维修列表接口
+(NSString *)listDiagnoseByCarOwner
{
    return MFURLWithPara(@"api/diagnose/listDiagnoseByCarOwner");
}

//专家获取维修列表接口
+(NSString *)listDiagnoseByExpert
{
    return MFURLWithPara(@"api/diagnose/listDiagnoseByExpert");
}

//技师获取维修列表接口
+(NSString *)listDiagnoseByMechanic
{
    return MFURLWithPara(@"api/diagnose/listDiagnoseByMechanic");
}

//专家复诊后，用户重新确认
+(NSString *)reconfirmAfterExpertDiagnosed
{
    return MFURLWithPara(@"api/diagnose/reconfirmAfterExpertDiagnosed");
}

@end
