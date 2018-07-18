//
//  WDMechanicCertificationsDetailCellHeaderView.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/7/16.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDMechanicCertificationsDetailCellHeaderView.h"

@implementation WDMechanicCertificationsDetailCellHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor hx_colorWithHexString:@"f8f6f9"];
        
        m_repairItemNameView = [UIView new];
        [self addSubview:m_repairItemNameView];
        
        m_assignedMechanicView = [UIView new];
        [self addSubview:m_assignedMechanicView];
        
        m_hasRepairExperienceView = [UIView new];
        [self addSubview:m_hasRepairExperienceView];
        
        m_knowProcessView = [UIView new];
        [self addSubview:m_knowProcessView];
        
        m_needExpertGuideView = [UIView new];
        [self addSubview:m_needExpertGuideView];
        
        m_qualifiedView = [UIView new];
        [self addSubview:m_qualifiedView];
        
        [m_qualifiedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(self.mas_height);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [m_needExpertGuideView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(m_qualifiedView.mas_left);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(self.mas_height);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [m_knowProcessView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(m_needExpertGuideView.mas_left);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(self.mas_height);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [m_hasRepairExperienceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(m_knowProcessView.mas_left);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(self.mas_height);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [m_assignedMechanicView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(m_hasRepairExperienceView.mas_left);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(self.mas_height);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [m_repairItemNameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(m_assignedMechanicView.mas_left);
            make.height.mas_equalTo(self.mas_height);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [self initContentView:m_repairItemNameView title:@"维修\n项目"];
        [self initContentView:m_assignedMechanicView title:@"维修\n技师"];
        [self initContentView:m_hasRepairExperienceView title:@"有\n维修经验"];
        [self initContentView:m_knowProcessView title:@"掌握\n维修流程"];
        [self initContentView:m_needExpertGuideView title:@"需要\n专家指导"];
        [self initContentView:m_qualifiedView title:@"是否\n合格"];
        
        UIView *upSeparator = [UIView new];
        upSeparator.backgroundColor = MFCustomLineColor;
        [self addSubview:upSeparator];
        
        [upSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.height.mas_equalTo(MFOnePixHeight);
            make.top.mas_equalTo(self.mas_top);
            make.width.mas_equalTo(self.mas_width);
        }];
        
        UIView *downSeparator = [UIView new];
        downSeparator.backgroundColor = MFCustomLineColor;
        [self addSubview:downSeparator];
        
        [downSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.height.mas_equalTo(MFOnePixHeight);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.width.mas_equalTo(self.mas_width);
        }];
        
        [self addVerticalLine:m_repairItemNameView];
        [self addVerticalLine:m_assignedMechanicView];
        [self addVerticalLine:m_hasRepairExperienceView];
        [self addVerticalLine:m_knowProcessView];
        [self addVerticalLine:m_needExpertGuideView];
    }
    
    return self;
}

-(void)addVerticalLine:(UIView *)itemView
{
    UIView *separator = [UIView new];
    separator.backgroundColor = MFCustomLineColor;
    [itemView addSubview:separator];
    
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(itemView.mas_trailing).offset(MFOnePixHeight);
        make.width.mas_equalTo(MFOnePixHeight);
        make.top.mas_equalTo(itemView.mas_top);
        make.height.mas_equalTo(itemView.mas_height);
    }];
}

-(void)initContentView:(UIView *)itemView title:(NSString *)title
{
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = title;
    titleLabel.textColor = MFBlackColor;
    titleLabel.font = [UIFont systemFontOfSize:13.0f];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    [itemView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(itemView.mas_left);
        make.right.mas_equalTo(itemView.mas_right);
        make.height.mas_equalTo(itemView.mas_height);
        make.centerY.mas_equalTo(itemView.mas_centerY);
    }];
}

@end
