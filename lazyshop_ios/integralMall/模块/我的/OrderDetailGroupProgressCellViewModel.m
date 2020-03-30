//
//  OrderDetailGroupProgressCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/8.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailGroupProgressCellViewModel.h"

#import "OrderDetailModel.h"
#import "OrderDetailGroupProgressCell.h"

@implementation OrderDetailGroupProgressCellViewModel

- (instancetype)initWithModel:(OrderDetailModel *)model
{
    self = [super init];
    if (self) {
        self.group_url = model.group_url;
        self.UIClassName = NSStringFromClass([OrderDetailGroupProgressCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = 44;
    }
    return self;
}

@end
