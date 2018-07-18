//
//  WDMechanicCertificationsDetailCellView.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/7/16.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDMechanicCertificationsDetailCellView.h"

@implementation WDMechanicCertificationsDetailCellView

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
        
        m_repairItemNameLabel = [self titleLabelWithContentView:m_repairItemNameView];
        m_assignedMechanicLabel = [self titleLabelWithContentView:m_assignedMechanicView];
        m_hasRepairExperienceLabel = [self titleLabelWithContentView:m_hasRepairExperienceView];
        m_knowProcessLabel = [self titleLabelWithContentView:m_knowProcessView];
        m_needExpertGuideLabel = [self titleLabelWithContentView:m_needExpertGuideView];
        m_qualifiedLabel = [self titleLabelWithContentView:m_qualifiedView];
        
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

-(void)setRepairItemAssignmentModel:(WDRepairItemAssignmentModel *)repairItemAssignment
{
    m_repairItemNameLabel.text = repairItemAssignment.repairItem.repairItemName;
    m_assignedMechanicLabel.text = repairItemAssignment.assignedMechanicId;
    if ([repairItemAssignment.hasRepairExperience isEqualToString:@"Y"]) {
        m_hasRepairExperienceLabel.text = @"是";
    }
    else
    {
        m_hasRepairExperienceLabel.text = @"否";
    }
    
    m_knowProcessLabel.text = @"了解";
    
    if ([repairItemAssignment.needExpertGuide isEqualToString:@"Y"]) {
        m_needExpertGuideLabel.text = @"是";
    }
    else
    {
        m_needExpertGuideLabel.text = @"否";
    }
    
    if ([repairItemAssignment.qualified isEqualToString:@"Y"]) {
        m_qualifiedLabel.text = @"合格";
    }
    else
    {
        m_qualifiedLabel.text = @"不合格";
    }
}

-(UILabel *)titleLabelWithContentView:(UIView *)itemView
{
    UILabel *titleLabel = [UILabel new];
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
    
    return titleLabel;
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

@end
