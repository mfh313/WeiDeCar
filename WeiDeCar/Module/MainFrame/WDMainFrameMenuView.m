//
//  WDMainFrameMenuView.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/11/28.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDMainFrameMenuView.h"

@interface WDMainFrameMenuView ()
{
    __weak IBOutlet UIButton *m_contentBtn;
    __weak IBOutlet UILabel *m_titleLabel;
}

@end

@implementation WDMainFrameMenuView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [m_contentBtn setImage:MFImage(@"main_action") forState:UIControlStateNormal];
    [m_contentBtn addTarget:self action:@selector(onClickContentButton:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setMenuTitle:(NSString *)title index:(NSInteger)index
{
    m_titleLabel.text = title;
    self.actionIndex = index;
}

-(void)onClickContentButton:(id)sender
{
    if ([self.m_delegate respondsToSelector:@selector(onClickMainFrameMenuViewIndex:view:)]) {
        [self.m_delegate onClickMainFrameMenuViewIndex:self.actionIndex view:self];
    }
}

@end
