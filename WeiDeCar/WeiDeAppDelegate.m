//
//  WeiDeAppDelegate.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/11/13.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WeiDeAppDelegate.h"
#import "WDAppViewControllerManager.h"
#import "MMServiceCenter.h"
#import "MFThemeHelper.h"
#import "IQKeyboardManager.h"
#import "WDJPUSHService.h"
#import "WXApiManager.h"
#import "AlipayManager.h"

@interface WeiDeAppDelegate ()
{
    MMServiceCenter *m_serviceCenter;
    WDAppViewControllerManager *m_appViewControllerMgr;
}

@end

@implementation WeiDeAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    m_appViewControllerMgr = [WDAppViewControllerManager getAppViewControllerManager];
    [m_appViewControllerMgr setRootMainWindow:self.window];
    
    [m_appViewControllerMgr launchGuideViewController];
    
    [MFThemeHelper setDefaultThemeColor];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    WDJPUSHService *pushService = [[MMServiceCenter defaultCenter] getService:[WDJPUSHService class]];
    [pushService application:application didFinishLaunchingWithOptions:launchOptions];
    
    [self registerAMapKit];
    [self registerWXPay];
    
    return YES;
}

- (void)registerWXPay
{
    [WXApi registerApp:WXKey enableMTA:NO];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        return [[AlipayManager sharedManager] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    }
    
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        return [[AlipayManager sharedManager] application:app openURL:url options:options];
    }
    
    return YES;
}

- (void)registerAMapKit
{
    NSString *AMapKey = nil;
    NSString *bundleID = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    if ([bundleID isEqualToString:@"com.weidecar.wd"]) {
        AMapKey = @"fe189b4fa2736b75cae556a13911f9a2";
    }
    else if ([bundleID isEqualToString:@"cn.mafanghua.WeiDeCar"])
    {
        AMapKey = @"d06957de9c049c5da29c437837874158";
    }
    
    [AMapServices sharedServices].apiKey = AMapKey;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    WDJPUSHService *pushService = [[MMServiceCenter defaultCenter] getService:[WDJPUSHService class]];
    [pushService application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler {

}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.

- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}

#endif

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    WDJPUSHService *pushService = [[MMServiceCenter defaultCenter] getService:[WDJPUSHService class]];
    [pushService application:application didReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    
    WDJPUSHService *pushService = [[MMServiceCenter defaultCenter] getService:[WDJPUSHService class]];
    [pushService application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
    
}

@end
