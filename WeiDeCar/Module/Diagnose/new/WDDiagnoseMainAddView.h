//
//  WDDiagnoseMainAddView.h
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/6.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class WDDiagnoseMainAddView;
@protocol WDDiagnoseMainAddViewDelegate <NSObject>
@optional
-(void)onClickAddNewRecord:(WDDiagnoseMainAddView *)view;

@end

@interface WDDiagnoseMainAddView : MMUIBridgeView

@property (nonatomic,weak) id<WDDiagnoseMainAddViewDelegate> m_delegate;

- (void)setAddDescString:(NSString *)desc;

@end
