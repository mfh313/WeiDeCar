//
//  WDUploadRepairStepPhotoApi.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/3/12.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface WDUploadRepairStepPhotoApi : MMNetworkRequest

@property (nonatomic,strong) NSString *repairStepId;
@property (nonatomic,strong) NSString *photoUrl;
@property (nonatomic,strong) NSString *userId;

@end
