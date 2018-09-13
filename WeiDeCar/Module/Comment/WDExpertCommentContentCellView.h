//
//  WDExpertCommentContentCellView.h
//  WeiDeCar
//
//  Created by EEKA on 2018/9/13.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDBorderTextField.h"

@class WDExpertCommentContentCellView;
@protocol WDExpertCommentContentCellViewDelegate <NSObject>
@optional
-(void)onInputComment:(NSString *)commentContent inputView:(WDExpertCommentContentCellView *)inputView;

@end

@interface WDExpertCommentContentCellView : UIView <WDBorderTextFieldDelegate>
{
    UILabel *m_titleLabel;
    WDBorderTextField *m_textField;
}

@property (nonatomic,weak) id<WDExpertCommentContentCellViewDelegate> m_delegate;

-(void)setCommentContent:(NSString *)commentContent;

@end
