//
//  WDRepairStepAddRequest.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/7/15.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDRepairStepAddRequest : NSObject

@property (nonatomic,assign) NSInteger stepOrder;
@property (nonatomic,strong) NSString *repairStepDesc;

@end
