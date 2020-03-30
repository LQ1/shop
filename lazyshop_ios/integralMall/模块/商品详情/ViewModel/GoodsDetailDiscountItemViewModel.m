//
//  GoodsDetailDiscountItemViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailDiscountItemViewModel.h"

#import "GoodsDetailCouponUseCell.h"
#import "GoodsDetailDoubleTextCell.h"

@implementation GoodsDetailDiscountItemViewModel

- (instancetype)initWithGoodsDetailDiscountType:(GoodsDetailDiscountType)discountType
                                         detail:(NSString *)detail
{
    self = [super init];
    if (self) {
        self.discountType = discountType;
        switch (self.discountType) {
            case GoodsDetailDiscountType_Coupon:
            {
                self.title = @"领券";
                self.UIClassName = NSStringFromClass([GoodsDetailCouponUseCell class]);
                self.UIReuseID = self.UIClassName;
                self.UIHeight = 45.0f;
            }
                break;
            case GoodsDetailDiscountType_Integral:
            {
                self.title = @"积分";
                self.UIClassName = NSStringFromClass([GoodsDetailDoubleTextCell class]);
                self.UIReuseID = self.UIClassName;
                self.UIHeight = 24+[CommUtls getContentSize:detail
                                                       font:[UIFont systemFontOfSize:MIDDLE_FONT_SIZE]
                                                       size:CGSizeMake(KScreenWidth-70, CGFLOAT_MAX)].height;
            }
                break;
            case GoodsDetailDiscountType_CashBack:
            {
                self.title = @"返现";
                self.UIClassName = NSStringFromClass([GoodsDetailDoubleTextCell class]);
                self.UIReuseID = self.UIClassName;
                self.UIHeight = 24+[CommUtls getContentSize:detail
                                                       font:[UIFont systemFontOfSize:MIDDLE_FONT_SIZE]
                                                       size:CGSizeMake(KScreenWidth-70, CGFLOAT_MAX)].height;
            }
                break;
                
            default:
                break;
        }
        self.detail = detail;
    }
    return self;
}


@end
