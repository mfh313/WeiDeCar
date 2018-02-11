//
//  WDRepairItemOfferListModel.h
//  WeiDeCar
//
//  Created by EEKA on 2018/2/11.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDRepairItemOfferModel.h"

@interface WDRepairItemOfferListModel : NSObject

@property (nonatomic,strong) NSString *repairItemId;
@property (nonatomic,strong) NSString *repairItemName;
@property (nonatomic,strong) NSMutableArray<WDRepairItemOfferModel *> *repairItemOffers;

@end
