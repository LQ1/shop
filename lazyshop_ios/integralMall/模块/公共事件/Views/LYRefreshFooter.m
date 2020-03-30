//
//  LYRefreshFooter.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYRefreshFooter.h"

@implementation LYRefreshFooter

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.stateLabel.font = [UIFont systemFontOfSize:SMALL_FONT_SIZE+1];
        self.stateLabel.textColor = [CommUtls colorWithHexString:@"#999999"];
    }
    return self;
}

@end
