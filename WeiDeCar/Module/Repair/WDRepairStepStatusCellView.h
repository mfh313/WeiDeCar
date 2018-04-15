//
//  WDRepairStepStatusCellView.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/4/15.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"
#import "WDRepairStepModel.h"

@class WDRepairStepModel,WDRepairStepStatusCellView;
@protocol WDRepairStepStatusCellViewDelegate <NSObject>
@optional
-(void)onClickFinishRepairStep:(WDRepairStepModel *)repairStep statusCellView:(WDRepairStepStatusCellView *)cellView;

@end

@interface WDRepairStepStatusCellView : MMUIBridgeView
{
    UILabel *m_titleLabel;
    UIButton *m_finshButton;
    
    WDRepairStepModel *m_repairStep;
}

@property (nonatomic,weak) id<WDRepairStepStatusCellViewDelegate> m_delegate;

-(void)setRepairStepModel:(WDRepairStepModel *)repairStep;

@end
