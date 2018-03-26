//
//  WDCarOwnerDiagnoseListViewController.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/3/26.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDDiagnoseListBaseViewController.h"
#import "WDDiagnoseMainAddView.h"
#import "WDListDiagnoseByCarOwnerApi.h"
#import "WDCreateDiagnoseByCarOwnerApi.h"

@interface WDCarOwnerDiagnoseListViewController : WDDiagnoseListBaseViewController <WDDiagnoseMainAddViewDelegate>
{
    WDDiagnoseMainAddView *m_createDiagnoseView;
}

@end


