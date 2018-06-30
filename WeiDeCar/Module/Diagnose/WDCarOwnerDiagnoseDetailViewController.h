//
//  WDCarOwnerDiagnoseDetailViewController.h
//  WeiDeCar
//
//  Created by EEKA on 2018/6/30.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIViewController.h"
#import "WDDiagnoseModel.h"

@interface WDCarOwnerDiagnoseDetailViewController : MMUIViewController
{
    WDUserInfoModel *m_currentUserInfo;
}

@property (nonatomic,strong) WDDiagnoseModel *diagnoseModel;

@end
