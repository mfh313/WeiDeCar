//
//  WDDiagnoseDetailResultCauseJudgementsItemView.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/7/1.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDDiagnoseDetailResultCauseJudgementsItemView.h"

@implementation WDDiagnoseDetailResultCauseJudgementsItemView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
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
        
        m_causeJudgementLabel = [self titleLabelWithContentView:m_causeJudgementView];
        
        m_isCertainImageView = [self resultImageViewWithContentView:m_isCertainView];
        m_isCheapestImageView = [self resultImageViewWithContentView:m_isCheapestView];
        m_isMostPossibleImageView = [self resultImageViewWithContentView:m_isMostPossibleView];
        m_expertDiagnoseImageView = [self resultImageViewWithContentView:m_expertDiagnoseResultView];

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

-(UIImageView *)resultImageViewWithContentView:(UIView *)itemView
{
    UIImageView *resultImageView = [UIImageView new];
    resultImageView.image = MFImage(@"result_yes");
    [itemView addSubview:resultImageView];
    
    [resultImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
        make.centerX.mas_equalTo(itemView.mas_centerX);
        make.centerY.mas_equalTo(itemView.mas_centerY);
    }];
    
    return resultImageView;
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

-(void)setAppearanceModel:(WDDiagnoseItemFaultAppearanceModel *)appearanceModel causeJudgements:(WDDiagnoseCauseJudgementModel *)causeJudgements
{
    m_causeJudgementLabel.text = causeJudgements.causeJudgementName;
    
    NSString *isCertain = causeJudgements.isCertain;
    NSString *isCheapest = causeJudgements.isCheapest;
    NSString *isMostPossible = causeJudgements.isMostPossible;
    NSString *expertDiagnoseResult = causeJudgements.expertDiagnoseResult;
    
    [self setResultYes:isCertain imageView:m_isCertainImageView];
    [self setResultYes:isCheapest imageView:m_isCheapestImageView];
    [self setResultYes:isMostPossible imageView:m_isMostPossibleImageView];
    
    if ([expertDiagnoseResult isEqualToString:@"Y"]) {
        m_expertDiagnoseImageView.image = MFImage(@"result_yes");
    }
    else if ([expertDiagnoseResult isEqualToString:@"N"]){
        m_expertDiagnoseImageView.image = MFImage(@"result_no");
    }
}

-(void)setResultYes:(NSString *)resultString imageView:(UIImageView *)imageView
{
    [imageView setHidden:YES];
    if ([resultString isEqualToString:@"Y"]) {
        [imageView setHidden:NO];
    }
}

@end
