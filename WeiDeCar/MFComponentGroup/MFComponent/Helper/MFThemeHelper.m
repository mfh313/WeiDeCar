//
//  MFThemeHelper.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/17.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFThemeHelper.h"

@implementation MFThemeHelper

+(void)setDefaultThemeColor
{
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowColor = [UIColor clearColor];
    NSDictionary *textAttributes = @{NSShadowAttributeName: shadow,NSForegroundColorAttributeName:MFCustomNavBarTitleColor,NSFontAttributeName:[UIFont systemFontOfSize:17.0]};
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
    [[UINavigationBar appearance] setTintColor:MFCustomNavBarColor];
    
    [[UINavigationBar appearance] setBackgroundImage:MFImageStretchCenter(@"nav_bg") forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    
    [[UITextField appearance] setTintColor:MFCustomNavBarColor];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor hx_colorWithHexString:@"71D0FF"]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:MFCustomNavBarColor} forState:UIControlStateSelected];

    [LGAlertView appearance].tintColor = [UIColor hx_colorWithHexString:@"f5f5f5"];
    [LGAlertView appearance].titleFont = [UIFont systemFontOfSize:18.0];
    [LGAlertView appearance].messageFont = [UIFont systemFontOfSize:15.0];
    [LGAlertView appearance].cancelButtonTitleColor = MFWDBlueColor;
    [LGAlertView appearance].cancelButtonTitleColorHighlighted = MFBlackColor;
    [LGAlertView appearance].cancelButtonFont = [UIFont systemFontOfSize:15.0];
    [LGAlertView appearance].buttonsFont = [UIFont systemFontOfSize:15.0];
    [LGAlertView appearance].buttonsTitleColor = MFBlackColor;
    [LGAlertView appearance].buttonsTitleColorHighlighted = MFWDBlueColor;

}

@end
