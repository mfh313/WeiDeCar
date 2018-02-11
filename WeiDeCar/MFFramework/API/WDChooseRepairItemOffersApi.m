//
//  WDChooseRepairItemOffersApi.m
//  WeiDeCar
//
//  Created by EEKA on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDChooseRepairItemOffersApi.h"

@implementation WDChooseRepairItemOffersApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger chooseRepairItemOffers];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    
    requestArgument[@"carOwnerId"] = self.carOwnerId;
    requestArgument[@"diagnoseId"] = self.diagnoseId;
    
    NSMutableArray *offerChooseResultArray = [NSMutableArray array];
    for (int i = 0; i < self.selectOfferItems.count; i++) {
        
        WDRepairItemOfferListModel *listModel = self.selectOfferItems[i];
        
        NSMutableDictionary *repairItemInfo = [NSMutableDictionary dictionary];
        repairItemInfo[@"repairItemId"] = listModel.repairItemId;
        repairItemInfo[@"status"] = @(listModel.status);
        
        [offerChooseResultArray addObject:repairItemInfo];
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:offerChooseResultArray
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    requestArgument[@"offerChooseResult"] = jsonString;
    
    return requestArgument;
}

@end
