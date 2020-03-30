//
//  ColorUtils.m
//  JSBD
//
//  Created by xtkj on 15/7/15.
//  Copyright (c) 2015年 xtkj. All rights reserved.
//

#import "ColorUtils.h"

@implementation ColorUtils

+ (UIColor*)getMainColor{
    return [UIColor colorWithRed:0xED/255.0f green:0x6D/255.0f blue:0x00/255.0f alpha:1.0f];
}

+ (UIColor*)getMainTitleBgColor{
    return [UIColor colorWithRed:0x26/255.0f green:0x93/255.0f blue:0xFF/255.0f alpha:1.0f];
    //[UIColor colorWithRed:0x26/255.0f green:0x93/255.0f blue:0xff/255.0f alpha:1.0f];
}
//主界面标签页正常色
+ (UIColor*)getMainTabNormalColor{
    return [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
}
//主界面标签页选中色
+ (UIColor*)getmainTabSelectedColor{
    return [UIColor colorWithRed:0 green:109/255.0f blue:217/255.0f alpha:1];
}

+ (UIColor*)getLineColor{
    return [UIColor colorWithRed:0xdd/255.0f green:0xdd/255.0f blue:0xdd/255.0f alpha:1];
}

+ (UIColor*)getBtnDarkColor{
    return [UIColor colorWithRed:0x0b/255.0f green:0x5b/255.0f blue:0xac/255.0f alpha:1];
}

+ (UIColor*)getBtnLightColor{
    return [UIColor colorWithRed:0x26/255.0f green:0x93/255.0f blue:0xff/255.0f alpha:1];
}
//本项目按钮主色配
+ (UIColor*)getBtnMasterColor{
    return [UIColor colorWithRed:0x104/255.0f green:152/255.0f blue:134/255.0f alpha:1.0f];
}

+ (UIColor*)getGrayColor{
    return [UIColor colorWithRed:88/255.0f green:88/255.0f blue:88/255.0f alpha:1];
}


//随机颜色
+ (UIColor*)getRandomColor{
//    NSArray<UIColor*> *arrayColors = [NSArray arrayWithObjects:[UIColor colorWithHexString:@"0xC3B19D"],
//                                      [UIColor colorWithHexString:@"0x8FA3A7"],
//                                      [UIColor colorWithHexString:@"0xC8BC98"],
//                                      [UIColor colorWithHexString:@"0xB1C5A3"],
//                                      [UIColor colorWithHexString:@"0xAF9AB2"],
//                                      [UIColor colorWithHexString:@"0x8FB2BF"],
//                                      nil];
//
//    return [arrayColors objectAtIndex:arc4random()%arrayColors.count];
    return [UIColor whiteColor];
}
@end
