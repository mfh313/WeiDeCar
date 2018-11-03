//
//  WDiagnoseCommentContentCellView.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/11/3.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDiagnoseCommentContentCellView : UIView
{
    UILabel *m_titleLabel;
    UILabel *m_contentLabel;
}

-(void)setUserTitle:(NSString *)title commentContent:(NSString *)commentContent;

@end
