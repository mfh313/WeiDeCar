//
//  WDDiagnoseDetailResultView.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/7/1.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDDiagnoseModel.h"

@interface WDDiagnoseDetailResultView : UIView
{
    UIView *m_faultAppearanceView; //故障现象
    UIView *m_causeJudgementsContentView;
    
    UILabel *m_faultAppearanceLabel;
}

-(void)setDiagnoseModel:(WDDiagnoseModel *)diagnoseModel appearanceModel:(WDDiagnoseItemFaultAppearanceModel *)appearanceModel;

@end
