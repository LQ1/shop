//
//  SelectStoreViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

@interface SelectStoreViewModel : LYBaseViewModel

@property (nonatomic,readonly) RACSubject *showToScanSignal;
@property (nonatomic,readonly) RACSubject *bindShopSuccessSignal;

- (instancetype)initWithOrder_detail_id:(NSString *)orderDetailID;

- (NSInteger)numberOfSections;
- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)bindSelectShop;

@end
