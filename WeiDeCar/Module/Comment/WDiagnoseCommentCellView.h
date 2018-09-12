//
//  WDiagnoseCommentCellView.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/9/12.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GRStarsView.h>

@class WDiagnoseCommentCellView;
@protocol WDiagnoseCommentCellViewDelegate <NSObject>
@optional
-(void)onClickChangeScore:(CGFloat)score attachDataIndex:(NSInteger)index cellView:(WDiagnoseCommentCellView *)cellView;

@end

@interface WDiagnoseCommentCellView : UIView
{
    UILabel *m_commentValueLabel;
    GRStarsView *m_starsView;
}

@property (nonatomic,assign) NSInteger attachDataIndex;
@property (nonatomic,weak) id<WDiagnoseCommentCellViewDelegate> m_delegate;

-(void)setCommentValue:(NSString *)commentValue score:(CGFloat)score;

@end
