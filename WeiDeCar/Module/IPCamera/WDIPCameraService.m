//
//  WDIPCameraService.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/1/2.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDIPCameraService.h"
#import "WDGetYs7AccessTokenApi.h"

@implementation WDIPCameraService

-(NSString *)getYs7AccessToken
{
    if (m_accessToken) {
        return m_accessToken;
    }
    
    WDGetYs7AccessTokenApi *mfApi = [WDGetYs7AccessTokenApi new];
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        if (!mfApi.messageSuccess) {
            return;
        }
        m_accessToken = request.responseJSONObject[@"data"];
        
    } failure:^(YTKBaseRequest * request) {

    }];
    
    m_accessToken = EZUIKitAccessToken;
    return m_accessToken;
}

@end
