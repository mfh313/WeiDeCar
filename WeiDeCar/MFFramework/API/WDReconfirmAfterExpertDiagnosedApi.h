//
//  WDReconfirmAfterExpertDiagnosedApi.h
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/11.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface WDReconfirmAfterExpertDiagnosedApi : MMNetworkRequest

@property (nonatomic,strong) NSString *diagnoseId;
@property (nonatomic,strong) NSString *carOwnerId;

@end
