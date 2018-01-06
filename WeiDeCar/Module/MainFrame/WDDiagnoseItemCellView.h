//
//  WDDiagnoseItemCellView.h
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/10.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class WDDiagnoseModel;
@protocol WDDiagnoseItemCellViewDelegate <NSObject>
@optional

-(void)onClickDiagnoseItemCellView:(WDDiagnoseModel *)itemModel;

@end

@interface WDDiagnoseItemCellView : MMUIBridgeView

@property (nonatomic,weak) id<WDDiagnoseItemCellViewDelegate> m_delegate;

-(void)setDiagnoseModel:(WDDiagnoseModel *)itemModel;

-(void)setTipsHidden:(BOOL)hidden;

@end
