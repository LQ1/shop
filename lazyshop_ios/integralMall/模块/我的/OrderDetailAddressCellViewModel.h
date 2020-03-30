//
//  ConfirmDetailAddressCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@class OrderDetailModel;

@interface OrderDetailAddressCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *receiver;
@property (nonatomic,copy) NSString *receiver_mobile;
@property (nonatomic,copy) NSString *receiver_address_detail;
@property (nonatomic,assign) BOOL showWholePhoneNumber;

- (instancetype)initWithModel:(OrderDetailModel *)model;

@end
