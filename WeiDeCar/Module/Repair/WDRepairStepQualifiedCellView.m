//
//  WDRepairStepQualifiedCellView.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/11.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairStepQualifiedCellView.h"

@interface WDRepairStepQualifiedCellView ()
{
    
}

@end

@implementation WDRepairStepQualifiedCellView

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
        
        UIView *separator = [UIView new];
        separator.backgroundColor = MFCustomLineColor;
        [self addSubview:separator];
        
        [m_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.width.mas_equalTo(100);
            make.top.mas_equalTo(self.mas_top);
            make.height.mas_equalTo(self.mas_height);
        }];
        
        [separator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(m_titleLabel.mas_trailing).offset(-MFOnePixHeight);
            make.width.mas_equalTo(MFOnePixHeight);
            make.top.mas_equalTo(self.mas_top);
            make.height.mas_equalTo(self.mas_height);
        }];
        
        m_contentLabel = [[UILabel alloc] init];
        m_contentLabel.textAlignment = NSTextAlignmentCenter;
        m_contentLabel.font = [UIFont systemFontOfSize:14.0f];
        m_contentLabel.textColor = [UIColor hx_colorWithHexString:@"242834"];
        m_contentLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:m_contentLabel];
        
        [m_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(m_titleLabel.mas_right);
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(self.mas_top);
            make.height.mas_equalTo(self.mas_height);
        }];
        
    }
    
    return self;
}

-(void)setRepairStepModel:(WDRepairStepModel *)repairStep
{
    m_repairStep = repairStep;
    
    if ([self.attachKey isEqualToString:@"onsiteQualified"])
    {
        m_titleLabel.text = @"现场检查";
        m_contentLabel.text = [self qualifiedString:m_repairStep.onsiteQualified];
    }
    else if ([self.attachKey isEqualToString:@"thirdPartyQualifed"])
    {
        m_titleLabel.text = @"第三方质检";
        m_contentLabel.text = [self qualifiedString:m_repairStep.thirdPartyQualifed];
    }
}

-(NSString *)qualifiedString:(NSInteger)status
{
    NSString *statusString = nil;
    
    if (status == WDRepairStepQualifiedStatus_10) {
        statusString = @"初始状态";
    }
    else if (status == WDRepairStepQualifiedStatus_20){
        statusString = @"开始维修";
    }
    else if (status == WDRepairStepQualifiedStatus_30){
        statusString = @"不合格";
    }
    else if (status == WDRepairStepQualifiedStatus_40){
        statusString = @"合格";
    }
    
    return statusString;
}

@end
