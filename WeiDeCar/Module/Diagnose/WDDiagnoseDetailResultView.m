//
//  WDDiagnoseDetailResultView.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/7/1.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDDiagnoseDetailResultView.h"

@implementation WDDiagnoseDetailResultView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        m_faultAppearanceView = [UIView new];
        [self addSubview:m_faultAppearanceView];
        
        m_causeJudgementsContentView = [UIView new];
        [self addSubview:m_causeJudgementsContentView];
        
        [m_causeJudgementsContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right);
            make.width.mas_equalTo(260);
            make.height.mas_equalTo(self.mas_height);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [m_faultAppearanceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(m_causeJudgementsContentView.mas_left);
            make.height.mas_equalTo(self.mas_height);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        m_faultAppearanceLabel = [self titleLabelWithContentView:m_faultAppearanceView];
        
        
        
        
        
        
        [self addVerticalLine:m_faultAppearanceView];
        
        UIView *downSeparator = [UIView new];
        downSeparator.backgroundColor = MFCustomLineColor;
        [self addSubview:downSeparator];
        
        [downSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.height.mas_equalTo(MFOnePixHeight);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.width.mas_equalTo(self.mas_width);
        }];
    }
    
    return self;
}

-(void)setDiagnoseModel:(WDDiagnoseModel *)diagnoseModel appearanceModel:(WDDiagnoseItemFaultAppearanceModel *)appearanceModel
{
    m_faultAppearanceLabel.text = appearanceModel.faultAppearanceName;
}

-(UILabel *)titleLabelWithContentView:(UIView *)itemView
{
    UILabel *titleLabel = [UILabel new];
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
    
    return titleLabel;
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

@end
