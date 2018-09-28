//
//  WDRepairWxPrePayApi.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/9/28.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface WDRepairWxPrePayApi : MMNetworkRequest

@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *number;
@property (nonatomic,strong) NSString *body;
@property (nonatomic,strong) NSString *clientIp;

@end
