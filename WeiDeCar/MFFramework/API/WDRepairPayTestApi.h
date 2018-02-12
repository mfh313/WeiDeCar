//
//  WDRepairPayTestApi.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/12.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface WDRepairPayTestApi : MMNetworkRequest

@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *diagnoseId;

@end

