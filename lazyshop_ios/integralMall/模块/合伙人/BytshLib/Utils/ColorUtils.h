//
//  ColorUtils.h
//  JSBD
//
//  Created by xtkj on 15/7/15.
//  Copyright (c) 2015年 xtkj. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//主配色
#define COLOR_MAIN [UIColor colorWithRed:0xED/255.0f green:0x6D/255.0f blue:0x00/255.0f alpha:1.0f]
//线条颜色
#define COLOR_LINE [UIColor colorWithRed:0xdd/255.0f green:0xdd/255.0f blue:0xdd/255.0f alpha:1]
//深蓝
#define COLOR_DARK_BLUE [UIColor colorWithRed:0x0b/255.0f green:0x5b/255.0f blue:0xac/255.0f alpha:1]
//浅蓝
#define COLOR_LIGHT_BLUE [UIColor colorWithRed:0x26/255.0f green:0x93/255.0f blue:0xff/255.0f alpha:1]
//灰色
#define COLOR_GRAY [UIColor colorWithRed:88/255.0f green:88/255.0f blue:88/255.0f alpha:1]
//按钮背景色
#define COLOR_BTN_MASTER_BACKGROUND [UIColor colorWithRed:0x26/255.0f green:0x93/255.0f blue:0xff/255.0f alpha:1]

#define COLOR_WHITE = [UIColor colorWithRed:1 green:1 blue:1 alpha:1]

@interface ColorUtils : NSObject

+ (UIColor*)getMainColor;
+ (UIColor*)getMainTitleBgColor;
+ (UIColor*)getMainTabNormalColor;
+ (UIColor*)getmainTabSelectedColor;

+ (UIColor*)getLineColor;


+ (UIColor*)getBtnDarkColor;
+ (UIColor*)getBtnLightColor;

+ (UIColor*)getBtnMasterColor;

+ (UIColor*)getGrayColor;

+ (UIColor*)getRandomColor;
@end
