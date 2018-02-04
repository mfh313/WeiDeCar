//
//  WDGuideViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/11/17.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WDGuideViewController.h"
#import <iCarousel/iCarousel.h>
#import <SMPageControl/SMPageControl.h>
#import "WDGuideSourceModel.h"
#import "WDGuidePageView.h"
#import "WDGuideBottomView.h"

@interface WDGuideViewController () <iCarouselDelegate,iCarouselDataSource,WDGuideBottomViewDelegate>
{
    NSMutableArray<WDGuideSourceModel *> *m_guideInfo;
    SMPageControl *m_pageControl;
    WDGuideBottomView *m_bottomView;
}

@property (nonatomic,strong) iCarousel *guideCarousel;

@end

@implementation WDGuideViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    m_guideInfo = [NSMutableArray array];
    [self initGuideSources];
    
    self.guideCarousel =({
        iCarousel *icarousel = [[iCarousel alloc] init];
        icarousel.dataSource = self;
        icarousel.delegate = self;
        
        icarousel.type = iCarouselTypeLinear;
        icarousel.scrollSpeed = 1.0;
        icarousel.pagingEnabled = YES;
        
        icarousel.decelerationRate = 1.0;
        icarousel.clipsToBounds = YES;
        icarousel.bounceDistance = 0.0001;
        
        [self.view addSubview:icarousel];
        
        [icarousel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.view.mas_width);
            make.height.equalTo(self.view.mas_height);
        }];
        
        icarousel;
    });
    
    m_pageControl = [[SMPageControl alloc] init];
    m_pageControl.numberOfPages = m_guideInfo.count;
    m_pageControl.pageIndicatorImage = MFImage(@"dot_hollow");
    m_pageControl.currentPageIndicatorImage = MFImage(@"dot_solid");
    [m_pageControl sizeToFit];
    m_pageControl.backgroundColor = [UIColor clearColor];
    [m_pageControl addTarget:self action:@selector(onPageChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:m_pageControl];
    
    [m_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(30);
    }];
    
    m_bottomView = [WDGuideBottomView nibView];
    m_bottomView.m_delegate = self;
    m_bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:m_bottomView];
    
    [m_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(m_pageControl.mas_top).offset(-15);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(45);
    }];
    
    [m_bottomView setHidden:YES];
}

-(void)onPageChange:(SMPageControl *)page
{
    [self.guideCarousel setCurrentItemIndex:page.currentPage];
}

-(void)initGuideSources
{
    WDGuideSourceModel *mode1 = [WDGuideSourceModel new];
    mode1.image = @"guide_1";
    
    WDGuideSourceModel *mode2 = [WDGuideSourceModel new];
    mode2.image = @"guide_2";
    
    WDGuideSourceModel *mode3 = [WDGuideSourceModel new];
    mode3.image = @"guide_3";
    
    WDGuideSourceModel *mode4 = [WDGuideSourceModel new];
    mode4.image = @"guide_4";
    
    WDGuideSourceModel *mode5 = [WDGuideSourceModel new];
    mode5.image = @"guide_5";
    
    WDGuideSourceModel *mode6 = [WDGuideSourceModel new];
    mode6.image = @"guide_6";
    
    [m_guideInfo addObject:mode1];
    [m_guideInfo addObject:mode2];
    [m_guideInfo addObject:mode3];
    [m_guideInfo addObject:mode4];
    [m_guideInfo addObject:mode5];
    [m_guideInfo addObject:mode6];
}

#pragma mark - ICarousel 协议
-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return m_guideInfo.count;
}

-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    WDGuideSourceModel *sourceModel = m_guideInfo[index];
    
    WDGuidePageView *pageView = [[WDGuidePageView alloc] initWithFrame:carousel.bounds];
    [pageView setSourceModel:sourceModel];
    return pageView;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    m_pageControl.currentPage = carousel.currentItemIndex;
    
    if (carousel.currentItemIndex == m_guideInfo.count - 1) {
        [m_bottomView setHidden:NO];
    }
    else
    {
        [m_bottomView setHidden:YES];
    }
}

#pragma mark - WDGuideBottomViewDelegate
-(void)onClickRegister:(WDGuideBottomView *)view
{
    [[WDAppViewControllerManager getAppViewControllerManager] launchUserRegisterViewController];
}

-(void)onClickLogin:(WDGuideBottomView *)view
{
    [[WDAppViewControllerManager getAppViewControllerManager] launchLoginViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
