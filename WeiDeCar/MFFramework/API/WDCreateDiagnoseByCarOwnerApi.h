//
//  WDCreateDiagnoseByCarOwnerApi.h
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/10.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface WDCreateDiagnoseByCarOwnerApi : MMNetworkRequest

@property (nonatomic,strong) NSString *carOwnerId;
@property (nonatomic,strong) NSString *repairFactoryId;
@property (nonatomic,strong) NSString *mechanicId;
@property (nonatomic,strong) NSString *carOwnerDesc;

@end
