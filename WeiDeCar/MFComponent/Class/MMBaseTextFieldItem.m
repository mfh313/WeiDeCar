//
//  MMBaseTextFieldItem.m
//  YJCustom
//
//  Created by EEKA on 2016/10/20.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import "MMBaseTextFieldItem.h"

@implementation MMBaseTextFieldItem

- (void)becomeFirstResponder
{
    [super becomeFirstResponder];
    [m_textField becomeFirstResponder];
}

- (id)getTextField
{
    return m_textField;
}

- (id)getValue
{
    return m_textField.text;
}

- (void)initView:(CGRect)frame
{
    m_textField = [[MMUITextField alloc] initWithFrame:frame];
}

-(id)initWithTitle:(NSString *)title tip:(NSString *)tip key:(NSString *)key
{
    self = [super initWithTitle:title tip:tip key:key];
    if (self) {
        
    }
    
    return self;
}

- (void)resignFirstResponder
{
    [super resignFirstResponder];
    
    [m_textField resignFirstResponder];
}

- (void)setClearButtonMode:(UITextFieldViewMode)clearButtonMode
{
    m_textField.clearButtonMode = clearButtonMode;
}

- (void)setColor:(UIColor *)textColor
{
    m_textField.textColor = textColor;
}

- (void)setEnable:(BOOL)enable
{
    m_textField.enabled = enable;
}

- (void)setFont:(UIFont *)font
{
    m_textField.font = font;
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType
{
    m_textField.keyboardType = keyboardType;
}

- (void)setMaxInputLen:(int)maxInputLen
{
    m_iMaxInputLen = maxInputLen;
}

- (void)setMaxRealStringLen:(int)maxRealStringLen
{
    
}

- (void)setRestrictShareMenu:(BOOL)shareMenu
{
    
}

- (void)setReturnKeyType:(UIReturnKeyType)returnKeyType
{
    m_textField.returnKeyType = returnKeyType;
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry
{
    m_textField.secureTextEntry = secureTextEntry;
}

- (void)setText:(NSString *)text
{
    m_textField.text = text;
}

@end
