//
//  WDBorderTextField.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/7.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDBorderTextField.h"

@interface WDBorderTextField () <UITextFieldDelegate>
{
    __weak IBOutlet UITextField *m_contentTextField;
    __weak IBOutlet UIImageView *m_borderImageView;
}

@end

@implementation WDBorderTextField

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    m_borderImageView.image = MFImageStretchCenter(@"border_gray");
    
    m_contentTextField.delegate = self;
    m_contentTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:m_contentTextField];
}

- (void)textFiledEditChanged:(NSNotification *)notifi
{
    UITextField *textField = (UITextField *)notifi.object;
    NSString *text = textField.text;
    if ([self.m_delegate respondsToSelector:@selector(borderTextFiledEditChanged:)]) {
        [self.m_delegate borderTextFiledEditChanged:self];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([self.m_delegate respondsToSelector:@selector(borderTextField:shouldChangeCharactersInRange:replacementString:)]) {
        return [self.m_delegate borderTextField:self shouldChangeCharactersInRange:range replacementString:string];
    }

    return YES;
}

-(UITextField *)contentTextField
{
    return m_contentTextField;
}

-(BOOL)resignFirstResponder
{
    return [m_contentTextField resignFirstResponder];
}

-(BOOL)becomeFirstResponder
{
    return [m_contentTextField becomeFirstResponder];
}

@end
