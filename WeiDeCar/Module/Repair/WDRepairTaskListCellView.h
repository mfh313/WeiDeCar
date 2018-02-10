//
//  WDRepairTaskListCellView.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class WDDiagnoseModel;
@protocol WDRepairTaskListCellViewDelegate <NSObject>
@optional

-(void)onClickRepairTaskCellView:(WDDiagnoseModel *)itemModel;

@end

@interface WDRepairTaskListCellView : MMUIBridgeView

@property (nonatomic,weak) id<WDRepairTaskListCellViewDelegate> m_delegate;

-(void)setRepairDiagnoseModel:(WDDiagnoseModel *)itemModel;

@end
