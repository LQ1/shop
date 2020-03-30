//
//  PaymentItemCellViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/30.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface PaymentItemCellViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy) NSString *paymentImageName;
@property (nonatomic,copy) NSString *paymentTitle;
@property (nonatomic,copy) NSString *paymentDesc;
@property (nonatomic,assign) BOOL selected;
@property (nonatomic,assign) PayMentType payMentType;

@end
