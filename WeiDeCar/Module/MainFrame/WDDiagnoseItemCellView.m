//
//  WDDiagnoseItemCellView.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/10.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDDiagnoseItemCellView.h"
#import "WDDiagnoseModel.h"

@interface WDDiagnoseItemCellView ()
{
    __weak IBOutlet UILabel *m_createLabel;
    __weak IBOutlet UILabel *m_carOwnerIdLabel;
    __weak IBOutlet UILabel *m_mechanicIdLabel;
    __weak IBOutlet UILabel *m_expertIdLabel;
    __weak IBOutlet UILabel *m_statusNameLabel;
    __weak IBOutlet UILabel *m_tipsLabel;
    WDDiagnoseModel *m_itemModel;
}

@end

@implementation WDDiagnoseItemCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    m_statusNameLabel.textColor = [UIColor hx_colorWithHexString:@"eb4b26"];
    [m_tipsLabel setHidden:YES];
}

-(void)setDiagnoseModel:(WDDiagnoseModel *)itemModel
{
    m_itemModel = itemModel;
    
    m_createLabel.text = [NSString stringWithFormat:@"创建时间：%@",itemModel.createDate];
    m_carOwnerIdLabel.text = [NSString stringWithFormat:@"车主ID：%@",itemModel.carOwnerId];
    m_mechanicIdLabel.text = [NSString stringWithFormat:@"技师ID：%@",itemModel.mechanicId];
    m_expertIdLabel.text = [NSString stringWithFormat:@"专家ID：%@",itemModel.diagnoseId];
    m_statusNameLabel.text = itemModel.statusName;
}

-(void)setTipsHidden:(BOOL)hidden
{
    [m_tipsLabel setHidden:hidden];
}

- (IBAction)onClickButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickDiagnoseItemCellView:)]) {
        [self.m_delegate onClickDiagnoseItemCellView:m_itemModel];
    }
}

@end
