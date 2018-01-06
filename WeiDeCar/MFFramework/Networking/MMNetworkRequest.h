//
//  MMNetworkRequest.h
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/8.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>
#import <YTKNetwork/YTKBatchRequest.h>
#import "YTKBaseRequest+AnimatingAccessory.h"

@interface MMNetworkRequest : YTKRequest

-(BOOL)useGlobalAppToken;
-(id)requestArgumentWithToken;
-(BOOL)messageSuccess;
-(NSString*)errorMessage;

@end
