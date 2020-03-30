//
//  ProductRowBaseCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/23.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface ProductRowBaseCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *productID;
@property (nonatomic,copy) NSString *productImageUrl;
@property (nonatomic,copy) NSString *productName;
@property (nonatomic,copy) NSString *productPrice;
@property (nonatomic,copy) NSString *slogan;

@end
