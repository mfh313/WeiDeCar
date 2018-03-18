//
//  AlipayManager.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/3/18.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>

@interface AlipayManager : NSObject

+ (instancetype)sharedManager;

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options;

@end
