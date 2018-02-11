//
//  WDRepairStepQualifiedCellView.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/11.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"
#import "WDRepairStepModel.h"

@protocol WDRepairStepQualifiedCellViewDelegate <NSObject>
@optional


@end

@interface WDRepairStepQualifiedCellView : MMUIBridgeView
{
    UILabel *m_titleLabel;
    UILabel *m_contentLabel;
    
    WDRepairStepModel *m_repairStep;
}

@property (nonatomic,weak) id<WDRepairStepQualifiedCellViewDelegate> m_delegate;
@property (nonatomic,strong) NSString *attachKey;

-(void)setRepairStepModel:(WDRepairStepModel *)repairStep;

@end
