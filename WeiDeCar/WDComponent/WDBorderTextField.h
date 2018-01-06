//
//  WDBorderTextField.h
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/7.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class WDBorderTextField;
@protocol WDBorderTextFieldDelegate <NSObject>
@optional

-(BOOL)borderTextField:(WDBorderTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
-(void)borderTextFiledEditChanged:(WDBorderTextField *)textField;

@end

@interface WDBorderTextField : MMUIBridgeView 

@property (nonatomic,weak) id<WDBorderTextFieldDelegate> m_delegate;
@property (nonatomic,strong) NSString *textFieldKey;
@property (nonatomic,assign) NSInteger textFieldIndex;

-(UITextField *)contentTextField;

-(BOOL)becomeFirstResponder;
-(BOOL)resignFirstResponder;

@end
