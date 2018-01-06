//
//  WDStoreAnnotationCalloutView.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/1/6.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDStoreAnnotationCalloutView.h"

#define kArrorHeight        10

@interface WDStoreAnnotationCalloutView ()
{
    __weak IBOutlet UILabel *m_titleLabel;
    __weak IBOutlet UILabel *m_subTitleLabel;
    __weak IBOutlet UIButton *m_contentBtn;
}

@end

@implementation WDStoreAnnotationCalloutView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
}

-(void)setTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    m_titleLabel.text = title;
    m_subTitleLabel.text = subTitle;
}

- (IBAction)onClickContentButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickStoreNavigation)]) {
        [self.m_delegate onClickStoreNavigation];
    }
}

- (void)drawRect:(CGRect)rect
{
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}

- (void)drawInContext:(CGContextRef)context
{
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8].CGColor);

    [self getDrawPath:context];
    CGContextFillPath(context);
}

- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}

@end
