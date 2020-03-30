//
//  CategoryViewController.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/23.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "NavigationBarController.h"

@interface CategoryViewController : NavigationBarController

//标识是否是从其他页面进入
@property BOOL isEnterFromMakeMoney;

/*
 *  视图切换
 */
- (void)changeToViewWithGoods_cat_type:(NSString *)goods_cat_type
                          goods_cat_id:(NSString *)goods_cat_id;

@end
