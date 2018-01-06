//
//  WDAppViewControllerManager.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/11/27.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDAppViewControllerManager.h"
#import "WDGuideViewController.h"
#import "WDUserRegisterViewController.h"
#import "WDLoginViewController.h"
#import "WDMainFrameViewController.h"

@interface WDAppViewControllerManager ()
{
    WDMainFrameViewController *m_mainVC;
    
    MMNavigationController *m_guideRootNav;
}

@end

@implementation WDAppViewControllerManager

+ (id)getAppViewControllerManager
{
    static WDAppViewControllerManager *_sharedAppViewControllerManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedAppViewControllerManager = [[self alloc] init];
    });
    
    return _sharedAppViewControllerManager;
}

-(void)setRootMainWindow:(UIWindow *)window
{
    m_window = window;
}

-(void)launchGuideViewController
{
    WDGuideViewController *guideVC = [WDGuideViewController new];
    MMNavigationController *rootNav = [[MMNavigationController alloc] initWithRootViewController:guideVC];
    m_window.rootViewController = rootNav;
    
    m_guideRootNav = rootNav;
}

-(void)launchLoginViewController
{
    WDLoginViewController *loginVC = [WDLoginViewController new];
    MMNavigationController *rootNav = [[MMNavigationController alloc] initWithRootViewController:loginVC];
    [m_guideRootNav presentViewController:rootNav animated:NO completion:nil];
}

-(void)launchUserRegisterViewController
{
    WDUserRegisterViewController *registerVC = [WDUserRegisterViewController new];
    [m_guideRootNav pushViewController:registerVC animated:YES];
}

-(void)launchWDMainFrameViewController
{
    WDMainFrameViewController *mainFrameVC = [WDMainFrameViewController new];
    MMNavigationController *rootNav = [[MMNavigationController alloc] initWithRootViewController:mainFrameVC];
    m_window.rootViewController = rootNav;
}

@end
