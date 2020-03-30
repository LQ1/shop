//
//  ChoiceWareHouseItemViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/5/31.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "ChoiceWareHouseItemViewModel.h"

#import "ChoiceWareHouseItemModel.h"

@implementation ChoiceWareHouseItemViewModel

- (instancetype)initWithChoiceWareHouseItemModel:(ChoiceWareHouseItemModel *)model
{
    self = [super init];
    if (self) {
        self.model = model;
        
        self.itemName = model.name;
        self.wareHouseID = [NSString stringWithFormat:@"%ld",(long)model.storehouse_id];
        self.sellerPost = model.sellerPost;
    }
    return self;
}


@end
