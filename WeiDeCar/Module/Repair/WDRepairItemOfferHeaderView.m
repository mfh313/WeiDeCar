//
//  WDRepairItemOfferHeaderView.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairItemOfferHeaderView.h"
#import "WDRepairItemOfferListModel.h"

@interface WDRepairItemOfferHeaderView ()
{
    __weak IBOutlet UILabel *m_nameLabel;
    __weak IBOutlet UILabel *m_allLabel;
    __weak IBOutlet UILabel *m_subTitleLabel;
    __weak IBOutlet UIButton *m_selectButton;
    
    WDRepairItemOfferListModel *m_itemModel;
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

-(void)setRepairItemOfferListModel:(WDRepairItemOfferListModel *)itemModel
{
    m_itemModel = itemModel;
    
    m_nameLabel.text = itemModel.repairItemName;
    m_allLabel.text = [NSString stringWithFormat:@"合计 %f",itemModel.totalCost];
    m_subTitleLabel.text = [NSString stringWithFormat:@"预计节省 %f",itemModel.saveCost];
    if (itemModel.status == WDRepairItemOfferStatus_10)
    {
        [m_selectButton setSelected:NO];
    }
    else
    {
        [m_selectButton setSelected:YES];
    }
}


@end
