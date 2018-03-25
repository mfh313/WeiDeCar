//
//  WDExpertDiagnoseResultSelectView.h
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/11.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class WDExpertDiagnoseResultSelectView,WDDiagnoseCauseJudgementModel;
@protocol WDExpertDiagnoseResultSelectViewDelegate <NSObject>
@optional

-(void)onSelectDiagnoseResult:(NSString *)expertDiagnoseResult
               judgementModel:(WDDiagnoseCauseJudgementModel *)judgementModel
                         view:(WDExpertDiagnoseResultSelectView *)selectView;

@end

@interface WDExpertDiagnoseResultSelectView : MMUIBridgeView

@property (nonatomic,weak) id<WDExpertDiagnoseResultSelectViewDelegate> m_delegate;

-(void)setJudgementModel:(WDDiagnoseCauseJudgementModel *)judgementModel;

@end
