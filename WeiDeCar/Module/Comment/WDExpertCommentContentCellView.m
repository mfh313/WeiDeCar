//
//  WDExpertCommentContentCellView.m
//  WeiDeCar
//
//  Created by EEKA on 2018/9/13.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDExpertCommentContentCellView.h"

@implementation WDExpertCommentContentCellView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        m_titleLabel = [[UILabel alloc] init];
        m_titleLabel.font = [UIFont systemFontOfSize:15.0f];
        m_titleLabel.textColor = [UIColor hx_colorWithHexString:@"242834"];
        m_titleLabel.backgroundColor = [UIColor whiteColor];
        m_titleLabel.text = @"专家评价";
        [self addSubview:m_titleLabel];
        
        [m_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@(25));
            make.top.mas_equalTo(self.mas_top).offset(20);
        }];
        
        m_textField = [WDBorderTextField nibView];
        m_textField.m_delegate = self;
        [self addSubview:m_textField];
        
        UITextField *contentTextField = [m_textField contentTextField];
        contentTextField.enablesReturnKeyAutomatically = YES;
        contentTextField.returnKeyType = UIReturnKeyDone;
        contentTextField.placeholder = @"请输入评价";
        
        [m_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(25);
            make.right.mas_equalTo(self.mas_right).offset(-25);
            make.top.mas_equalTo(m_titleLabel.mas_bottom).offset(20);
            make.height.mas_equalTo(44);
        }];
    }
    
    return self;
}

#pragma mark - WDBorderTextFieldDelegate
-(BOOL)borderTextField:(WDBorderTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    UITextField *contentTextField = [textField contentTextField];
    NSString *text = contentTextField.text;
    
    if ([string isEqualToString:@"\n"]) {
        
        [contentTextField resignFirstResponder];
        
        if ([self.m_delegate respondsToSelector:@selector(onInputComment:inputView:)]) {
            [self.m_delegate onInputComment:text inputView:self];
        }
        
        return NO;
    }
    
    return YES;
}

-(void)borderTextFiledEditChanged:(WDBorderTextField *)textField
{
    UITextField *contentTextField = [textField contentTextField];
    NSString *text = contentTextField.text;
    
    if ([self.m_delegate respondsToSelector:@selector(onInputComment:inputView:)]) {
        [self.m_delegate onInputComment:text inputView:self];
    }
}

-(void)setCommentContent:(NSString *)commentContent
{
    UITextField *contentTextField = [m_textField contentTextField];
    contentTextField.text = commentContent;
}

@end
