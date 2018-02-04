//
//  WDUserRegisterViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/11/27.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDUserRegisterViewController.h"
#import "WDBorderTextField.h"
#import "WDCarOwnerRegisterApi.h"

@interface WDUserRegisterViewController () <tableViewDelegate,UITableViewDataSource,UITableViewDelegate,WDBorderTextFieldDelegate>
{
    MFUITableView *m_tableView;
    NSMutableArray<MFTableViewCellObject *> *m_cellInfos;
    
    NSMutableArray *m_registerInfos;
    
    NSMutableDictionary *m_carOwnerInfo;
}

@end

@implementation WDUserRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"维德会员注册";
    [self setBackBarButton];
    
    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    m_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    m_tableView.backgroundColor = [UIColor whiteColor];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    [self.view addSubview:m_tableView];
    
    m_cellInfos = [NSMutableArray array];
    m_carOwnerInfo = [NSMutableDictionary dictionary];
    [self initRegisterInfos];
    
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
    else if ([identifier isEqualToString:@"registerButton"])
    {
        return [self tableView:tableView registerCellForIndex:indexPath];
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
    
    NSInteger attachIndex = cellInfo.attachIndex;
    NSMutableDictionary *registerInfo = m_registerInfos[attachIndex];
    NSString *textFieldKey = registerInfo[@"key"];
    
    WDBorderTextField *cellView = (WDBorderTextField *)cell.m_subContentView;
    cellView.frame = CGRectMake(40, 0, (CGRectGetWidth(cell.contentView.frame) - 80), CGRectGetHeight(cell.contentView.frame));
    cellView.textFieldKey = textFieldKey;
    cellView.textFieldIndex = attachIndex;
    cellView.m_delegate = self;
    
    UITextField *contentTextField = [cellView contentTextField];
    contentTextField.enablesReturnKeyAutomatically = YES;
    contentTextField.returnKeyType = UIReturnKeyDone;
    contentTextField.placeholder = registerInfo[@"placeholder"];
    
    NSString *value = m_carOwnerInfo[textFieldKey];
    contentTextField.text = value;
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView registerCellForIndex:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        registerButton.frame = CGRectMake((CGRectGetWidth(cell.contentView.frame) - 120) /2 , 0, 120, CGRectGetHeight(cell.contentView.frame));
        registerButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [registerButton setBackgroundImage:MFImageStretchCenter(@"btn_blue_normal") forState:UIControlStateNormal];
        [registerButton addTarget:self action:@selector(onClickRegisterUser) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:registerButton];
    }
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

-(void)makeCellObjects
{
    MFTableViewCellObject *topBlank = [MFTableViewCellObject new];
    topBlank.cellHeight = 60.0f;
    topBlank.cellReuseIdentifier = @"division";
    [m_cellInfos addObject:topBlank];
    
    for (int i = 0; i < m_registerInfos.count; i++)
    {
        MFTableViewCellObject *textFieldItem = [MFTableViewCellObject new];
        textFieldItem.cellHeight = 48.0f;
        textFieldItem.cellReuseIdentifier = @"textField";
        textFieldItem.attachIndex = i;
        [m_cellInfos addObject:textFieldItem];
        
        if (i != m_registerInfos.count - 1)
        {
            MFTableViewCellObject *blank = [MFTableViewCellObject new];
            blank.cellHeight = 10.0f;
            blank.cellReuseIdentifier = @"division";
            [m_cellInfos addObject:blank];
        }
    }
    
    MFTableViewCellObject *blank = [MFTableViewCellObject new];
    blank.cellHeight = 40.0f;
    blank.cellReuseIdentifier = @"division";
    [m_cellInfos addObject:blank];
    
    MFTableViewCellObject *registerButton = [MFTableViewCellObject new];
    registerButton.cellHeight = 48.0f;
    registerButton.cellReuseIdentifier = @"registerButton";
    [m_cellInfos addObject:registerButton];
}

-(void)initRegisterInfos
{
    m_registerInfos = [NSMutableArray array];
    
    NSMutableDictionary *cartType = [NSMutableDictionary dictionary];
    cartType[@"key"] = @"carModel";
    cartType[@"placeholder"] = @"车型";
    
    NSMutableDictionary *cartNo = [NSMutableDictionary dictionary];
    cartNo[@"key"] = @"vinNo";
    cartNo[@"placeholder"] = @"车架后7位";
    
    NSMutableDictionary *phone = [NSMutableDictionary dictionary];
    phone[@"key"] = @"telephone";
    phone[@"placeholder"] = @"手机号";
    
    NSMutableDictionary *password = [NSMutableDictionary dictionary];
    password[@"key"] = @"passwd";
    password[@"placeholder"] = @"密码";
    
    [m_registerInfos addObject:cartType];
    [m_registerInfos addObject:cartNo];
    [m_registerInfos addObject:phone];
    [m_registerInfos addObject:password];
}

-(BOOL)preCheckRegisterInfo
{
    if ([MFStringUtil isBlankString:m_carOwnerInfo[@"telephone"]]) {
        [self showTips:@"请输入手机号"];
        return NO;
    }
    
    if ([MFStringUtil isBlankString:m_carOwnerInfo[@"passwd"]]) {
        [self showTips:@"请输入密码"];
        return NO;
    }
    
    if ([MFStringUtil isBlankString:m_carOwnerInfo[@"vinNo"]]) {
        [self showTips:@"请输入车架号"];
        return NO;
    }
    
    if ([MFStringUtil isBlankString:m_carOwnerInfo[@"carModel"]]) {
        [self showTips:@"请输入车型"];
        return NO;
    }
    
    return YES;
}

-(void)onClickRegisterUser
{
    if (![self preCheckRegisterInfo]) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
    WDCarOwnerRegisterApi *mfApi = [WDCarOwnerRegisterApi new];
    mfApi.registerInfo = m_carOwnerInfo;
    mfApi.animatingText = @"正在注册...";
    mfApi.animatingView = MFAppWindow;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        [[WDAppViewControllerManager getAppViewControllerManager] launchLoginViewController];
        
    } failure:^(YTKBaseRequest * request) {
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

#pragma mark - WDBorderTextFieldDelegate
-(BOOL)borderTextField:(WDBorderTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    UITextField *contentTextField = [textField contentTextField];
    NSString *oldText = contentTextField.text;
    
    if ([string isEqualToString:@"\n"]) {
        [contentTextField resignFirstResponder];
        return NO;
    }
    
    NSString *toBeString = [contentTextField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    return YES;
}

-(void)borderTextFiledEditChanged:(WDBorderTextField *)textField
{
    NSInteger attachIndex = textField.textFieldIndex;
    NSMutableDictionary *registerInfo = m_registerInfos[attachIndex];
    NSString *textFieldKey = registerInfo[@"key"];
    
    UITextField *contentTextField = [textField contentTextField];
    NSString *newText = contentTextField.text;

    [m_carOwnerInfo safeSetObject:newText forKey:textFieldKey];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
