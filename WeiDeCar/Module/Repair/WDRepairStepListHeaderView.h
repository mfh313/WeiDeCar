//
//  WDRepairStepListHeaderView.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/11.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"
#import "WDRepairStepModel.h"

@interface WDRepairStepListHeaderView : MMUIBridgeView
{
    UILabel *m_titleLabel;

    WDRepairStepModel *m_repairStep;
}

-(void)setRepairStepModel:(WDRepairStepModel *)repairStep;

@end
