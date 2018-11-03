//
//  WDiagnoseCommentContentCellView.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/11/3.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDiagnoseCommentContentCellView.h"

@implementation WDiagnoseCommentContentCellView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        m_titleLabel = [[UILabel alloc] init];
        m_titleLabel.font = [UIFont systemFontOfSize:15.0f];
        m_titleLabel.textColor = [UIColor hx_colorWithHexString:@"242834"];
        m_titleLabel.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:m_titleLabel];
        
        [m_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@(25));
            make.top.mas_equalTo(self.mas_top).offset(20);
        }];
        
        m_contentLabel = [[UILabel alloc] init];
        m_contentLabel.font = [UIFont systemFontOfSize:15.0f];
        m_contentLabel.textColor = [UIColor hx_colorWithHexString:@"242834"];
        m_contentLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:m_contentLabel];
        
        [m_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(25);
            make.right.mas_equalTo(self.mas_right).offset(-25);
            make.top.mas_equalTo(m_titleLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(30);
        }];
    }
    
    return self;
}

-(void)setUserTitle:(NSString *)title commentContent:(NSString *)commentContent
{
    m_titleLabel.text = title;
    m_contentLabel.text = commentContent;
}

@end
