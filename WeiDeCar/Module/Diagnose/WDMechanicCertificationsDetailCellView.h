//
//  WDMechanicCertificationsDetailCellView.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/7/16.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDRepairItemAssignmentModel.h"

@interface WDMechanicCertificationsDetailCellView : UIView
{
    UIView *m_repairItemNameView; //维修项目
    UIView *m_assignedMechanicView;  //维修技师
    UIView *m_hasRepairExperienceView;  //有维修经验
    UIView *m_knowProcessView;  //掌握维修流程
    UIView *m_needExpertGuideView;  //需要专家指导
    
    UILabel *m_repairItemNameLabel;
    UILabel *m_assignedMechanicLabel;
    UILabel *m_hasRepairExperienceLabel;
    UILabel *m_knowProcessLabel;
    UILabel *m_needExpertGuideLabel;
}

-(void)setRepairItemAssignmentModel:(WDRepairItemAssignmentModel *)repairItemAssignment;

@end
