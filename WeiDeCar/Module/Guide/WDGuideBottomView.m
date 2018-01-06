//
//  WDGuideBottomView.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/11/27.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDGuideBottomView.h"

@interface WDGuideBottomView () 
{
    __weak IBOutlet UIButton *m_registerBtn;
    __weak IBOutlet UIButton *m_loginBtn;
}

@end

@implementation WDGuideBottomView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [m_registerBtn setBackgroundImage:MFImageStretchCenter(@"btn_blue_normal") forState:UIControlStateNormal];
    [m_loginBtn setBackgroundImage:MFImageStretchCenter(@"btn_blue_normal") forState:UIControlStateNormal];
}

- (IBAction)onClickRegisterButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickRegister:)]) {
        [self.m_delegate onClickRegister:self];
    }
}

- (IBAction)onClickLoginButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickLogin:)]) {
        [self.m_delegate onClickLogin:self];
    }
}

@end
