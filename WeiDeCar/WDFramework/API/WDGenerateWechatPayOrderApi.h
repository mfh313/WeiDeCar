//
//  WDGenerateWechatPayOrderApi.h
//  WeiDeCar
//
//  Created by EEKA on 2018/12/29.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface WDGenerateWechatPayOrderApi : MMNetworkRequest

@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *diagnoseId;

@end
