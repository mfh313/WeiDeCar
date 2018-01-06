//
//  WDLoginContentView.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/11/27.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDLoginContentView.h"
#import "WDBorderTextField.h"

@interface WDLoginContentView () <WDBorderTextFieldDelegate>
{
    __weak IBOutlet WDBorderTextField *m_acountTextField;
    __weak IBOutlet WDBorderTextField *m_passwordTextField;
    __weak IBOutlet UIButton *m_loginButton;
}

@end

@implementation WDLoginContentView

-(void)awakeFromNib
{
    [super awakeFromNib];
    [m_loginButton setBackgroundImage:MFImageStretchCenter(@"btn_blue_normal") forState:UIControlStateNormal];
    
    UITextField *acountTextField = [m_acountTextField contentTextField];
    acountTextField.returnKeyType = UIReturnKeyDone;
    acountTextField.placeholder = @"请输入手机号";
    
    UITextField *passwordTextField = [m_passwordTextField contentTextField];
    passwordTextField.secureTextEntry = YES;
    passwordTextField.returnKeyType = UIReturnKeyDone;
    passwordTextField.placeholder = @"请输入密码";
    
    m_acountTextField.m_delegate = self;
    m_passwordTextField.m_delegate = self;
    
    [self setTextFieldLeftView:MFImage(@"login_user") textField:acountTextField];
    [self setTextFieldLeftView:MFImage(@"login_password") textField:passwordTextField];
}

#pragma mark - WDBorderTextFieldDelegate
-(BOOL)borderTextField:(WDBorderTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        
        if (textField == m_acountTextField)
        {
            [m_passwordTextField becomeFirstResponder];
        }
        else if (textField == m_passwordTextField)
        {
            [self onClickLoginButton:nil];
        }
        
        return NO;
    }
    
    return YES;
}

-(void)borderTextFiledEditChanged:(WDBorderTextField *)textField
{
    
}

-(void)setPhone:(NSString *)phone password:(NSString *)password
{
    UITextField *acountTextField = [m_acountTextField contentTextField];
    acountTextField.text = phone;
    
    UITextField *passwordTextField = [m_passwordTextField contentTextField];
    passwordTextField.text = password;
}

-(void)setTextFieldLeftView:(UIImage *)image textField:(UITextField *)textField
{
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, CGRectGetHeight(textField.frame))];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = leftView.bounds;
    [button setImage:image forState:UIControlStateNormal];
    button.userInteractionEnabled = NO;
    [leftView addSubview:button];
    
    textField.leftView = leftView;
}

- (IBAction)onClickLoginButton:(id)sender {
    UITextField *acountTextField = [m_acountTextField contentTextField];
    UITextField *passwordTextField = [m_passwordTextField contentTextField];
    
    if ([self.m_delegate respondsToSelector:@selector(onClickLogin:password:view:)]) {
        [self.m_delegate onClickLogin:acountTextField.text password:passwordTextField.text view:self];
    }
}

- (IBAction)onClickForgetButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickForgetPassword:)]) {
        [self.m_delegate onClickForgetPassword:self];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

@end
