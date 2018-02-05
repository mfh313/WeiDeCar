//
//  WDDiagnoseDetailViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/1/29.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDDiagnoseDetailViewController.h"

@interface WDDiagnoseDetailViewController ()
{
    NSMutableArray<WDDiagnoseItemFaultAppearanceModel *> *m_faultAppearances;
}

@property (nonatomic, strong) NSMutableArray *sectionsArray;

@property (nonatomic, strong) NSMutableIndexSet *expandableSections;

@end

@implementation WDDiagnoseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"诊断详情";
    [self setBackBarButton];
    
    _sectionsArray = [NSMutableArray array];
    _expandableSections = [NSMutableIndexSet indexSet];
    
    WDDiagnoseItemModel *diagnoseItems = self.detailModel.diagnoseItems;
    m_faultAppearances = diagnoseItems.faultAppearances;
    
}



-(void)onClickBottomButton
{
//    if (self.detailModel.status == WDDiagnoseStatus_MECHANIC_DIAGNOSED)
//    {
//        __weak typeof(self) weakSelf = self;
//        LGAlertView *alertView = [LGAlertView alertViewWithTitle:@"提示" message:@"是否确认技师诊断结果?" style:LGAlertViewStyleAlert buttonTitles:@[@"确定"] cancelButtonTitle:@"取消" destructiveButtonTitle:nil actionHandler:^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
//
//            __strong typeof(weakSelf) strongSelf = weakSelf;
//            [strongSelf confirmDiagnoseByCarOwner:itemModel];
//
//        } cancelHandler:nil destructiveHandler:nil];
//
//        [alertView showAnimated:YES completionHandler:nil];
//    }
//    else if (itemModel.status == WDDiagnoseStatus_EXPERT_DIAGNOSED)
//    {
//        __weak typeof(self) weakSelf = self;
//        LGAlertView *alertView = [LGAlertView alertViewWithTitle:@"提示" message:@"是否确认专家复诊结果?" style:LGAlertViewStyleAlert buttonTitles:@[@"确定"] cancelButtonTitle:@"取消" destructiveButtonTitle:nil actionHandler:^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
//
//            __strong typeof(weakSelf) strongSelf = weakSelf;
//            [strongSelf reconfirmAfterExpertDiagnosed:itemModel];
//
//        } cancelHandler:nil destructiveHandler:nil];
//
//        [alertView showAnimated:YES completionHandler:nil];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
