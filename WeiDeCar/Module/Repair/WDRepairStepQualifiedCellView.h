//
//  WDRepairStepQualifiedCellView.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/11.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"
#import "WDRepairStepModel.h"

@interface WDRepairStepQualifiedCellView : MMUIBridgeView
{
    UILabel *m_titleLabel;
    UILabel *m_contentLabel;
    
    WDRepairStepModel *m_repairStep;
}

@property (nonatomic,strong) NSString *attachKey;

-(void)setRepairStepModel:(WDRepairStepModel *)repairStep;

@end
