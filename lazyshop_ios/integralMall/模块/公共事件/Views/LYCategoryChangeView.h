//
//  LYCategoryChangeView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/14.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LYCategoryChangeViewSelectBlock)(NSInteger selectIndex);

@interface LYCategoryChangeView : UIView

/*
 *  当前选中位置
 */
@property (nonatomic,readonly)NSInteger currentSelectIndex;

/*
 *  初始化
 */
- (instancetype)initWithTitles:(NSArray *)titles
                   selectBlock:(LYCategoryChangeViewSelectBlock)block;

/*
 *  使显示
 */
- (void)showViewIn:(UIView *)parentView
     centerYOffSet:(CGFloat)YOffSet;

/*
 *  使选中
 */
- (void)makeIndexSelected:(NSInteger)index;

@end
