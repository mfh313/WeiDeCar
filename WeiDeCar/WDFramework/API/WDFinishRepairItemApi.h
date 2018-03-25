//
//  WDFinishRepairItemApi.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/3/5.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface WDFinishRepairItemApi : MMNetworkRequest

@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *repairItemId;

@end
