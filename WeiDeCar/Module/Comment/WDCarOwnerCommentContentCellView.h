//
//  WDCarOwnerCommentContentCellView.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/9/12.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDBorderTextField.h"

@class WDCarOwnerCommentContentCellView;
@protocol WDCarOwnerCommentContentCellViewDelegate <NSObject>
@optional
-(void)onInputComment:(NSString *)commentContent inputView:(WDCarOwnerCommentContentCellView *)inputView;

@end

@interface WDCarOwnerCommentContentCellView : UIView <WDBorderTextFieldDelegate>
{
    UILabel *m_titleLabel;
    WDBorderTextField *m_textField;
}

@property (nonatomic,weak) id<WDCarOwnerCommentContentCellViewDelegate> m_delegate;

-(void)setCommentContent:(NSString *)commentContent;

@end
