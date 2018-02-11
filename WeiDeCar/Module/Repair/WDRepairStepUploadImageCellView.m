//
//  WDRepairStepUploadImageCellView.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/11.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairStepUploadImageCellView.h"

@implementation WDRepairStepUploadImageCellView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        m_contentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [m_contentButton setTitle:@"上传图片" forState:UIControlStateNormal];
        [m_contentButton setBackgroundImage:MFImageStretchCenter(@"btn_blue_normal") forState:UIControlStateNormal];
        [m_contentButton addTarget:self action:@selector(onClickContentButton:) forControlEvents:UIControlEventTouchUpInside];
        m_contentButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:m_contentButton];
        
        [m_contentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.width.mas_equalTo(150);
            make.top.equalTo(self.mas_top).offset(10);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
        
    }
    
    return self;
}

-(void)setRepairStepModel:(WDRepairStepModel *)repairStep
{
    m_repairStep = repairStep;
}

-(void)onClickContentButton:(id)sender
{
    if ([self.m_delegate respondsToSelector:@selector(onClickUploadImageRepairStep:cellView:)]) {
        [self.m_delegate onClickUploadImageRepairStep:m_repairStep cellView:self];
    }
}

@end
