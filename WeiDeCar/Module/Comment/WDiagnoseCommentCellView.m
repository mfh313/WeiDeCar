//
//  WDiagnoseCommentCellView.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/9/12.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDiagnoseCommentCellView.h"

@implementation WDiagnoseCommentCellView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        m_commentValueLabel = [[UILabel alloc] init];
        m_commentValueLabel.font = [UIFont systemFontOfSize:14.0f];
        m_commentValueLabel.textColor = [UIColor hx_colorWithHexString:@"242834"];
        m_commentValueLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:m_commentValueLabel];
        
        [m_commentValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@(10));
            make.centerY.equalTo(self.mas_centerY);
            make.top.mas_equalTo(self.mas_top);
            make.height.mas_equalTo(self.mas_height);
        }];
        
        m_starsView = [[GRStarsView alloc] initWithStarSize:CGSizeMake(25, 25) margin:10 numberOfStars:5];
        m_starsView.allowSelect = YES;  // 默认可点击
        m_starsView.allowDecimal = NO;  //默认不显示小数
        m_starsView.allowDragSelect = NO;//默认不可拖动评分，可拖动下需可点击才有效
        m_starsView.score = 1.0f;
        [self addSubview:m_starsView];
        
        [m_starsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(m_commentValueLabel.mas_right).offset(10);
            make.centerY.equalTo(self.mas_centerY);
            make.width.mas_equalTo(@(m_starsView.frame.size.width));
            make.height.mas_equalTo(@(m_starsView.frame.size.height));
        }];

        __weak typeof(self) weakSelf = self;
        m_starsView.touchedActionBlock = ^(CGFloat score) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf onTouchedAction:score];
        };
    }
    
    return self;
}

-(void)setCommentValue:(NSString *)commentValue score:(CGFloat)score
{
    m_commentValueLabel.text = commentValue;
    m_starsView.score = score;
}

-(void)onTouchedAction:(CGFloat)score
{
    if ([self.m_delegate respondsToSelector:@selector(onClickChangeScore:attachDataIndex:cellView:)]) {
        [self.m_delegate onClickChangeScore:score attachDataIndex:self.attachDataIndex cellView:self];
    }
}

@end
