//
//  MMBaseInfoItem.m
//  YJCustom
//
//  Created by EEKA on 2016/10/20.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import "MMBaseInfoItem.h"

@implementation MMBaseInfoItem
@synthesize m_key,m_tip,m_title,m_view,m_bActive,m_bEnable;

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
    
- (void)becomeFirstResponder
{
    [m_view becomeFirstResponder];
}
    
- (id)getValue
{
    return nil;
}
    
- (void)initView:(CGRect)frame
{
    m_view.frame = frame;
}
    
- (id)initWithTitle:(NSString *)title tip:(NSString *)tip key:(NSString *)key
{
    self = [super init];
    if (self) {
        m_title = title;
        m_tip = tip;
        m_key = key;
        
        m_view = [[UIView alloc] init];
    }
    
    return self;
}
    
- (void)resignFirstResponder
{
    [m_view resignFirstResponder];
}

- (void)setDelegate:(id)delegate
{
    m_delegate = delegate;
}

- (void)setEnable:(BOOL)enable
{
    m_bEnable = enable;
}

- (void)setSuperView:(UIView *)view
{
    m_superView = view;
}


@end
