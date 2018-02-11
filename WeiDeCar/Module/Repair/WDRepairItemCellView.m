//
//  WDRepairItemCellView.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/11.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairItemCellView.h"

@interface WDRepairItemCellView ()
{
    NSMutableArray *m_titleLabelArray;
}

@end

@implementation WDRepairItemCellView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        m_titleLabelArray = [NSMutableArray array];
        
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:14.0f];
        titleLabel.textColor = [UIColor hx_colorWithHexString:@"242834"];
        titleLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:titleLabel];
        
        
        UILabel *subTitleLabel = [[UILabel alloc] init];
        subTitleLabel.textAlignment = NSTextAlignmentCenter;
        subTitleLabel.font = [UIFont systemFontOfSize:14.0f];
        subTitleLabel.textColor = [UIColor hx_colorWithHexString:@"242834"];
        subTitleLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:subTitleLabel];
        
        UIView *separator = [UIView new];
        separator.backgroundColor = MFCustomLineColor;
        [self addSubview:separator];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.width.mas_equalTo(100);
            make.top.mas_equalTo(self.mas_top);
            make.height.mas_equalTo(self.mas_height);
        }];
        
        [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLabel.mas_right);
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(self.mas_top);
            make.height.mas_equalTo(self.mas_height);
        }];
        
        [separator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(subTitleLabel.mas_leading).offset(MFOnePixHeight);
            make.width.mas_equalTo(MFOnePixHeight);
            make.top.mas_equalTo(subTitleLabel.mas_top);
            make.height.mas_equalTo(subTitleLabel.mas_height);
        }];
        
        [m_titleLabelArray addObject:titleLabel];
        [m_titleLabelArray addObject:subTitleLabel];
        
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
