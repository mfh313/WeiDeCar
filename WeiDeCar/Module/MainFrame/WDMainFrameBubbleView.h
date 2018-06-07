//
//  WDMainFrameBubbleView.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/6/7.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDMainFrameBubbleObject.h"

@interface WDMainFrameBubbleView : UIView
{
    UIView *m_bubbleView;
    UIView *m_centerView;
}

-(void)setMainFrameBubbleObject:(WDMainFrameBubbleObject *)bubbleObject;

@end
