//
//  DLGuidScrollPresenter.h
//  MobileClassPhone
//
//  Created by Bryce on 15/1/23.
//  Copyright (c) 2015年 CDEL. All rights reserved.
//

#import "DLGuidPage.h"
#import <UIKit/UIKit.h>
typedef void (^guidViewCloseBlock)(void);

@interface DLGuidScrollPresenter : UIScrollView

/**
 *  设置数据源
 */
- (void)setupViewsWithArray:(NSArray *)array;

/**
 *  广告页关闭时执行
 */
- (void)guidViewClose:(guidViewCloseBlock)block;

@end
