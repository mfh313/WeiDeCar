//
//  WDDiagnoseDetailResultCauseJudgementsItemView.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/7/1.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDDiagnoseModel.h"

@interface WDDiagnoseDetailResultCauseJudgementsItemView : UIView
{
    UIView *m_causeJudgementView;  //原因判断
    UIView *m_isCertainView;  //确定原因
    UIView *m_isCheapestView;  //最廉价原因
    UIView *m_isMostPossibleView;  //最可能原因
    UIView *m_expertDiagnoseResultView;  //第三方专家复诊
    
    UILabel *m_causeJudgementLabel;
    UIImageView *m_isCertainImageView;
    UIImageView *m_isCheapestImageView;
    UIImageView *m_isMostPossibleImageView;
    UIImageView *m_expertDiagnoseImageView;
}

-(void)setAppearanceModel:(WDDiagnoseItemFaultAppearanceModel *)appearanceModel causeJudgements:(WDDiagnoseCauseJudgementModel *)causeJudgements;

@end
