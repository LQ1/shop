//
//  MyScoreDetailSegementView.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/2.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MyScoreDetailSegementViewClickType) {
    // 全部记录
    MyScoreDetailSegementViewClickType_All = 0,
    // 收入记录
    MyScoreDetailSegementViewClickType_Income,
    // 支出记录
    MyScoreDetailSegementViewClickType_Outcome
};

typedef void (^MyScoreDetailSegementClickBlock)(MyScoreDetailSegementViewClickType clickType);

#define MyScoreDetailSegementViewWidth 235.0f
#define MyScoreDetailSegementViewHeight 25.0f

@interface MyScoreDetailSegementView : UIView

/**
 *  类型切换的回调
 */
- (void)setChangeClickBlock:(MyScoreDetailSegementClickBlock)block;

/*
 *  切换UI显示
 */
- (void)changeUIToClickType:(MyScoreDetailSegementViewClickType)cellType;

@end
