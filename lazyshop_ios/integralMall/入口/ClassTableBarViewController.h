//
//  ClassTableBarViewController.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/23.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ClassTableBarType)
{
    ClassTableBarType_HomePage = 0,
    ClassTableBarType_Category,
    ClassTableBarType_ShoppingCart,
    ClassTableBarType_Mine
};

@class CategoryViewController;

@interface ClassTableBarViewController : UITabBarController

/*
 *  切换选中
 */
- (void)changeToTab:(ClassTableBarType)type;

/*
 *  获取分类vc
 */
- (CategoryViewController *)fetchCategoryViewController;

@end
