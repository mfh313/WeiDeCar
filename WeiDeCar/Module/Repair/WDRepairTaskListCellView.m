//
//  WDRepairTaskListCellView.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairTaskListCellView.h"
#import "WDDiagnoseModel.h"

@interface WDRepairTaskListCellView ()
{
    __weak IBOutlet UILabel *m_createLabel;
    __weak IBOutlet UILabel *m_carOwnerIdLabel;
    __weak IBOutlet UILabel *m_mechanicIdLabel;
    __weak IBOutlet UILabel *m_expertIdLabel;
    __weak IBOutlet UILabel *m_statusNameLabel;
    
    WDDiagnoseModel *m_itemModel;
}

@end

@implementation WDRepairTaskListCellView

-(void)setRepairDiagnoseModel:(WDDiagnoseModel *)itemModel
{
    m_itemModel = itemModel;
    
    m_createLabel.text = [NSString stringWithFormat:@"诊断任务ID：%@",itemModel.diagnoseId];
    m_carOwnerIdLabel.text = [NSString stringWithFormat:@"车主ID：%@",itemModel.carOwnerId];
    m_mechanicIdLabel.text = [NSString stringWithFormat:@"技师ID：%@",itemModel.mechanicId];
    m_expertIdLabel.text = [NSString stringWithFormat:@"专家ID：%@",itemModel.diagnoseId];
    m_statusNameLabel.text = [NSString stringWithFormat:@"状态：%@",itemModel.statusName];
}

- (IBAction)onClickButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickRepairTaskCellView:)]) {
        [self.m_delegate onClickRepairTaskCellView:m_itemModel];
    }
}

@end
