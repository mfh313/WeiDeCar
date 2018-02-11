//
//  WDListRepairItemApi.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/11.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface WDListRepairItemApi : MMNetworkRequest

@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *diagnoseId;

@end
