//
//  WDRepairItemOfferHeaderView.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class WDRepairItemOfferListModel;
@protocol WDRepairItemOfferHeaderViewDelegate <NSObject>
@optional


@end

@interface WDRepairItemOfferHeaderView : MMUIBridgeView

@property (nonatomic,weak) id<WDRepairItemOfferHeaderViewDelegate> m_delegate;

-(void)setRepairItemOfferListModel:(WDRepairItemOfferListModel *)itemModel;

@end
