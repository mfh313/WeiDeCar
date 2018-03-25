//
//  WDStoreAnnotationView.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/1/6.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDStoreAnnotationView.h"
#import "WDStoreAnnotationCalloutView.h"

@interface WDStoreAnnotationView () <WDStoreAnnotationCalloutViewDelegate>
{
    WDStoreAnnotationCalloutView *m_calloutView;
    
    UIImageView *m_pinView;
}

@end

@implementation WDStoreAnnotationView

-(void)setTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    [m_calloutView setTitle:title subTitle:subTitle];
}

-(id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, 33, 33);
        self.backgroundColor = [UIColor clearColor];
        
        m_pinView = [[UIImageView alloc] initWithImage:MFImage(@"home_yellow_point")];
        m_pinView.frame = self.bounds;
        [self addSubview:m_pinView];
        
        m_calloutView = [WDStoreAnnotationCalloutView nibView];
        m_calloutView.m_delegate = self;
        m_calloutView.frame = CGRectMake(0.f, 0.f, 250, 75);
        m_calloutView.backgroundColor = [UIColor clearColor];
        [self addSubview:m_calloutView];
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    m_calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                       -CGRectGetHeight(m_calloutView.bounds) / 2.f + self.calloutOffset.y);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    /* Points that lie outside the receiver’s bounds are never reported as hits,
     even if they actually lie within one of the receiver’s subviews.
     This can occur if the current view’s clipsToBounds property is set to NO and the affected subview extends beyond the view’s bounds.
     */
    if (!inside)
    {
        inside = [m_calloutView pointInside:[self convertPoint:point toView:m_calloutView] withEvent:event];
    }
    
    return inside;
}

#pragma mark - WDStoreAnnotationCalloutViewDelegate
-(void)onClickStoreNavigation
{
    if ([self.m_delegate respondsToSelector:@selector(onClickStoreNavigation)]) {
        [self.m_delegate onClickStoreNavigation];
    }
}

@end
