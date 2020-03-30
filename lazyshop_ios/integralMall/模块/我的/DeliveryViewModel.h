//
//  DeliveryViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/12.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYBaseViewModel.h"

@interface DeliveryViewModel : LYBaseViewModel

- (instancetype)initWithDeliver_id:(NSString *)deliver_id
                       delivery_no:(NSString *)delivery_no;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
