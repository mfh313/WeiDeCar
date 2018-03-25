//
//  WDDiagnoseInfoCreateViewController.h
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/10.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMUIViewController.h"

@class WDDiagnoseItemFaultAppearanceModel;
@protocol WDDiagnoseInfoCreateViewControllerDelegate <NSObject>
@optional

-(void)onCreatFaultAppearance:(WDDiagnoseItemFaultAppearanceModel *)faultAppearanceModel;

@end

@class WDDiagnoseModel;
@interface WDDiagnoseInfoCreateViewController : MMUIViewController

@property (nonatomic,weak) id<WDDiagnoseInfoCreateViewControllerDelegate> m_delegate;
@property (nonatomic,strong) WDDiagnoseModel *diagnoseModel;

@end
