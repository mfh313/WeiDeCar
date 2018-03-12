//
//  WDQiniuFileService.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/3/12.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMService.h"

typedef void (^WDQiniuFileServiceHandler)(NSString *url, NSString *name);

@interface WDQiniuFileService : MMService

@property (nonatomic,strong) NSString *token;

-(void)getImageToken;
-(void)uploadImageToQNiu:(UIImage *)image complete:(WDQiniuFileServiceHandler)completion;


@end
