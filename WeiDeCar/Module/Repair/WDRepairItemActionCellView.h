//
//  WDRepairItemActionCellView.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/11.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class WDRepairItemModel,WDRepairItemActionCellView;
@protocol WDRepairItemActionCellViewDelegate <NSObject>
@optional
-(void)onClickSelectRepairItem:(WDRepairItemModel *)repairItem cellView:(WDRepairItemActionCellView *)cellView;

@end


@interface WDRepairItemActionCellView : MMUIBridgeView
{
    UIButton *m_contentButton;
    
    WDRepairItemModel *m_repairItem;
}

@property (nonatomic,weak) id<WDRepairItemActionCellViewDelegate> m_delegate;

-(void)setRepairItemModel:(WDRepairItemModel *)repairItem;

@end
