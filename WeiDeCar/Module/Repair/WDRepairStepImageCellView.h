//
//  WDRepairStepImageCellView.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/9/27.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"
#import "WDRepairStepModel.h"

@class WDRepairStepImageCellView;
@protocol WDRepairStepImageCellViewDelegate <NSObject>
@optional
-(void)onClickSeeImageRepairStep:(WDRepairStepModel *)repairStep stepImageCellView:(WDRepairStepImageCellView *)cellView;

@end

@interface WDRepairStepImageCellView : MMUIBridgeView
{
    UIButton *m_imageSeeButton;
    
    WDRepairStepModel *m_repairStep;
}

@property (nonatomic,weak) id<WDRepairStepImageCellViewDelegate> m_delegate;

-(void)setRepairStepModel:(WDRepairStepModel *)repairStep;

@end
