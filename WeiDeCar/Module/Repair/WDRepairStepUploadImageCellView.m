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
        
        m_imageSeeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [m_imageSeeButton setImage:MFImageStretchCenter(@"image_see") forState:UIControlStateNormal];
        [m_imageSeeButton addTarget:self action:@selector(onClickContentButton:) forControlEvents:UIControlEventTouchUpInside];
        m_imageSeeButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:m_imageSeeButton];
        
        [m_imageSeeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.width.mas_equalTo(45);
            make.height.mas_equalTo(45);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        m_contentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [m_contentButton setImage:MFImageStretchCenter(@"image_upload") forState:UIControlStateNormal];
        [m_contentButton addTarget:self action:@selector(onClickAddButton:) forControlEvents:UIControlEventTouchUpInside];
        m_contentButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:m_contentButton];
        
        [m_contentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(m_imageSeeButton.mas_right).offset(10);
            make.width.mas_equalTo(45);
            make.height.mas_equalTo(45);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
    }
    
    return self;
}

-(void)setRepairStepModel:(WDRepairStepModel *)repairStep
{
    m_repairStep = repairStep;
}

-(void)onClickAddButton:(id)sender
{
    if ([self.m_delegate respondsToSelector:@selector(onClickUploadImageRepairStep:cellView:)]) {
        [self.m_delegate onClickUploadImageRepairStep:m_repairStep cellView:self];
    }
}

-(void)onClickContentButton:(id)sender
{
    if ([self.m_delegate respondsToSelector:@selector(onClickSeeImageRepairStep:cellView:)]) {
        [self.m_delegate onClickSeeImageRepairStep:m_repairStep cellView:self];
    }
}

@end
