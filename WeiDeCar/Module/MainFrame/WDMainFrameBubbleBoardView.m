//
//  WDMainFrameBubbleBoardView.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/6/7.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDMainFrameBubbleBoardView.h"

@implementation WDMainFrameBubbleBoardView

- (IBAction)onClickFaultDiagnosis:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickFaultDiagnosis:)]) {
        [self.m_delegate onClickFaultDiagnosis:self];
    }
}

- (IBAction)onClickRegular:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickRegular:)]) {
        [self.m_delegate onClickRegular:self];
    }
}

- (IBAction)onClickRepairFactories:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickRepairFactories:)]) {
        [self.m_delegate onClickRepairFactories:self];
    }
}

- (IBAction)onClickTroubleCar:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickTroubleCar:)]) {
        [self.m_delegate onClickTroubleCar:self];
    }
}

- (IBAction)onClickCosmetology:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickCosmetology:)]) {
        [self.m_delegate onClickCosmetology:self];
    }
}

- (IBAction)onClickRepairItems:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickRepairItems:)]) {
        [self.m_delegate onClickRepairItems:self];
    }
}


@end
