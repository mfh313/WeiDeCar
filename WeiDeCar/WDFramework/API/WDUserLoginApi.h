//
//  WDUserLoginApi.h
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/8.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"
#import "WDUserInfoModel.h"

@interface WDUserLoginApi : MMNetworkRequest

@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *passwd;

@end
