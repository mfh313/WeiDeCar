//
//  WDDiagnosisAddHeaderView.h
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/6.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class WDDiagnosisAddHeaderView;
@protocol WDDiagnosisAddHeaderViewDelegate <NSObject>
@optional

-(BOOL)onClickAddFaultAppearanceName:(NSString *)faultAppearanceName
                          headerView:(WDDiagnosisAddHeaderView *)view;

-(void)onClickAddCauseJudgementName:(NSString *)causeJudgementName
                      isCertain:(NSString *)isCertain
                     isCheapest:(NSString *)isCheapest
                 isMostPossible:(NSString *)isMostPossible
                     headerView:(WDDiagnosisAddHeaderView *)view;

@end

@interface WDDiagnosisAddHeaderView : MMUIBridgeView

@property (nonatomic,weak) id<WDDiagnosisAddHeaderViewDelegate> m_delegate;

-(void)resetInputJudgementContent;

@end

