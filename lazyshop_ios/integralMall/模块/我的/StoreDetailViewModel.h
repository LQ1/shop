//
//  StoreDetailViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/9.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

@interface StoreDetailViewModel : LYBaseViewModel

- (instancetype)initWithStoreID:(NSString *)storeID
                   shop_user_id:(NSString *)shop_user_id;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
