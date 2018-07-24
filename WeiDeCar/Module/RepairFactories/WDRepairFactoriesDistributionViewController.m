//
//  WDRepairFactoriesDistributionViewController.m
//  WeiDeCar
//
//  Created by EEKA on 2018/7/24.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairFactoriesDistributionViewController.h"
#import "WDRepairFactoryModel.h"
#import "WDListRepairFactoriesApi.h"
#import "WDStoreAnnotationView.h"

@interface WDRepairFactoriesDistributionViewController () <MAMapViewDelegate,WDStoreAnnotationCalloutViewDelegate>
{
    NSMutableArray<WDRepairFactoryModel *> *m_repairFactorys;
    
    MAMapView *m_mapView;
}

@end

@implementation WDRepairFactoriesDistributionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修理厂分布";
    [self setBackBarButton];
    
    [AMapServices sharedServices].enableHTTPS = YES;
    
    m_mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    m_mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    m_mapView.delegate = self;
    m_mapView.zoomLevel = 11;
    m_mapView.zoomEnabled = YES;
    [self.view addSubview:m_mapView];
    
    //如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    m_mapView.showsUserLocation = YES;
    m_mapView.showTraffic = YES;
    m_mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    [self getListRepairFactories];
}

-(void)getListRepairFactories
{
    __weak typeof(self) weakSelf = self;
    WDListRepairFactoriesApi *mfApi = [WDListRepairFactoriesApi new];
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *datas = request.responseJSONObject[@"data"];
        NSMutableArray *repairFactorys = [NSMutableArray array];
        for (int i = 0; i < datas.count; i++) {
            WDRepairFactoryModel *itemModel = [WDRepairFactoryModel yy_modelWithDictionary:datas[i]];
            [repairFactorys addObject:itemModel];
        }
        
        m_repairFactorys = repairFactorys;
        
        [self addAnnotations];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)addAnnotations
{
    for (int i = 0; i < m_repairFactorys.count; i++) {
        
        WDRepairFactoryModel *repairFactory = m_repairFactorys[i];
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(repairFactory.latOfGaodeMap,repairFactory.lngOfGaodeMap);
        
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = coordinate;
        pointAnnotation.title = repairFactory.entityName;
        pointAnnotation.subtitle = repairFactory.entityDesc;
        
        [m_mapView addAnnotation:pointAnnotation];
    }
}

#pragma mark - Map Delegate
- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        return nil;
    }
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        WDStoreAnnotationView *annotationView = (WDStoreAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[WDStoreAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
            annotationView.m_delegate = self;
        }
        
        annotationView.canShowCallout = NO;
        annotationView.calloutOffset = CGPointMake(0, -1);
        
        MAPointAnnotation *pointAnnotation = (MAPointAnnotation *)annotation;
        [annotationView setPointAnnotation:pointAnnotation];
        [annotationView setTitle:pointAnnotation.title subTitle:pointAnnotation.subtitle];
        
        return annotationView;
    }
    
    return nil;
}

#pragma mark - WDStoreAnnotationCalloutViewDelegate
-(void)onClickStoreNavigation:(MAPointAnnotation *)pointAnnotation
{
    NSURL *gaode_App = [NSURL URLWithString:@"iosamap://"];
    if ([[UIApplication sharedApplication] canOpenURL:gaode_App])
    {
        CLLocationCoordinate2D coordinate = pointAnnotation.coordinate;
        
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&poiname=fangheng&poiid=BGVIS&lat=%f&lon=%f&dev=1&style=2",@"维德专修",coordinate.latitude,coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *myLocationScheme = [NSURL URLWithString:urlString];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:myLocationScheme options:@{} completionHandler:^(BOOL success) {
                NSLog(@"scheme调用结束");
            }];
        } else {
            [[UIApplication sharedApplication] openURL:myLocationScheme];
        }
    }
    else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E9%AB%98%E5%BE%B7%E5%9C%B0%E5%9B%BE-%E7%B2%BE%E5%87%86%E5%9C%B0%E5%9B%BE-%E5%AF%BC%E8%88%AA%E5%87%BA%E8%A1%8C%E5%BF%85%E5%A4%87/id461703208?mt=8"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
