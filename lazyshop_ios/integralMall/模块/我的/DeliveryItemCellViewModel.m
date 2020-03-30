//
//  DeliveryItemCellViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/12.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "DeliveryItemCellViewModel.h"

#import "DeliveryItemCell.h"

@implementation DeliveryItemCellViewModel

- (instancetype)initWithAccept_station:(NSString *)accept_station
                                remark:(NSString *)remark
                           accept_time:(NSString *)accept_time
{
    self = [super init];
    if (self) {
        self.accept_station = accept_station;
        if (remark.length) {
            self.remark = [NSString stringWithFormat:@"(备注:%@)",remark];
        }else{
            self.remark = @"";
        }
        self.accept_time = accept_time;
        self.UIClassName = NSStringFromClass([DeliveryItemCell class]);
        self.UIReuseID = self.UIClassName;
        self.UIHeight = DeliveryItemCellBaseHeight+[CommUtls getContentSize:[self.accept_station stringByAppendingString:self.remark]
                                                                       font:[UIFont systemFontOfSize:SMALL_FONT_SIZE]
                                                                       size:CGSizeMake(KScreenWidth-30, CGFLOAT_MAX)].height;
    }
    return self;
}

@end
