//
//  WDExpertDiagnoseResultSelectView.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/11.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDExpertDiagnoseResultSelectView.h"
#import "WDDiagnoseModel.h"

@interface WDExpertDiagnoseResultSelectView ()
{
    __weak IBOutlet UILabel *m_Label;
    __weak IBOutlet UIButton *m_unSelectButton;
    __weak IBOutlet UIButton *m_selectButton;
    
    WDDiagnoseCauseJudgementModel *m_judgementModel;
}

@end

@implementation WDExpertDiagnoseResultSelectView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [m_unSelectButton setImage:MFImage(@"cha") forState:UIControlStateNormal];
    [m_selectButton setImage:MFImage(@"gou") forState:UIControlStateNormal];
}

-(void)setJudgementModel:(WDDiagnoseCauseJudgementModel *)judgementModel
{
    m_judgementModel = judgementModel;
    [self setExpertDiagnoseResult:m_judgementModel.expertDiagnoseResult];
}

-(void)setExpertDiagnoseResult:(NSString *)result
{
    NSString *resultText = @"待评价";
    if ([result isEqualToString:@"Y"]) {
        resultText = @"你选择了：对";
    }
    else if ([result isEqualToString:@"N"])
    {
        resultText = @"你选择了：错";
    }
    
    m_Label.text = resultText;
}

- (IBAction)onClickUnSelectButton:(id)sender
{
//    if ([self.m_delegate respondsToSelector:@selector(onSelectDiagnoseResult:judgementModel:view:)])
//    {
//        [self.m_delegate onSelectDiagnoseResult:@"N" judgementModel:m_judgementModel view:self];
//    }
    
    m_judgementModel.expertDiagnoseResult = @"N";
    
    [self setExpertDiagnoseResult:m_judgementModel.expertDiagnoseResult];
}

- (IBAction)onClickSelectButton:(id)sender
{
    m_judgementModel.expertDiagnoseResult = @"Y";
    
    [self setExpertDiagnoseResult:m_judgementModel.expertDiagnoseResult];
}

@end
