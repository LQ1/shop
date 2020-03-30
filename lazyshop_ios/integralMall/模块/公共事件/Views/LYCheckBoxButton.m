//
//  LYCheckBoxButton.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYCheckBoxButton.h"

@implementation LYCheckBoxButton

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, LYCheckBoxButtonWidth, LYCheckBoxButtonWidth)
                  checkImgeWith:[UIImage imageNamed:@"选择收货地址未选中"]
                checkedImgeWith:[UIImage imageNamed:@"默认地址选中"]
              selectCheckedWith:NO];
    if (self) {
        
    }
    return self;
}

@end
