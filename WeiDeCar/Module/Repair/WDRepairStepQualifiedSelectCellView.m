//
//  WDRepairStepQualifiedSelectCellView.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/3/12.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairStepQualifiedSelectCellView.h"
#import "WDRepairStepModel.h"

@implementation WDRepairStepQualifiedSelectCellView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        m_selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [m_selectButton setImage:MFImage(@"repairStep_select") forState:UIControlStateNormal];
        [m_selectButton addTarget:self action:@selector(onClickSelectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:m_selectButton];
        
        [m_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.width.mas_equalTo(45);
            make.height.mas_equalTo(45);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        m_unSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [m_unSelectButton setImage:MFImage(@"repairStep_unSelect") forState:UIControlStateNormal];
        [m_unSelectButton addTarget:self action:@selector(onClickUnSelectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:m_unSelectButton];
        
        [m_unSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(m_selectButton.mas_left).offset(-20);
            make.width.mas_equalTo(45);
            make.height.mas_equalTo(45);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
    }
    
    return self;
}

-(void)onClickSelectButton:(id)sender
{
    if ([self.m_delegate respondsToSelector:@selector(onClickSelectRepairStepQualified:cellView:)]) {
        [self.m_delegate onClickSelectRepairStepQualified:WDRepairStepQualifiedStatus_QUALIFIED cellView:self];
    }
}

-(void)onClickUnSelectButton:(id)sender
{
    if ([self.m_delegate respondsToSelector:@selector(onClickSelectRepairStepQualified:cellView:)]) {
        [self.m_delegate onClickSelectRepairStepQualified:WDRepairStepQualifiedStatus_UNQUALIFIED cellView:self];
    }
}

@end
