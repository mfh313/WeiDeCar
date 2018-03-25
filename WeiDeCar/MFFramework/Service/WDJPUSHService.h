//
//  WDJPUSHService.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/1/3.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMService.h"
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

extern NSString *const WDJPUSHService_Notification;

static NSString *appKey = @"901fa48d7789a6c8ada7a02a";
static NSString *channel = @"Publish channel";
static BOOL isProduction = TRUE;

@interface WDJPUSHService : MMService <JPUSHRegisterDelegate>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;
- (void)setPUSHAlias:(NSString *)alias;
- (void)deletePUSHAlias;

@end
