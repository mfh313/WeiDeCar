//
//  WDDiagnoseDetailHeaderView.h
//  WeiDeCar
//
//  Created by EEKA on 2018/6/30.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WDDiagnoseDetailHeaderViewDataSource <NSObject>
@optional

@end


@interface WDDiagnoseDetailHeaderView : UIView
{
    UIView *m_faultAppearanceView; //故障现象
    UIView *m_causeJudgementView;  //原因判断
    UIView *m_isCertainView;  //确定原因
    UIView *m_isCheapestView;  //最廉价原因
    UIView *m_isMostPossibleView;  //最可能原因
    UIView *m_expertDiagnoseResultView;  //第三方专家复诊
}

@property (nonatomic,weak) id<WDDiagnoseDetailHeaderViewDataSource> m_dataSource;

@end
