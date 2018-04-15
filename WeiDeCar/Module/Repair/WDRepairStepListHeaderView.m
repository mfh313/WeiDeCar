//
//  WDRepairStepListHeaderView.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/11.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairStepListHeaderView.h"

@implementation WDRepairStepListHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        m_titleLabel = [[UILabel alloc] init];
        m_titleLabel.textAlignment = NSTextAlignmentCenter;
        m_titleLabel.font = [UIFont systemFontOfSize:14.0f];
        m_titleLabel.textColor = [UIColor hx_colorWithHexString:@"242834"];
        m_titleLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:m_titleLabel];
        
        [m_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(100);
            make.centerX.equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.mas_top);
            make.height.mas_equalTo(self.mas_height);
        }];
    }
    
    return self;
}

-(void)setRepairStepModel:(WDRepairStepModel *)repairStep
{
    m_repairStep = repairStep;
    
    m_titleLabel.text = repairStep.repairStepDesc;
}

@end
