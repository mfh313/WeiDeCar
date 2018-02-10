//
//  WDRepairOfferHeaderTitleView.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairOfferHeaderTitleView.h"

@interface WDRepairOfferHeaderTitleView ()
{
    NSMutableArray *m_titleLabelArray;
}

@end

@implementation WDRepairOfferHeaderTitleView

-(instancetype)initWithFrame:(CGRect)frame columnCount:(NSInteger)columnCount
{
    self = [super initWithFrame:frame];
    if (self) {
        
        m_titleLabelArray = [NSMutableArray array];
        
        UIView *preView;
        
        for (int i = 0; i < columnCount; i++) {
            UILabel *contentLabel = [[UILabel alloc] init];
            contentLabel.textAlignment = NSTextAlignmentCenter;
            contentLabel.font = [UIFont systemFontOfSize:14.0f];
            contentLabel.textColor = [UIColor hx_colorWithHexString:@"242834"];
            contentLabel.backgroundColor = [UIColor whiteColor];
            [self addSubview:contentLabel];
            
            [m_titleLabelArray addObject:contentLabel];
            
            if (i == 0)
            {
                [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self.mas_left);
                    make.width.mas_equalTo(self.mas_width).multipliedBy(1.0/columnCount);
                    make.top.mas_equalTo(self.mas_top);
                    make.height.mas_equalTo(self.mas_height);
                }];
            }
            else
            {
                [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(preView.mas_right);
                    make.width.mas_equalTo(self.mas_width).multipliedBy(1.0/columnCount);
                    make.top.mas_equalTo(self.mas_top);
                    make.height.mas_equalTo(self.mas_height);
                }];
            }
            
            preView = contentLabel;
            
        }
    }
    
    return self;
}


-(void)setTitleArray:(NSArray<NSString *> *)titles
{
    for (int i = 0; i < titles.count; i++) {
        UILabel *contentLabel = m_titleLabelArray[i];
        contentLabel.text = titles[i];
    }
}

@end
