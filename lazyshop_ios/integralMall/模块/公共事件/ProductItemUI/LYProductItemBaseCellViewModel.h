//
//  LYProductItemBaseCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/28.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface LYProductItemBaseCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *productID;
@property (nonatomic,copy) NSString *productName;
@property (nonatomic,copy) NSString *productImgUrl;
@property (nonatomic,copy) NSString *productSkuString;
@property (nonatomic,copy) NSString *productPrice;
@property (nonatomic,copy) NSString *goods_sku_id;

@end
