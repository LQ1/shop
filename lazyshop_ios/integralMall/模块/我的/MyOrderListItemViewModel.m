//
//  MyOrderListItemViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/7.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MyOrderListItemViewModel.h"

#import "MyOrdersSectionFooter.h"
#import "MyOrderlistProductViewModel.h"

@implementation MyOrderListItemViewModel

- (instancetype)initWithModel:(MyOrderModel *)model
{
    self = [super init];
    if (self) {
        self.model = model;
        self.UIClassName = NSStringFromClass([MyOrdersSectionFooter class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = MyOrdersSectionFooterHeight;
        NSMutableArray *resultArray = [NSMutableArray array];
        [model.order_detail enumerateObjectsUsingBlock:^(MyOrderItemModel *itemModel, NSUInteger idx, BOOL * _Nonnull stop) {
            MyOrderlistProductViewModel *itemVM = [[MyOrderlistProductViewModel alloc] initWithModel:itemModel];
            [resultArray addObject:itemVM];
        }];
        self.childViewModels = [NSArray arrayWithArray:resultArray];
    }
    return self;
}

@end
