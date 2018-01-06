//
//  WDDiagnosisMainAddView.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/6.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDDiagnosisMainAddView.h"

@interface WDDiagnosisMainAddView ()
{
    __weak IBOutlet UILabel *m_descLabel;
}

@end

@implementation WDDiagnosisMainAddView

- (void)setAddDescString:(NSString *)desc
{
    m_descLabel.text = desc;
}

- (IBAction)onClickAddButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickAddNewRecord:)]) {
        [self.m_delegate onClickAddNewRecord:self];
    }
}

@end
