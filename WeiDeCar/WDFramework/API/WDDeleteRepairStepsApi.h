//
//  WDDeleteRepairStepsApi.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/7/15.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface WDDeleteRepairStepsApi : MMNetworkRequest

@property (nonatomic,strong) NSString *repairStepIds;

@end
