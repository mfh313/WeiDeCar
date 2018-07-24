//
//  WDStoreAnnotationCalloutView.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/1/6.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@protocol WDStoreAnnotationCalloutViewDelegate <NSObject>
@optional
-(void)onClickStoreNavigation:(MAPointAnnotation *)pointAnnotation;

@end

@interface WDStoreAnnotationCalloutView : MMUIBridgeView
{
    MAPointAnnotation *m_pointAnnotation;
}

@property (nonatomic,weak) id<WDStoreAnnotationCalloutViewDelegate> m_delegate;

-(void)setPointAnnotation:(MAPointAnnotation *)pointAnnotation;
-(void)setTitle:(NSString *)title subTitle:(NSString *)subTitle;

@end
