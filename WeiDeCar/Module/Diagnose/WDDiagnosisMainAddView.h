//
//  WDDiagnosisMainAddView.h
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/6.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class WDDiagnosisMainAddView;
@protocol WDDiagnosisMainAddViewDelegate <NSObject>
@optional
-(void)onClickAddNewRecord:(WDDiagnosisMainAddView *)view;

@end

@interface WDDiagnosisMainAddView : MMUIBridgeView

@property (nonatomic,weak) id<WDDiagnosisMainAddViewDelegate> m_delegate;

- (void)setAddDescString:(NSString *)desc;

@end
