//
//  WDListDiagnoseByCarOwnerApi.h
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/10.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface WDListDiagnoseByCarOwnerApi : MMNetworkRequest

@property (nonatomic,strong) NSString *carOwnerId;

@end
