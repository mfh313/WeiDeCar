//
//  WDDiagnoseListBaseViewController.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/12.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIViewController.h"
#import "WDDiagnoseModel.h"
#import "WDDiagnoseItemCellView.h"

@interface WDDiagnoseListBaseViewController : MMUIViewController <UITableViewDataSource,UITableViewDelegate,WDDiagnoseItemCellViewDelegate>
{
    MFUITableView *m_tableView;
    WDUserInfoModel *m_currentUserInfo;
    NSMutableArray<WDDiagnoseModel *> *m_diagnoseArray;
}

@end
