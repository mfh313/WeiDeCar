//
//  WDFaultAppearanceHeaderView.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/11.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDFaultAppearanceHeaderView.h"

@interface WDFaultAppearanceHeaderView ()
{
    __weak IBOutlet UILabel *m_Label;
}

@end

@implementation WDFaultAppearanceHeaderView

-(void)setFaultAppearance:(NSString *)faultAppearance
{
    m_Label.text = [NSString stringWithFormat:@"故障现象：%@",faultAppearance];
}

@end
