//
//  WDLoginService.h
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/9.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMService.h"
#import "WDUserInfoModel.h"

@interface WDLoginService : MMService

@property (nonatomic,strong) WDUserInfoModel *currentUserInfo;
@property (nonatomic,strong) NSString *token;

@end
