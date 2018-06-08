//
//  WDAppViewControllerManager.h
//  WeiDeCar
//
//  Created by mafanghua on 2017/11/27.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMService.h"

@interface WDAppViewControllerManager : MMService
{
    UIWindow *m_window;
}

+(id)getAppViewControllerManager;
-(void)setRootMainWindow:(UIWindow *)window;
-(void)launchGuideViewController;
-(void)launchLoginViewController;
-(void)launchWDMainFrameViewController;
-(MMNavigationController *)guideRootNav;

@end
