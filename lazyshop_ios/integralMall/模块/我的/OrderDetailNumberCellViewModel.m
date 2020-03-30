//
//  ComfirmDetailNumberCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailNumberCellViewModel.h"

#import "OrderDetailModel.h"

#import "OrderDetailNumberCell.h"

@implementation OrderDetailNumberCellViewModel

- (instancetype)initWithModel:(OrderDetailModel *)model
{
    self = [super init];
    if (self) {
        self.order_no = model.order_no;
        self.created_at = model.created_at;
        self.UIClassName = NSStringFromClass([OrderDetailNumberCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = 55;
    }
    return self;
}

@end
