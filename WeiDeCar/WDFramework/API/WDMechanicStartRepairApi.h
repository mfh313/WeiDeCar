//
//  WDMechanicStartRepairApi.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface WDMechanicStartRepairApi : MMNetworkRequest

@property (nonatomic,strong) NSString *repairItemId;
@property (nonatomic,strong) NSString *mechanicId;

@end
