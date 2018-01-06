//
//  WDMainFrameMenuView.h
//  WeiDeCar
//
//  Created by mafanghua on 2017/11/28.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class WDMainFrameMenuView;
@protocol WDMainFrameMenuViewDelegate <NSObject>

@optional
-(void)onClickMainFrameMenuViewIndex:(NSInteger)actionIndex view:(WDMainFrameMenuView *)view;

@end

@interface WDMainFrameMenuView : MMUIBridgeView

@property (nonatomic,weak) id<WDMainFrameMenuViewDelegate> m_delegate;
@property (nonatomic,assign) NSInteger actionIndex;

-(void)setMenuTitle:(NSString *)title index:(NSInteger)index;

@end

