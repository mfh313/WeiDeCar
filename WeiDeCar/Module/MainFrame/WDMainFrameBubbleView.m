//
//  WDMainFrameBubbleView.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/6/7.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDMainFrameBubbleView.h"

@implementation WDMainFrameBubbleView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *lineImageView = [UIImageView new];
        lineImageView.image = MFImage(@"main_line");
        [self addSubview:lineImageView];
        
        [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(2);
            make.top.mas_equalTo(self.mas_top);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.height.mas_equalTo(self.mas_centerY);
        }];
    }
    
    return self;
}

-(void)setMainFrameBubbleObject:(WDMainFrameBubbleObject *)bubbleObject
{
    
}

@end
