//
//  GoodsDetailBottomView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsDetailViewModel;

typedef NS_ENUM(NSInteger,GoodsDetailBottomViewClickType)
{
    GoodsDetailBottomViewClickType_AddCart = 0,
    GoodsDetailBottomViewClickType_Pay
};

typedef void (^GoodsDetailBottomViewClickBlock)(GoodsDetailBottomViewClickType clickType);

#define GoodsDetailBottomViewHeight 55.0f

@interface GoodsDetailBottomView : UIView

@property (nonatomic,copy) GoodsDetailBottomViewClickBlock clickBlock;

@property (nonatomic,readonly) RACSubject *clickSignal;

- (instancetype)initWithViewModel:(GoodsDetailViewModel *)viewModel;

@end
