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
    int m_iMaxInputLen;
    BOOL m_bRealLen;
}

- (void)becomeFirstResponder;
- (id)getTextField;
- (id)getValue;
- (void)initView:(CGRect)frame;

@end
