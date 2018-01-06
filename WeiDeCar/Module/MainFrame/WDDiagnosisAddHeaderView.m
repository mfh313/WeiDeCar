//
//  WDDiagnosisAddHeaderView.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/6.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDDiagnosisAddHeaderView.h"
#import "WDDiagnosisTypeSelectView.h"
#import "WDBorderTextField.h"

@interface WDDiagnosisAddHeaderView () <SPTabDataSource,SPTabDelegate,UITextFieldDelegate,WDBorderTextFieldDelegate>
{
    __weak IBOutlet WDBorderTextField *m_appearanceTextField;
    __weak IBOutlet WDBorderTextField *m_causeNameTextField;
    
    __weak IBOutlet UIView *m_typeSelectView;
    __weak IBOutlet UIButton *m_addButton;
    
    WDDiagnosisTypeSelectView *m_typeViews;
    
    NSMutableArray<NSMutableDictionary *> *m_typeValueArray;
    
    NSInteger m_selectTypeIndex;
    NSMutableSet *m_addedIndexSet;
}

@end

@implementation WDDiagnosisAddHeaderView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    m_typeValueArray = [self typeValueArray];
    m_addedIndexSet = [NSMutableSet set];
    
    [m_addButton setBackgroundImage:MFImageStretchCenter(@"registerButton") forState:UIControlStateNormal];
    
    UITextField *appearanceTextField = [m_appearanceTextField contentTextField];
    appearanceTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    appearanceTextField.placeholder = @"请输入故障现象";
    appearanceTextField.returnKeyType = UIReturnKeyDone;
    
    UITextField *causeNameTextField = [m_causeNameTextField contentTextField];
    causeNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    causeNameTextField.placeholder = @"请输入故障原因";
    causeNameTextField.returnKeyType = UIReturnKeyDone;
    
    m_appearanceTextField.m_delegate = self;
    m_causeNameTextField.m_delegate = self;
    
    m_typeViews = [[WDDiagnosisTypeSelectView alloc] initWithFrame:m_typeSelectView.bounds dataSource:self delegate:self];
    m_typeViews.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    m_typeViews.backgroundColor = [UIColor whiteColor];
    [m_typeSelectView addSubview:m_typeViews];
}

#pragma mark - WDBorderTextFieldDelegate
-(BOOL)borderTextField:(WDBorderTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(void)borderTextFiledEditChanged:(WDBorderTextField *)textField
{
    
}

-(NSMutableArray *)typeValueArray
{
    NSMutableArray *info = [NSMutableArray array];
    
    NSMutableDictionary *isCertain = [NSMutableDictionary dictionary];
    isCertain[@"title"] = @"确定原因";
    isCertain[@"value"] = @"isCertain";
    
    NSMutableDictionary *isCheapest = [NSMutableDictionary dictionary];
    isCheapest[@"title"] = @"最廉价原因";
    isCheapest[@"value"] = @"isCheapest";
    
    NSMutableDictionary *isMostPossible = [NSMutableDictionary dictionary];
    isMostPossible[@"title"] = @"最可能原因";
    isMostPossible[@"value"] = @"isMostPossible";
    
    [info addObject:isCertain];
    [info addObject:isCheapest];
    [info addObject:isMostPossible];
    
    return info;
}

#pragma mark - SPTabDataSource
- (NSString *)titleForIndex:(NSInteger)index
{
    NSMutableDictionary *itemInfo = m_typeValueArray[index];
    return itemInfo[@"title"];
}

- (CGFloat)preferTabX
{
    return 0;
}

-(NSInteger)preferPageFirstAtIndex
{
    return 0;
}

- (NSInteger)numberOfTab
{
    return m_typeValueArray.count;
}

- (CGFloat)tabWidthForIndex:(NSInteger)index
{
    return 90;
}

- (UIColor *)titleColorForIndex:(NSInteger)index
{
    return [UIColor blackColor];
}

- (UIColor *)titleHighlightColorForIndex:(NSInteger)index
{
    return [UIColor orangeColor];
}

- (UIFont *)titleFontForIndex:(NSInteger)index
{
    return [UIFont systemFontOfSize:14.0];
}

- (UIColor *)tabBackgroundColor
{
    return [UIColor whiteColor];
}

#pragma mark - SPTabDelegate
- (void)didPressTabForIndex:(NSInteger)index
{
    m_selectTypeIndex = index;
}

- (IBAction)onClickAddButton:(id)sender {
    
    UITextField *appearanceTextField = [m_appearanceTextField contentTextField];
    UITextField *causeNameTextField = [m_causeNameTextField contentTextField];
    
    NSString *faultAppearanceName = appearanceTextField.text;
    if ([self.m_delegate respondsToSelector:@selector(onClickAddFaultAppearanceName:headerView:)])
    {
        if (![self.m_delegate onClickAddFaultAppearanceName:faultAppearanceName headerView:self])
        {
            return;
        }
    }
    
    NSMutableDictionary *itemInfo = m_typeValueArray[m_selectTypeIndex];
    NSString *value = itemInfo[@"value"];
    
    NSString *isCertain = @"N";
    NSString *isCheapest = @"N";
    NSString *isMostPossible = @"N";
    
    if ([value isEqualToString:@"isCertain"]) {
        isCertain = @"Y";
    }
    
    if ([value isEqualToString:@"isCheapest"]) {
        isCheapest = @"Y";
    }
    
    if ([value isEqualToString:@"isMostPossible"]) {
        isMostPossible = @"Y";
    }
    
    NSString *causeJudgementName = causeNameTextField.text;
    if ([self.m_delegate respondsToSelector:@selector(onClickAddCauseJudgementName:isCertain:isCheapest:isMostPossible:headerView:)]) {
        [self.m_delegate onClickAddCauseJudgementName:causeJudgementName
                                            isCertain:isCertain
                                           isCheapest:isCheapest
                                       isMostPossible:isMostPossible
                                           headerView:self];
    }
    
    [m_addedIndexSet addObject:@(m_selectTypeIndex)];
    NSInteger newIndex = 0;
    for (int i = 0; i < m_typeValueArray.count; i++) {
        if (![m_addedIndexSet containsObject:@(i)]) {
            newIndex = i;
            break;
        }
    }
    
    m_selectTypeIndex = newIndex;
    [m_typeViews reloadHighlightToIndex:m_selectTypeIndex];
}

-(void)resetInputJudgementContent
{
    UITextField *causeNameTextField = [m_causeNameTextField contentTextField];
    causeNameTextField.text = nil;
}

@end

