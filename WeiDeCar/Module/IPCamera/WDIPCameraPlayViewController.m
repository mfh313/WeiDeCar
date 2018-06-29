//
//  WDIPCameraPlayViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/28.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDIPCameraPlayViewController.h"
#import "EZUIKit.h"
#import "EZUIPlayer.h"
#import "EZUIError.h"

@interface WDIPCameraPlayViewController () <EZUIPlayerDelegate>

@property (nonatomic,strong) EZUIPlayer *mPlayer;
@property (nonatomic,strong) UIButton *playBtn;

@end

@implementation WDIPCameraPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"维修现场-直播";
    [self setBackBarButton];
    
    self.playBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.playBtn setTitle:NSLocalizedString(@"play", @"播放") forState:UIControlStateNormal];
    [self.playBtn setTitle:NSLocalizedString(@"stop", @"停止") forState:UIControlStateSelected];
    self.playBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-80)/2, 400, 80, 40);
    [self.playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.playBtn];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!self.appKey || self.appKey.length == 0 ||
        !self.accessToken || self.accessToken.length == 0 ||
        !self.urlStr || self.urlStr == 0)
    {
        return;
    }
    
    if (self.apiUrl)
    {
        [EZUIKit initGlobalWithAppKey:self.appKey apiUrl:self.apiUrl];
    }
    else
    {
        [EZUIKit initWithAppKey:self.appKey];
    }
    
    [EZUIKit setAccessToken:self.accessToken];
    [self play];
    self.playBtn.selected = YES;
}

- (void)dealloc
{
    [self releasePlayer];
}

#pragma mark - player delegate

- (void)EZUIPlayerFinished
{
    [self stop];
    self.playBtn.selected = NO;
}

- (void)EZUIPlayerPrepared
{
    [self play];
}

- (void)EZUIPlayerPlaySucceed:(EZUIPlayer *)player
{
    self.playBtn.selected = YES;
}

- (void)EZUIPlayer:(EZUIPlayer *)player didPlayFailed:(EZUIError *) error
{
    [self stop];
    self.playBtn.selected = NO;
    
    if ([error.errorString isEqualToString:UE_ERROR_TRANSF_DEVICE_OFFLINE])
    {
        [self showErrorMessage:@"设备不在线"];
    }
    
//    if ([error.errorString isEqualToString:UE_ERROR_INNER_VERIFYCODE_ERROR])
//    {
//        [self.view makeToast:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"verify_code_wrong", @"验证码错误"),error.errorString] duration:1.5 position:@"center"];
//    }
//    else if ([error.errorString isEqualToString:UE_ERROR_TRANSF_DEVICE_OFFLINE])
//    {
//        [self.view makeToast:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"device_offline", @"设备不在线"),error.errorString] duration:1.5 position:@"center"];
//    }
//    else if ([error.errorString isEqualToString:UE_ERROR_DEVICE_NOT_EXIST])
//    {
//        [self.view makeToast:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"device_not_exist", @"设备不存在"),error.errorString] duration:1.5 position:@"center"];
//    }
//    else if ([error.errorString isEqualToString:UE_ERROR_CAMERA_NOT_EXIST])
//    {
//        [self.view makeToast:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"camera_not_exist", @"通道不存在"),error.errorString] duration:1.5 position:@"center"];
//    }
//    else if ([error.errorString isEqualToString:UE_ERROR_INNER_STREAM_TIMEOUT])
//    {
//        [self.view makeToast:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"connect_out_time", @"连接超时"),error.errorString] duration:1.5 position:@"center"];
//    }
//    else if ([error.errorString isEqualToString:UE_ERROR_CAS_MSG_PU_NO_RESOURCE])
//    {
//        [self.view makeToast:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"connect_device_limit", @"设备连接数过大"),error.errorString] duration:1.5 position:@"center"];
//    }
//    else if ([error.errorString isEqualToString:UE_ERROR_NOT_FOUND_RECORD_FILES])
//    {
//        [self.view makeToast:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"not_find_file", @"未找到录像文件"),error.errorString] duration:1.5 position:@"center"];
//    }
//    else if ([error.errorString isEqualToString:UE_ERROR_PARAM_ERROR])
//    {
//        [self.view makeToast:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"param_error", @"参数错误"),error.errorString] duration:1.5 position:@"center"];
//    }
//    else if ([error.errorString isEqualToString:UE_ERROR_URL_FORMAT_ERROR])
//    {
//        [self.view makeToast:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"play_url_format_wrong", @"播放url格式错误"),error.errorString] duration:1.5 position:@"center"];
//    }
//    else
//    {
//        [self.view makeToast:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"play_fail", @"播放失败"),error.errorString] duration:1.5 position:@"center"];
//    }
    
    NSLog(@"play error:%@(%@)",error.errorString,@(error.internalErrorCode));
}

-(void)showErrorMessage:(NSString *)message
{
    LGAlertView *alertView = [LGAlertView alertViewWithTitle:@"提示" message:message style:LGAlertViewStyleAlert buttonTitles:nil cancelButtonTitle:@"确定" destructiveButtonTitle:nil actionHandler:nil cancelHandler:nil destructiveHandler:nil];
    [alertView showAnimated:YES completionHandler:nil];
}

- (void)EZUIPlayer:(EZUIPlayer *)player previewWidth:(CGFloat)pWidth previewHeight:(CGFloat)pHeight
{
    CGFloat ratio = pWidth/pHeight;
    
    CGFloat destWidth = CGRectGetWidth(self.view.bounds);
    CGFloat destHeight = destWidth/ratio;
    
    [player setPreviewFrame:CGRectMake(0, CGRectGetMinY(player.previewView.frame), destWidth, destHeight)];
}


#pragma mark - actions

- (void)playBtnClick:(UIButton *) btn
{
    if(btn.selected)
    {
        [self stop];
    }
    else
    {
        [self play];
    }
    btn.selected = !btn.selected;
}

#pragma mark - player

- (void)play
{
    if (self.mPlayer)
    {
        [self.mPlayer startPlay];
        return;
    }
    
    self.mPlayer = [EZUIPlayer createPlayerWithUrl:self.urlStr];
    self.mPlayer.mDelegate = self;
    //    self.mPlayer.customIndicatorView = nil;//去除加载动画
    self.mPlayer.previewView.frame = CGRectMake(0, 64,
                                                CGRectGetWidth(self.mPlayer.previewView.frame),
                                                CGRectGetHeight(self.mPlayer.previewView.frame));
    
    [self.view addSubview:self.mPlayer.previewView];
    
    //该处去除，调整到prepared回调中执行，如为预览模式也可直接调用startPlay
    //    [self.mPlayer startPlay];
}

- (void) stop
{
    if (!self.mPlayer)
    {
        return;
    }
    
    [self.mPlayer stopPlay];
}

- (void) releasePlayer
{
    if (!self.mPlayer)
    {
        return;
    }
    
    [self.mPlayer.previewView removeFromSuperview];
    [self.mPlayer releasePlayer];
    self.mPlayer = nil;
}

#pragma mark - orientation

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    CGRect frame = CGRectZero;
    if (size.height > size.width)
    {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        frame = CGRectMake(0, 64,size.width,size.width*9/16);
    }
    else
    {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        frame = CGRectMake(0, 0,size.width,size.height);
    }
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [self.mPlayer setPreviewFrame:frame];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
