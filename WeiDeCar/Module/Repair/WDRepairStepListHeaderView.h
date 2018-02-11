//
//  WDRepairStepListHeaderView.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/11.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"
#import "WDRepairStepModel.h"

@class WDRepairStepModel,WDRepairStepListHeaderView;
@protocol WDRepairStepListHeaderViewDelegate <NSObject>
@optional
-(void)onClickFinishRepairStep:(WDRepairStepModel *)repairStep cellView:(WDRepairStepListHeaderView *)cellView;

@end

@interface WDRepairStepListHeaderView : MMUIBridgeView
{
    UILabel *m_titleLabel;
    UIButton *m_finshButton;
    
    WDRepairStepModel *m_repairStep;
}

@property (nonatomic,weak) id<WDRepairStepListHeaderViewDelegate> m_delegate;

-(void)setRepairStepModel:(WDRepairStepModel *)repairStep;

@end
