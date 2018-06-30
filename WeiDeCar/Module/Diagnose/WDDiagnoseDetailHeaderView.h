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
    UILabel *m_faultAppearanceLabel; //故障现象
    UILabel *m_causeJudgementLabel;  //原因判断
    UILabel *m_isCertainLabel;  //确定原因
    UILabel *m_isCheapestLabel;  //最廉价原因
    UILabel *m_isMostPossibleLabel;  //最可能原因
    UILabel *m_expertDiagnoseResultLabel;  //第三方专家复诊
}

@property (nonatomic,weak) id<WDDiagnoseDetailHeaderViewDataSource> m_dataSource;

@end
