//
//  WDRepairItemOfferListModel.m
//  WeiDeCar
//
//  Created by EEKA on 2018/2/11.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDRepairItemOfferListModel.h"

@implementation WDRepairItemOfferListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"repairItemOffers" : [WDRepairItemOfferModel class]};
}

@end
