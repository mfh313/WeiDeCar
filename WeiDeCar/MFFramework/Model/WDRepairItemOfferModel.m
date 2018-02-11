//
//  WDRepairItemOfferModel.m
//  WeiDeCar
//
//  Created by EEKA on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairItemOfferModel.h"

NSInteger const WDRepairItemOfferStatus_10 = 10;   //未选择
NSInteger const WDRepairItemOfferStatus_20 = 20;  //已选择

@implementation WDRepairItemOfferModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"repairItemOfferId" : @"id"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"repairItem" : [WDRepairItemModel class]};
}

@end
