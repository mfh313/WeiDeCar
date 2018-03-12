//
//  WDRepairStepQualifiedSelectCellView.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/3/12.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDRepairStepModel.h"

@class WDRepairStepQualifiedSelectCellView;
@protocol WDRepairStepQualifiedSelectCellViewDelegate <NSObject>
@optional
-(void)onClickSelectRepairStepQualified:(NSInteger)value cellView:(WDRepairStepQualifiedSelectCellView *)cellView;

@end

@interface WDRepairStepQualifiedSelectCellView : UIView
{
    UIButton *m_unSelectButton;
    UIButton *m_selectButton;
}

@property (nonatomic,weak) id<WDRepairStepQualifiedSelectCellViewDelegate> m_delegate;
@property (nonatomic,strong) NSString *attachKey;
@property (nonatomic,assign) NSInteger attachIndex;

@end
