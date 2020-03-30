//
//  CategoryRightPageView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/8.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CategoryFirstItemViewModel;

@interface CategoryRightPageView : UIView

@property (nonatomic,assign)NSInteger pageNumber;

@property (nonatomic,readonly)RACSubject *gotoProductListSignal;

- (void)reloadDataWithViewModel:(CategoryFirstItemViewModel *)viewModel;

@end
