//
//  MMUIViewController.m
//  YJCustom
//
//  Created by EEKA on 16/9/19.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import "MMUIViewController.h"
#import "MMBarButton.h"

@interface MMUIViewController ()

@end

@implementation MMUIViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    m_cellInfos = [NSMutableArray array];
}

-(void)setWantsFullScreen:(BOOL)wantsFullScreenLayout
{
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(void)setBackBarButton
{
    UIView *leftNavigationView = [UIView new];
    leftNavigationView.frame = CGRectMake(0, 0, 62, 44);
    MMBarButton *m_btn = [MMBarButton buttonWithType:UIButtonTypeCustom];
    [m_btn addTarget:self action:@selector(onClickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    m_btn.frame = CGRectMake(5, 0, 57, 44);
    [m_btn setImage:MFImage(@"title_btn_return_nor") forState:UIControlStateNormal];
    [m_btn setImage:MFImage(@"title_btn_return_press") forState:UIControlStateHighlighted];
    [m_btn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 34)];
    [leftNavigationView addSubview:m_btn];
    m_leftBarBtnItem = [[UIBarButtonItem alloc] initWithCustomView:leftNavigationView];
    [self.navigationItem setLeftBarButtonItem:m_leftBarBtnItem];
}

-(void)setLeftBarButtonTitle:(NSString *)title action:(SEL)anAction
{
    UIFont *titleFont = [UIFont systemFontOfSize:16];
    CGFloat titleWidth = [self titleWidth:title font:titleFont];
    
    UIView *navigationView = [UIView new];
    navigationView.frame = CGRectMake(0, 0, 5 + titleWidth, 44);
    MMBarButton *m_btn = [MMBarButton buttonWithType:UIButtonTypeCustom];
    [m_btn addTarget:self action:anAction forControlEvents:UIControlEventTouchUpInside];
    
    m_btn.frame = CGRectMake(5, 0, titleWidth, 44);
    m_btn.titleLabel.font = titleFont;
    [m_btn setTitle:title forState:UIControlStateNormal];
    [m_btn setTitleColor:[UIColor hx_colorWithHexString:@"0080C0"] forState:UIControlStateNormal];
    [navigationView addSubview:m_btn];
    m_leftBarBtnItem = [[UIBarButtonItem alloc] initWithCustomView:navigationView];
    [self.navigationItem setLeftBarButtonItem:m_leftBarBtnItem];
}

-(CGFloat)titleWidth:(NSString *)title font:(UIFont *)font
{
    return MAX(57, [title MMSizeWithFont:font maxSize:CGSizeZero].width);
}

-(void)setRightBarButtonTitle:(NSString *)title
{
    UIFont *titleFont = [UIFont systemFontOfSize:16];
    CGFloat titleWidth = [self titleWidth:title font:titleFont];
    
    UIView *navigationView = [UIView new];
    navigationView.frame = CGRectMake(0, 0, 10 + titleWidth, 44);
    MMBarButton *m_btn = [MMBarButton buttonWithType:UIButtonTypeCustom];
    [m_btn addTarget:self action:@selector(onClickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    
    m_btn.frame = CGRectMake(0, 0, titleWidth, 44);
    m_btn.titleLabel.font = titleFont;
    [m_btn setTitle:title forState:UIControlStateNormal];
    [m_btn setTitleColor:[UIColor hx_colorWithHexString:@"0080C0"] forState:UIControlStateNormal];
    [navigationView addSubview:m_btn];
    m_rightBarBtnItem = [[UIBarButtonItem alloc] initWithCustomView:navigationView];
    [self.navigationItem setRightBarButtonItem:m_rightBarBtnItem];
}

-(void)onClickRightButton:(id)sender
{
    
}

-(void)onClickBackBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
} 

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
