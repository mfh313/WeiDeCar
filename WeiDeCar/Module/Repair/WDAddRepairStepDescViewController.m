//
//  WDAddRepairStepDescViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/7/15.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDAddRepairStepDescViewController.h"
#import "WDBorderTextField.h"

@interface WDAddRepairStepDescViewController () <tableViewDelegate,UITableViewDataSource,UITableViewDelegate,WDBorderTextFieldDelegate>
{
    MFUITableView *m_tableView;
    NSMutableArray<MFTableViewCellObject *> *m_cellInfos;
    
    NSString *m_repairStepDesc;
}

@end

@implementation WDAddRepairStepDescViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新增维修步骤描述";
    [self setBackBarButton];
    [self setRightNaviButtonWithTitle:@"确定" action:@selector(onClickDoneAddRepairStep)];
    
    m_cellInfos = [NSMutableArray array];
    
    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    m_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    m_tableView.backgroundColor = [UIColor whiteColor];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    [self.view addSubview:m_tableView];
    
    [self makeCellObjects];
    [m_tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return m_cellInfos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    if ([identifier isEqualToString:@"textField"])
    {
        return [self tableView:tableView textFieldCellForIndex:indexPath];
    }
    else if ([identifier isEqualToString:@"division"])
    {
        return [self tableView:tableView divisionForIndex:indexPath];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    cell.textLabel.text = identifier;
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView textFieldCellForIndex:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDBorderTextField *cellView = [WDBorderTextField nibView];
        cell.m_subContentView = cellView;
    }
    
    WDBorderTextField *cellView = (WDBorderTextField *)cell.m_subContentView;
    cellView.frame = CGRectMake(40, 0, (CGRectGetWidth(cell.contentView.frame) - 80), CGRectGetHeight(cell.contentView.frame));
    cellView.m_delegate = self;
    
    UITextField *contentTextField = [cellView contentTextField];
    contentTextField.enablesReturnKeyAutomatically = YES;
    contentTextField.returnKeyType = UIReturnKeyDone;
    contentTextField.placeholder = @"请输入维修步骤描述";

    contentTextField.text = m_repairStepDesc;
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView divisionForIndex:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    return cellInfo.cellHeight;
}

#pragma mark - WDBorderTextFieldDelegate
-(BOOL)borderTextField:(WDBorderTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    UITextField *contentTextField = [textField contentTextField];
    
    if ([string isEqualToString:@"\n"]) {
        [contentTextField resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(void)borderTextFiledEditChanged:(WDBorderTextField *)textField
{
    UITextField *contentTextField = [textField contentTextField];
    m_repairStepDesc = contentTextField.text;
}

-(void)makeCellObjects
{
    MFTableViewCellObject *topBlank = [MFTableViewCellObject new];
    topBlank.cellHeight = 60.0f;
    topBlank.cellReuseIdentifier = @"division";
    [m_cellInfos addObject:topBlank];
    
    MFTableViewCellObject *textFieldItem = [MFTableViewCellObject new];
    textFieldItem.cellHeight = 48.0f;
    textFieldItem.cellReuseIdentifier = @"textField";
    [m_cellInfos addObject:textFieldItem];
}

-(void)onClickDoneAddRepairStep
{
    if ([MFStringUtil isBlankString:m_repairStepDesc]) {
        [self showTips:@"请输入维修步骤描述"];
        return;
    }
    
    if ([self.m_delegate respondsToSelector:@selector(didAddRepairStepDesc:controller:)]) {
        [self.m_delegate didAddRepairStepDesc:m_repairStepDesc controller:self];
    }
}

-(void)handleAddRepairStepSuccess
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
