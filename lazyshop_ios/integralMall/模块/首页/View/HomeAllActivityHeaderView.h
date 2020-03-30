//
//  HomeAllActivityHeaderView.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/3.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HomeAllActivityHeaderViewClickType) {
    // 懒店秒杀
    HomeAllActivityHeaderViewClickType_SecKill = 0,
    // 懒店拼团
    HomeAllActivityHeaderViewClickType_Group,
    // 懒店砍价
    HomeAllActivityHeaderViewClickType_Bargain
};

typedef void (^HomeAllActivityHeaderViewClickBlock)(HomeAllActivityHeaderViewClickType clickType);

#define HomeAllActivityHeaderViewHeight 55.0f

@interface HomeAllActivityHeaderView : UIView

/**
 *  类型切换的回调
 */
- (void)setChangeClickBlock:(HomeAllActivityHeaderViewClickBlock)block;

/*
 *  切换UI显示
 */
- (void)changeUIToClickType:(HomeAllActivityHeaderViewClickType)cellType;

@end
