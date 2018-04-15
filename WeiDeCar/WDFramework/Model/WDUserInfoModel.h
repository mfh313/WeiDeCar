//
//  WDUserInfoModel.h
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/9.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSInteger const WDUserInfoType_CarOwner;
extern NSInteger const WDUserInfoType_Mechanic;
extern NSInteger const WDUserInfoType_Expert;
extern NSInteger const WDUserInfoType_ASSISTANT;

@interface WDUserInfoModel : NSObject

@property (nonatomic,strong) NSString *realName;
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *userId;

/**
 * 用户类型：
 * 10 车主
 * 20 技师
 * 30 第三方专家
 */
@property (nonatomic,assign) NSInteger userType;

@end
