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
    m_view.frame = frame;
}

-(id)initWithTitle:(NSString *)title tip:(NSString *)tip key:(NSString *)key
{
    self = [super initWithTitle:title tip:tip key:key];
    if (self) {
        m_textField = [[MMUITextField alloc] initWithFrame:CGRectZero];
        m_textField.delegate = self;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:m_textField];
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
    m_textField.m_bRestrictShareMenu = shareMenu;
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

#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])
    {
        [m_textField resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([m_delegate respondsToSelector:@selector(MMBaseInfoItemBeginEdit:)]) {
        [m_delegate MMBaseInfoItemBeginEdit:self];
    }
}

- (void)textFiledEditChanged:(NSNotification *)notifi
{
    if ([m_delegate respondsToSelector:@selector(MMBaseInfoItemEditChanged:)]) {
        [m_delegate MMBaseInfoItemEditChanged:self];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([m_delegate respondsToSelector:@selector(MMBaseInfoItemEndEdit:)]) {
        [m_delegate MMBaseInfoItemEndEdit:self];
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([m_delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [m_delegate MMBaseInfoItemShouldBeginEditing:self];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([m_delegate respondsToSelector:@selector(MMBaseInfoItemPressReturnKey:)]) {
        [m_delegate MMBaseInfoItemPressReturnKey:self];
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
{
    if ([m_delegate respondsToSelector:@selector(MMBaseInfoItemCancelEdit:)]) {
        [m_delegate MMBaseInfoItemCancelEdit:self];
    }
    
    return YES;
}

@end
