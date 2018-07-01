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
        
        self.backgroundColor = [UIColor hx_colorWithHexString:@"f8f6f9"];
        
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
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(self.mas_height);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [m_isMostPossibleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(m_expertDiagnoseResultView.mas_left);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(self.mas_height);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [m_isCheapestView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(m_isMostPossibleView.mas_left);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(self.mas_height);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [m_isCertainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(m_isCheapestView.mas_left);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(self.mas_height);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [m_causeJudgementView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(m_isCertainView.mas_left);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(self.mas_height);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [m_faultAppearanceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(m_causeJudgementView.mas_left);
            make.height.mas_equalTo(self.mas_height);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [self initContentView:m_faultAppearanceView title:@"故障\n现象"];
        [self initContentView:m_causeJudgementView title:@"原因\n判断"];
        [self initContentView:m_isCertainView title:@"确定\n原因"];
        [self initContentView:m_isCheapestView title:@"最廉价\n原因"];
        [self initContentView:m_isMostPossibleView title:@"最可能\n原因"];
        [self initContentView:m_expertDiagnoseResultView title:@"第三方\n专家复诊"];
        
        UIView *upSeparator = [UIView new];
        upSeparator.backgroundColor = MFCustomLineColor;
        [self addSubview:upSeparator];
        
        [upSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.height.mas_equalTo(MFOnePixHeight);
            make.top.mas_equalTo(self.mas_top);
            make.width.mas_equalTo(self.mas_width);
        }];
        
        UIView *downSeparator = [UIView new];
        downSeparator.backgroundColor = MFCustomLineColor;
        [self addSubview:downSeparator];
        
        [downSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.height.mas_equalTo(MFOnePixHeight);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.width.mas_equalTo(self.mas_width);
        }];
        
        [self addVerticalLine:m_faultAppearanceView];
        [self addVerticalLine:m_causeJudgementView];
        [self addVerticalLine:m_isCertainView];
        [self addVerticalLine:m_isCheapestView];
        [self addVerticalLine:m_isMostPossibleView];
    }
    
    return self;
}

-(void)addVerticalLine:(UIView *)itemView
{
    UIView *separator = [UIView new];
    separator.backgroundColor = MFCustomLineColor;
    [itemView addSubview:separator];
    
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(itemView.mas_trailing).offset(MFOnePixHeight);
        make.width.mas_equalTo(MFOnePixHeight);
        make.top.mas_equalTo(itemView.mas_top);
        make.height.mas_equalTo(itemView.mas_height);
    }];
}

-(void)initContentView:(UIView *)itemView title:(NSString *)title
{
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = title;
    titleLabel.textColor = MFBlackColor;
    titleLabel.font = [UIFont systemFontOfSize:13.0f];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    [itemView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(itemView.mas_left);
        make.right.mas_equalTo(itemView.mas_right);
        make.height.mas_equalTo(itemView.mas_height);
        make.centerY.mas_equalTo(itemView.mas_centerY);
    }];
}

@end
