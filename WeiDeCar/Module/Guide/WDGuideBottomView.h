//
//  WDGuideBottomView.h
//  WeiDeCar
//
//  Created by mafanghua on 2017/11/27.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class WDGuideBottomView;
@protocol WDGuideBottomViewDelegate <NSObject>

@optional
-(void)onClickRegister:(WDGuideBottomView *)view;
-(void)onClickLogin:(WDGuideBottomView *)view;

@end

@interface WDGuideBottomView : MMUIBridgeView

@property (nonatomic,weak) id<WDGuideBottomViewDelegate> m_delegate;

@end
