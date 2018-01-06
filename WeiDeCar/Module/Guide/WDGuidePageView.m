//
//  WDGuidePageView.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/11/20.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDGuidePageView.h"

@interface WDGuidePageView ()
{
    UIImageView *m_imageView;
}

@end

@implementation WDGuidePageView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        m_imageView = [UIImageView new];
        m_imageView.backgroundColor = [UIColor whiteColor];
        m_imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:m_imageView];
    }
    
    return self;
}

-(void)setSourceModel:(WDGuideSourceModel *)model
{
    m_imageView.image = MFImage(model.image);
    [m_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

@end
