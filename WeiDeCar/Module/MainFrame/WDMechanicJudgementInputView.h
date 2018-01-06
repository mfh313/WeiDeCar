//
//  WDMechanicJudgementInputView.h
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/10.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class WDMechanicJudgementInputView;
@protocol WDMechanicJudgementInputViewDelegate <NSObject>
@optional

-(void)onInputRepairPlan:(NSString *)repairPlan inputView:(WDMechanicJudgementInputView *)inputView;
-(void)onInputMemo:(NSString *)memo inputView:(WDMechanicJudgementInputView *)inputView;

@end

@interface WDMechanicJudgementInputView : MMUIBridgeView

@property (nonatomic,weak) id<WDMechanicJudgementInputViewDelegate> m_delegate;

-(void)setRepairPlan:(NSString *)repairPlan memo:(NSString *)memo;

@end
