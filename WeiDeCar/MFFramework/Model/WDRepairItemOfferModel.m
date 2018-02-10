//
//  WDRepairItemOfferModel.m
//  WeiDeCar
//
//  Created by EEKA on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairItemOfferModel.h"

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
