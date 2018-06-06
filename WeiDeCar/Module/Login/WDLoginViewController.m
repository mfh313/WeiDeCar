//
//  WDLoginViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/11/27.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDLoginViewController.h"
#import "WDLoginContentView.h"
#import "WDUserLoginApi.h"
#import "WDJPUSHService.h"
#import "WDQiniuFileService.h"
#import "WDUserRegisterViewController.h"

@interface WDLoginViewController () <WDLoginContentViewDelegate,tableViewDelegate,UITableViewDelegate>
{
    MFUITableView *m_tableView;
    
    WDLoginContentView *m_loginContentView;
}

@end

@implementation WDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    m_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    m_tableView.backgroundColor = [UIColor whiteColor];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.m_delegate = self;
    m_tableView.delegate = self;
    [self.view addSubview:m_tableView];
    
    m_loginContentView = [WDLoginContentView nibView];
    m_loginContentView.m_delegate = self;
    m_loginContentView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 540);
    m_loginContentView.backgroundColor = [UIColor whiteColor];
    m_tableView.tableHeaderView = m_loginContentView;
    
#ifdef DEBUG
//    [m_loginContentView setPhone:@"zhuli" password:@"123456"];
//    [m_loginContentView setPhone:@"ff" password:@"123456"];
//    [m_loginContentView setPhone:@"jishi" password:@"123456"];
//    [m_loginContentView setPhone:@"zhuanjia" password:@"123456"];
#else
    
#endif

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.isDragging && scrollView == m_tableView) {
        [self.view endEditing:YES];
    }
}

- (void)touchesBegan_TableView:(NSSet *)arg1 withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - WDLoginContentViewDelegate
-(void)onClickLogin:(NSString *)phone password:(NSString *)password view:(WDLoginContentView *)view
{
    [self.view endEditing:YES];
    
    if ([MFStringUtil isBlankString:phone]) {
        [self showTips:@"请输入手机号"];
        return;
    }
    
    if ([MFStringUtil isBlankString:password]) {
        [self showTips:@"请输入密码"];
        return;
    }
    
    [self onClickLogin:phone password:password];
}

-(void)onClickForgetPassword:(WDLoginContentView *)view
{
    WDUserRegisterViewController *registerVC = [WDUserRegisterViewController new];
    [self.navigationController pushViewController:registerVC animated:YES];
}

-(void)onClickLogin:(NSString *)userName password:(NSString *)password
{
    __weak typeof(self) weakSelf = self;
    
    WDUserLoginApi *mfApi = [WDUserLoginApi new];
    mfApi.userName = userName;
    mfApi.passwd = password;
    
    mfApi.animatingText = @"正在登录";
    mfApi.animatingView = MFAppWindow;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        WDUserInfoModel *userInfo = [WDUserInfoModel yy_modelWithJSON:request.responseJSONObject[@"data"]];
        [strongSelf onLoginSuccess:userInfo];
        
    } failure:^(YTKBaseRequest * request) {

    }];
}

-(void)onLoginSuccess:(WDUserInfoModel *)userInfo
{
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    loginService.currentUserInfo = userInfo;
    loginService.token = userInfo.token; //[MFStringUtil URLEncodedString:userInfo.token];
    
    [[WDAppViewControllerManager getAppViewControllerManager] launchWDMainFrameViewController];
    
    NSString *alias = loginService.currentUserInfo.userId;
    WDJPUSHService *pushService = [[MMServiceCenter defaultCenter] getService:[WDJPUSHService class]];
    [pushService setPUSHAlias:alias];
    
    WDQiniuFileService *qiniuService = [[MMServiceCenter defaultCenter] getService:[WDQiniuFileService class]];
    [qiniuService getImageToken];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
