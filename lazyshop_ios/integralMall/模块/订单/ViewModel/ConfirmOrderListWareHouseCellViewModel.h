//
//  ConfirmOrderListWareHouseCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/3.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface ConfirmOrderListWareHouseCellViewModel : LYItemUIBaseViewModel

@property (nonatomic, copy) NSString *wareHouseName;
@property (nonatomic, copy) NSString *wareHouseID;
@property (nonatomic, assign) BOOL sellerPost;

@end
