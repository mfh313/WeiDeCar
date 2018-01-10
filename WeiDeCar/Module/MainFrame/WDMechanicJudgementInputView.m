//
//  WDMechanicJudgementInputView.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/10.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDMechanicJudgementInputView.h"
#import "WDBorderTextField.h"

@interface WDMechanicJudgementInputView () <WDBorderTextFieldDelegate>
{
    __weak IBOutlet WDBorderTextField *m_repairPlanTextField;
    __weak IBOutlet WDBorderTextField *m_memoTextField;
}

@end

@implementation WDMechanicJudgementInputView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    m_repairPlanTextField.textFieldKey = @"repairPlan";
    m_repairPlanTextField.m_delegate = self;
    
    m_memoTextField.textFieldKey = @"memo";
    m_memoTextField.m_delegate = self;
    
    UITextField *planTextField = [m_repairPlanTextField contentTextField];
    planTextField.returnKeyType = UIReturnKeyDone;
    planTextField.placeholder = @"请输入维修方案";
    
    UITextField *memoTextField = [m_memoTextField contentTextField];
    memoTextField.returnKeyType = UIReturnKeyDone;
    memoTextField.placeholder = @"请输入备注";
}

-(void)setRepairPlan:(NSString *)repairPlan memo:(NSString *)memo
{
    UITextField *planTextField = [m_repairPlanTextField contentTextField];
    planTextField.text = repairPlan;
    
    UITextField *memoTextField = [m_memoTextField contentTextField];
    memoTextField.text = memo;
}

#pragma mark - WDBorderTextFieldDelegate
-(BOOL)borderTextField:(WDBorderTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    UITextField *contentTextField = [textField contentTextField];
    NSString *text = contentTextField.text;
    
    if ([string isEqualToString:@"\n"]) {
        [contentTextField resignFirstResponder];
        
        if ([textField.textFieldKey isEqualToString:@"repairPlan"])
        {
            if ([self.m_delegate respondsToSelector:@selector(onInputRepairPlan:inputView:)]) {
                [self.m_delegate onInputRepairPlan:text inputView:self];
            }
        }
        
        if ([textField.textFieldKey isEqualToString:@"memo"])
        {
            if ([self.m_delegate respondsToSelector:@selector(onInputMemo:inputView:)]) {
                [self.m_delegate onInputMemo:text inputView:self];
            }
        }
        
        return NO;
    }
    
    NSString *toBeString = [contentTextField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    return YES;
}

-(void)borderTextFiledEditChanged:(WDBorderTextField *)textField
{
    if (textField == m_repairPlanTextField)
    {
        UITextField *planTextField = [m_repairPlanTextField contentTextField];
        NSString *repairPlan = planTextField.text;
        
        if ([self.m_delegate respondsToSelector:@selector(onInputRepairPlan:inputView:)]) {
            [self.m_delegate onInputRepairPlan:repairPlan inputView:self];
        }
    }
    
    if (textField == m_memoTextField)
    {
        UITextField *memoTextField = [m_memoTextField contentTextField];
        NSString *memo = memoTextField.text;
        
        if ([self.m_delegate respondsToSelector:@selector(onInputMemo:inputView:)]) {
            [self.m_delegate onInputMemo:memo inputView:self];
        }
    }
}

@end
