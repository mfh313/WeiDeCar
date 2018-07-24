//
//  WDRepairFactoryMapViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/1/6.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairFactoryMapViewController.h"
#import "WDStoreAnnotationView.h"

@interface WDRepairFactoryMapViewController () <MAMapViewDelegate,WDStoreAnnotationCalloutViewDelegate>
{
    MAMapView *m_mapView;
    
    CLLocationCoordinate2D m_coordinate;
}

@end

@implementation WDRepairFactoryMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.repairFactory.entityName;
    [self setBackBarButton];
    
    [AMapServices sharedServices].enableHTTPS = YES;
    
    m_mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    m_mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    m_mapView.delegate = self;
    m_mapView.zoomLevel = 16.1;
    m_mapView.zoomEnabled = YES;
    [self.view addSubview:m_mapView];
    
    //如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    m_mapView.showsUserLocation = YES;
    m_mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    m_coordinate = CLLocationCoordinate2DMake(self.repairFactory.latOfGaodeMap,self.repairFactory.lngOfGaodeMap);
    [m_mapView setCenterCoordinate:m_coordinate animated:YES];
    
    [self addAnnotation];
}

-(void)onClickRightBtn:(id)sender
{
    [self addAnnotation];
}

-(void)addAnnotation
{
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = m_coordinate;
    pointAnnotation.title = self.repairFactory.entityName;
    pointAnnotation.subtitle = self.repairFactory.entityDesc;
    
    [m_mapView addAnnotation:pointAnnotation];
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
    LGAlertView *alertView = [LGAlertView alertViewWithTitle:@"导航到该地点" message:nil style:LGAlertViewStyleActionSheet buttonTitles:@[@"高德地图导航",@"百度地图导航"] cancelButtonTitle:@"取消" destructiveButtonTitle:nil actionHandler:^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
        
        if (index == 0)
        {
            [self gaoDeNavigation];
        }
        else if (index == 1)
        {
            [self baiduNavigation];
        }
        
    } cancelHandler:^(LGAlertView * _Nonnull alertView) {
        
    } destructiveHandler:nil];
    
    [alertView showAnimated:YES completionHandler:nil];
}

-(void)baiduNavigation
{
    NSString *urlsting =[[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",m_coordinate.latitude,m_coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlsting]];
}

-(void)gaoDeNavigation
{
    NSURL *gaode_App = [NSURL URLWithString:@"iosamap://"];
    if ([[UIApplication sharedApplication] canOpenURL:gaode_App])
    {
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&poiname=fangheng&poiid=BGVIS&lat=%f&lon=%f&dev=1&style=2",@"维德专修",m_coordinate.latitude,m_coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
        //高德文档
        //http://lbs.amap.com/api/amap-mobile/guide/ios/navi
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E9%AB%98%E5%BE%B7%E5%9C%B0%E5%9B%BE-%E7%B2%BE%E5%87%86%E5%9C%B0%E5%9B%BE-%E5%AF%BC%E8%88%AA%E5%87%BA%E8%A1%8C%E5%BF%85%E5%A4%87/id461703208?mt=8"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
