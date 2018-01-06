//
//  WDMechanicDiagnoseApi.h
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/10.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@class WDDiagnoseItemModel;
@interface WDMechanicDiagnoseApi : MMNetworkRequest

@property (nonatomic,strong) NSString *diagnoseId;
@property (nonatomic,strong) NSString *mechanicId;
@property (nonatomic,strong) WDDiagnoseItemModel *diagnoseData;

@end
