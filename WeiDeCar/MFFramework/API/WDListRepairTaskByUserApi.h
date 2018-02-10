//
//  WDListRepairTaskByUserApi.h
//  WeiDeCar
//
//  Created by EEKA on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"
#import "WDUserInfoModel.h"

@interface WDListRepairTaskByUserApi : MMNetworkRequest

@property (nonatomic,strong) WDUserInfoModel *currentUser;

@end


