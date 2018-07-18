//
//  WDMechanicCertificationsDetailCellHeaderView.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/7/16.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDMechanicCertificationsDetailCellHeaderView : UIView
{
    UIView *m_repairItemNameView; //维修项目
    UIView *m_assignedMechanicView;  //维修技师
    UIView *m_hasRepairExperienceView;  //有维修经验
    UIView *m_knowProcessView;  //掌握维修流程
    UIView *m_needExpertGuideView;  //需要专家指导
    UIView *m_qualifiedView;  //是否合格
}

@end
