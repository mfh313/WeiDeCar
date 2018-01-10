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

@interface WDJPUSHService : MMService

- (void)setPUSHAlias:(NSString *)alias;
- (void)deletePUSHAlias;

@end
