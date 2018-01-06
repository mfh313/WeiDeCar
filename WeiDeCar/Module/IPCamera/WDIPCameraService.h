//
//  WDIPCameraService.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/1/2.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMService.h"

#define EZUIKitAppKey           @"00ae86f197f9402d9ae57a63fcdca117"
#define EZUIKitAccessToken      @"at.5ahkpp1d09gi1lz54d3z773ldejctmz6-60ri5aj24n-0pi1lnx-npbtaopqo"
#define EZUIKitUrlStr           @"ezopen://AES:m8h-CfFe5Y55g7UUsRZrhA@open.ys7.com/805298341/1.hd.live"

@interface WDIPCameraService : MMService
{
    NSString *m_accessToken;
}

-(NSString *)getYs7AccessToken;

@end
