//
//  WDDiagnoseDetailHeaderView.m
//  WeiDeCar
//
//  Created by EEKA on 2018/6/30.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDDiagnoseDetailHeaderView.h"

@implementation WDDiagnoseDetailHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        m_faultAppearanceView = [UIView new];
        [self addSubview:m_faultAppearanceView];
        
        m_causeJudgementView = [UIView new];
        [self addSubview:m_causeJudgementView];
        
        m_isCertainView = [UIView new];
        [self addSubview:m_isCertainView];
        
        m_isCheapestView = [UIView new];
        [self addSubview:m_isCheapestView];
        
        m_isMostPossibleView = [UIView new];
        [self addSubview:m_isMostPossibleView];
        
        m_expertDiagnoseResultView = [UIView new];
        [self addSubview:m_expertDiagnoseResultView];
        
        [m_expertDiagnoseResultView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right);
            make.width.mas_equalTo(110);
            make.height.mas_equalTo(self.mas_height);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [self initContentView:m_faultAppearanceView title:@"故障现象"];
        [self initContentView:m_causeJudgementView title:@"原因判断"];
        [self initContentView:m_isCertainView title:@"确定原因"];
        [self initContentView:m_isCheapestView title:@"最廉价原因"];
        [self initContentView:m_isMostPossibleView title:@"最可能原因"];
        [self initContentView:m_expertDiagnoseResultView title:@"第三方专家复诊"];
    }
    
    return self;
}

-(void)initContentView:(UIView *)itemView title:(NSString *)title
{
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = title;
    titleLabel.textColor = MFBlackColor;
    titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [itemView addSubview:titleLabel];
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}


@end
