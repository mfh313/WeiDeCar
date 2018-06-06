//
//  WDMainFrameBubbleObject.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/6/7.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDMainFrameBubbleObject : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *key;
@property (nonatomic,assign) BOOL left;
@property (nonatomic,assign) BOOL bigPoint;
@property (nonatomic,assign) CGSize bubbleSize;
@property (nonatomic,strong) NSString *bubbleImage;

@end
