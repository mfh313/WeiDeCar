//
//  WDRepairStepItemImageViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/3/12.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairStepItemImageViewController.h"
#import "WDListPhotoByRepairStepIdApi.h"

@interface WDRepairStepItemImageViewController ()
{
    UIImageView *m_imageView;
}

@end

@implementation WDRepairStepItemImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"维修图片详情";
    [self setBackBarButton];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    m_imageView = [[UIImageView alloc] init];
    m_imageView.contentMode = UIViewContentModeScaleAspectFit;
    m_imageView.image = MFImage(@"image_blank");
    [self.view addSubview:m_imageView];
    
    [m_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_height);
    }];
    
    [self getPhotoByRepairStepId];
}

-(void)getPhotoByRepairStepId
{
    __weak typeof(self) weakSelf = self;
    WDListPhotoByRepairStepIdApi *mfApi = [WDListPhotoByRepairStepIdApi new];
    mfApi.repairStepId = self.repairStep.repairStepId;
    
    mfApi.animatingView = self.view;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *responseNetworkData = mfApi.responseNetworkData;
        NSString *photoUrl = ((NSDictionary *)responseNetworkData.firstObject)[@"photoUrl"];
        [m_imageView sd_setImageWithURL:[NSURL URLWithString:photoUrl] placeholderImage:MFImage(@"image_blank")];
        
    } failure:^(YTKBaseRequest * request) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
