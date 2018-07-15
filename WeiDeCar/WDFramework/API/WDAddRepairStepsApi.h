//
//  WDAddRepairStepsApi.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/7/15.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"
#import "WDRepairStepAddRequest.h"

@interface WDAddRepairStepsApi : MMNetworkRequest

@property (nonatomic,strong) NSString *repairItemId;
@property (nonatomic,strong) WDRepairStepAddRequest *repairSteps;
@property (nonatomic,strong) NSString *userId;

@end
