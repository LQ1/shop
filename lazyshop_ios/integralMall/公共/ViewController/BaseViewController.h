//
//  BaseViewController.h
//  MobileClassPhone
//
//  Created by cyx on 14/11/13.
//  Copyright (c) 2014年 cyx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaseWithRAC/BaseWithRAC.h>
#import "UIView+Loading.h"


@interface BaseViewController : RACViewController

/*
 *  数据获取标记量
 */
@property (nonatomic,assign)BOOL hasAppeard;

@end
