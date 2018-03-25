//
//  WDChooseRepairItemOffersApi.h
//  WeiDeCar
//
//  Created by EEKA on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"
#import "WDRepairItemOfferListModel.h"

@interface WDChooseRepairItemOffersApi : MMNetworkRequest

@property (nonatomic,strong) NSMutableArray<WDRepairItemOfferListModel *> *selectOfferItems;
@property (nonatomic,strong) NSString *carOwnerId;
@property (nonatomic,strong) NSString *diagnoseId;

@end


