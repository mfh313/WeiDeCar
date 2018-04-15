//
//  WDRepairStepStatusCellView.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/4/15.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairStepStatusCellView.h"

@implementation WDRepairStepStatusCellView

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
            make.left.mas_equalTo(@(10));
            make.centerY.equalTo(self.mas_centerY);
            make.top.mas_equalTo(self.mas_top);
            make.height.mas_equalTo(self.mas_height);
        }];
        
        m_finshButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [m_finshButton setTitle:@"完成" forState:UIControlStateNormal];
        [m_finshButton setBackgroundImage:MFImageStretchCenter(@"btn_blue_normal") forState:UIControlStateNormal];
        [m_finshButton addTarget:self action:@selector(onClickContentButton:) forControlEvents:UIControlEventTouchUpInside];
        m_finshButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:m_finshButton];
        
        [m_finshButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(80);
            make.right.equalTo(self.mas_right).offset(-15);
            make.height.mas_equalTo(40);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
    }
    
    return self;
}

-(void)setRepairStepModel:(WDRepairStepModel *)repairStep
{
    m_repairStep = repairStep;
    
    m_titleLabel.text = repairStep.statusName;
    
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    WDUserInfoModel *currentUserInfo = loginService.currentUserInfo;
    if (currentUserInfo.userType == WDUserInfoType_CarOwner)
    {
        [m_finshButton setHidden:YES];
    }
    else
    {
        [m_finshButton setHidden:NO];
    }
}

-(void)onClickContentButton:(id)sender
{
    if ([self.m_delegate respondsToSelector:@selector(onClickFinishRepairStep:statusCellView:)]) {
        [self.m_delegate onClickFinishRepairStep:m_repairStep statusCellView:self];
    }
}

@end
