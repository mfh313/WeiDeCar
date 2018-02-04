//
//  MMBaseTextFieldItem.h
//  YJCustom
//
//  Created by EEKA on 2016/10/20.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import "MMBaseInfoItem.h"
#import "MMUITextField.h"

@interface MMBaseTextFieldItem : MMBaseInfoItem <UITextFieldDelegate>
{
    MMUITextField *m_textField;
    NSInteger m_iMaxInputLen;
    BOOL m_bRealLen;
}

- (void)becomeFirstResponder;
- (id)getTextField;
- (id)getValue;
- (void)initView:(CGRect)frame;
- (id)initWithTitle:(NSString *)title tip:(NSString *)tip key:(NSString *)key;
- (void)resignFirstResponder;
- (void)setClearButtonMode:(UITextFieldViewMode)clearButtonMode;
- (void)setColor:(UIColor *)textColor;
- (void)setEnable:(BOOL)enable;
- (void)setFont:(UIFont *)font;
- (void)setKeyboardType:(UIKeyboardType)keyboardType;
- (void)setMaxInputLen:(int)maxInputLen;
- (void)setMaxRealStringLen:(int)maxRealStringLen;
- (void)setRestrictShareMenu:(BOOL)shareMenu;
- (void)setReturnKeyType:(UIReturnKeyType)returnKeyType;
- (void)setSecureTextEntry:(BOOL)secureTextEntry;
- (void)setText:(NSString *)text;

@end
