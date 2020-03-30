//
//  StoreToRelateViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/9.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

@class StoreListItemViewModel;

typedef NS_ENUM(NSInteger,StoreToRelateViewModel_Signal_Type)
{
    StoreToRelateViewModel_Signal_Type_RelateSuccess = 0
};

@interface StoreToRelateViewModel : LYBaseViewModel

@property (nonatomic,readonly)StoreListItemViewModel *itemViewModel;

- (instancetype)initWithStoreID:(NSString *)storeID;

- (void)relate;

@end
