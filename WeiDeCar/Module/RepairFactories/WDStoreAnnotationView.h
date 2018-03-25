//
//  WDStoreAnnotationView.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/1/6.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "WDStoreAnnotationCalloutView.h"

@interface WDStoreAnnotationView : MAAnnotationView

@property (nonatomic,weak) id<WDStoreAnnotationCalloutViewDelegate> m_delegate;

-(void)setTitle:(NSString *)title subTitle:(NSString *)subTitle;

@end

