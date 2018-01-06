//
//  WDExpertDiagnoseAdviceCellView.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/11.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDExpertDiagnoseAdviceCellView.h"
#import "WDBorderTextField.h"
#import "WDDiagnoseModel.h"

@interface WDExpertDiagnoseAdviceCellView () <WDBorderTextFieldDelegate>
{
    __weak IBOutlet WDBorderTextField *m_adviceTextField;
    
    WDDiagnoseItemFaultAppearanceModel *m_faultAppearanceModel;
}

@end

@implementation WDExpertDiagnoseAdviceCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    UITextField *textField = [m_adviceTextField contentTextField];
    textField.returnKeyType = UIReturnKeyDone;
    textField.placeholder = @"请输入专家意见";
    
    m_adviceTextField.m_delegate = self;
}

#pragma mark - WDBorderTextFieldDelegate
-(BOOL)borderTextField:(WDBorderTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [m_adviceTextField resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(void)borderTextFiledEditChanged:(WDBorderTextField *)textField
{
    UITextField *contentTextField = [textField contentTextField];
    m_faultAppearanceModel.expertAdvices = contentTextField.text;
}

-(void)setFaultAppearanceModel:(WDDiagnoseItemFaultAppearanceModel *)faultAppearanceModel
{
    m_faultAppearanceModel = faultAppearanceModel;
    
    UITextField *textField = [m_adviceTextField contentTextField];
    textField.text = m_faultAppearanceModel.expertAdvices;
}

@end
