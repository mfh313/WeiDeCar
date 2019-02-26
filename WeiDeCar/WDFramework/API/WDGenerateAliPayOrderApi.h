//
//  WDGenerateAliPayOrderApi.h
//  WeiDeCar
//
//  Created by EEKA on 2019/1/31.
//  Copyright © 2019年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface WDGenerateAliPayOrderApi : MMNetworkRequest

@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *diagnoseId;

@end
