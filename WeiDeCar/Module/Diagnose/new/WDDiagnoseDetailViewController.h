//
//  WDDiagnoseDetailViewController.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/3/27.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIViewController.h"
#import "WDDiagnoseModel.h"

@interface WDDiagnoseDetailViewController : MMUIViewController
{
    WDUserInfoModel *m_currentUserInfo;
}

@property (nonatomic,strong) WDDiagnoseModel *diagnoseModel;

@end
