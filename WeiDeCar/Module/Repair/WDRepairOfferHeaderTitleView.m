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
        
        for (int i = 0; i < columnCount; i++) {
            
        }
    }
    
    return self;
}


@end
