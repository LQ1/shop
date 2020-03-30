//
//  CategorySegmentView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/7.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CategorySegmentViewClickType) {
    // 储值
    CategorySegmentViewClickTypeStore = 0,
    // 积分
    CategorySegmentViewClickTypeIntegral
};

typedef void (^CategorySegmentClickBlock)(CategorySegmentViewClickType clickType);

@interface CategorySegmentView : UIView

/**
 *  类型切换的回调
 */
- (void)setChangeClickBlock:(CategorySegmentClickBlock)block;

/*
 *  切换UI显示
 */
- (void)changeUIToClickType:(CategorySegmentViewClickType)cellType;

@end
