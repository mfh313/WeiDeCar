//
//  CTFrameParserConfigure.h
//  WeiDeCar
//
//  Created by EEKA on 2018/6/30.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface CTFrameParserConfigure : NSObject

@property (nonatomic,assign) CGFloat frameWidth;
@property (nonatomic,assign) CGFloat frameHeight;

//字体属性
@property (nonatomic,assign) CGFloat wordSpace;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) NSString *fontName;
@property (nonatomic,assign) CGFloat fontSize;

//段落属性
@property (nonatomic,assign) CGFloat lineSpace;
@property (nonatomic,assign) CTTextAlignment textAlignment; //文本对齐模式
@property (nonatomic,assign) CGFloat firstlineHeadIndent; //段首行缩进
@property (nonatomic,assign) CGFloat headIndent; //段左侧整体缩进
@property (nonatomic,assign) CGFloat tailIndent; //段尾缩进
@property (nonatomic,assign) CTLineBreakMode lineBreakMode; //换行模式
@property (nonatomic,assign) CGFloat lineHeightMutiple; //行高倍数器(它的值表示原行高的倍数)
@property (nonatomic,assign) CGFloat maxLineHeight; //最大行高限制（0表示无限制，是非负的，行高不能超过此值）
@property (nonatomic,assign) CGFloat minLineHeight; //最小行高限制
@property (nonatomic,assign) CGFloat paragraphBeforeSpace; //段前间距（相对上一段加上的间距）
@property (nonatomic,assign) CGFloat paragraphAfterSpace; //段尾间距（相对下一段加上的间距）
@property (nonatomic,assign) CTWritingDirection writeDirection; //书写方向
@property (nonatomic,assign) CGFloat lineSpacingAdjustment;

@end

//http://www.wahenzan.com/a/mdev/ios/2016/1221/11109.html
//https://blog.devtang.com/2015/06/27/using-coretext-1/
