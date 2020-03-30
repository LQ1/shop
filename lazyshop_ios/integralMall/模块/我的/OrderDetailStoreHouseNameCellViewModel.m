//
//  OrderDetailStoreHouseNameCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/13.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailStoreHouseNameCellViewModel.h"

#import "OrderDetailModel.h"
#import "OrderDetailStoreHourseNameCell.h"

@implementation OrderDetailStoreHouseNameCellViewModel

- (instancetype)initWithModel:(OrderDetailModel *)model

{
    self = [super init];
    if (self) {
        self.storehouse_name = model.storehouse_name;
        self.UIClassName = NSStringFromClass([OrderDetailStoreHourseNameCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = 44.;
    }
    return self;
}

@end
