//
//  WDLoginContentView.h
//  WeiDeCar
//
//  Created by mafanghua on 2017/11/27.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class WDLoginContentView;
@protocol WDLoginContentViewDelegate <NSObject>
@optional
-(void)onClickLogin:(NSString *)phone password:(NSString *)password view:(WDLoginContentView *)view;
-(void)onClickForgetPassword:(WDLoginContentView *)view;

@end

@interface WDLoginContentView : MMUIBridgeView

@property (nonatomic,weak) id<WDLoginContentViewDelegate> m_delegate;

-(void)setPhone:(NSString *)phone password:(NSString *)password;

@end
