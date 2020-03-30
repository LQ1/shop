//
//  ConfirmDetailAddressCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailAddressCellViewModel.h"

#import "OrderDetailModel.h"
#import "OrderDetailAddressCell.h"

@implementation OrderDetailAddressCellViewModel

- (instancetype)initWithModel:(OrderDetailModel *)model

{
    self = [super init];
    if (self) {
        if (model.storehouse_id>1) {
            // 门店自取
            self.receiver = model.storehouse_name;
            self.receiver_mobile = model.storehouse_mobile;
            self.receiver_address_detail = model.storehouse_address;
            self.showWholePhoneNumber = YES;
        }else{
            // 线上配送
            self.receiver = model.receiver;
            self.receiver_mobile = model.receiver_mobile;
            self.receiver_address_detail = model.receiver_address_detail;
        }
        self.UIClassName = NSStringFromClass([OrderDetailAddressCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = 85.;
    }
    return self;
}

@end
