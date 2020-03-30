//
//  StoreListItemViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/9.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface StoreListItemViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *user_shop_id;
@property (nonatomic,copy) NSString *storeID;
@property (nonatomic,copy) NSString *storeImgUrl;
@property (nonatomic,copy) NSString *storeName;
@property (nonatomic,copy) NSString *storeCategoryName;
@property (nonatomic,assign) BOOL hideRightArrow;

@end
