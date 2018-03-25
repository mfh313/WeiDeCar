//
//  WDDiagnoseCauseJudgementCellView.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/10.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDDiagnoseCauseJudgementCellView.h"

@interface WDDiagnoseCauseJudgementCellView ()
{
    __weak IBOutlet UILabel *m_nameLabel;
    __weak IBOutlet UILabel *m_typeLabel;
}

@end

@implementation WDDiagnoseCauseJudgementCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    m_nameLabel.textColor = [UIColor hx_colorWithHexString:@"27a444"];
    m_typeLabel.textColor = [UIColor hx_colorWithHexString:@"242834"];
}

-(void)setName:(NSString *)name type:(NSString *)type
{
    m_nameLabel.text = name;
    m_typeLabel.text = type;
}

@end
