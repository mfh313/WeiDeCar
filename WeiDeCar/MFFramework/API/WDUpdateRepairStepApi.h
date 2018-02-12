//
//  WDUpdateRepairStepApi.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/12.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface WDUpdateRepairStepApi : MMNetworkRequest

@property (nonatomic,strong) NSString *userId;
@property (nonatomic,assign) BOOL isExpert;
@property (nonatomic,strong) NSString *onsiteQualified; //现场质检结果，技师不传
@property (nonatomic,strong) NSString *thirdPartyQualifed; //第三方质检结果，技师不传
@property (nonatomic,strong) NSString *repairStepId;

@end
