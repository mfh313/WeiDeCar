//
//  WDRepairFactoryModel.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/1/6.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDRepairFactoryModel : NSObject

@property (nonatomic,assign) CGFloat lngOfBaiduMap;  //百度地图纬度
@property (nonatomic,assign) CGFloat latOfBaiduMap;  //百度地图经度
@property (nonatomic,strong) NSString *updateDate;
@property (nonatomic,strong) NSString *districtCode; //区域编码
@property (nonatomic,strong) NSString *cityCode; //城市编码
@property (nonatomic,assign) NSInteger entityType; //实体类型
@property (nonatomic,strong) NSString *entityDesc; //实体描述
@property (nonatomic,strong) NSString *picUrl; //图片URL
@property (nonatomic,strong) NSString *regionCode; //省份编码
@property (nonatomic,assign) CGFloat latOfGaodeMap;  //高德地图经度
@property (nonatomic,assign) CGFloat lngOfGaodeMap;  //高德地图纬度
@property (nonatomic,strong) NSString *factoryId;
@property (nonatomic,strong) NSString *entityName; //实体名称
@property (nonatomic,strong) NSString *createDate; //创建日期
@property (nonatomic,assign) NSInteger status; //实体类型

@end
