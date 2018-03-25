//
//  WDDiagnosisTypeSelectView.h
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/6.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPTabProtocol.h"

@interface WDDiagnosisTypeSelectView : UIScrollView

- (instancetype)initWithFrame:(CGRect)frame dataSource:(id<SPTabDataSource>)dataSource delegate:(id<SPTabDelegate>)delegate;

@property (nonatomic, weak, readonly) id<SPTabDataSource> tabDataSource;
@property (nonatomic, weak, readonly) id<SPTabDelegate> tabDelegate;
@property (assign, nonatomic) BOOL markViewScroll;

- (void)markViewScrollToContentRatio:(CGFloat)contentRatio;

- (void)markViewScrollToIndex:(NSInteger)index;

- (void)reloadHighlightToIndex:(NSInteger)index;

- (void)scrollTagToIndex:(NSUInteger)toIndex;

- (void)reloadTabBarTitleColor;

@end
