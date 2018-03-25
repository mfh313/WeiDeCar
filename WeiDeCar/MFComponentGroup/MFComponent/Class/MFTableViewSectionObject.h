//
//  MFTableViewSectionObject.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/5.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MFTableViewCellObject.h"

@interface MFTableViewSectionObject : NSObject

@property (nonatomic,assign) NSInteger sectionIndex;
@property (nonatomic,assign) CGFloat sectionHeaderHeight;
@property (nonatomic,assign) BOOL isExpand;
@property (nonatomic,strong) NSMutableArray<MFTableViewCellObject *> *cellObjects;

@end
