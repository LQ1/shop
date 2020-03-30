//
//  CategoryRightRowCell.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/8.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CategorySecondItemViewModel;

@interface CategoryRightRowCell : UITableViewCell

@property (nonatomic,readonly)RACSubject *gotoProductListSignal;

- (void)reloadDataWithViewModel:(CategorySecondItemViewModel *)viewModel;

@end
