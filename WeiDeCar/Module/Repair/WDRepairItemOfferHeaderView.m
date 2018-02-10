//
//  WDRepairItemOfferHeaderView.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairItemOfferHeaderView.h"

@interface WDRepairItemOfferHeaderView ()
{
    __weak IBOutlet UILabel *m_nameLabel;
    __weak IBOutlet UILabel *m_allLabel;
    __weak IBOutlet UILabel *m_subTitleLabel;
    __weak IBOutlet UIButton *m_selectButton;
}

@end

@implementation WDRepairItemOfferHeaderView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [m_selectButton setImage:MFImage(@"select") forState:UIControlStateNormal];
    
    [m_selectButton setImage:MFImage(@"select_fill") forState:UIControlStateSelected];
    
    [m_selectButton setImage:MFImage(@"select_fill") forState:UIControlStateHighlighted];
}


@end
