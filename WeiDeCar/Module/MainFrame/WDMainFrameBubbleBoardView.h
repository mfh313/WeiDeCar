//
//  WDMainFrameBubbleBoardView.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/6/7.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class WDMainFrameBubbleBoardView;
@protocol WDMainFrameBubbleBoardViewDelegate <NSObject>

@optional
-(void)onClickFaultDiagnosis:(WDMainFrameBubbleBoardView *)view;
-(void)onClickRegular:(WDMainFrameBubbleBoardView *)view;
-(void)onClickRepairFactories:(WDMainFrameBubbleBoardView *)view;
-(void)onClickRepairItems:(WDMainFrameBubbleBoardView *)view;
-(void)onClickTroubleCar:(WDMainFrameBubbleBoardView *)view;
-(void)onClickCosmetology:(WDMainFrameBubbleBoardView *)view;

@end

@interface WDMainFrameBubbleBoardView : MMUIBridgeView

@property (nonatomic,weak) id<WDMainFrameBubbleBoardViewDelegate> m_delegate;

@end
