//
//  LYRefreshHeader.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYRefreshHeader.h"

@implementation LYRefreshHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.stateLabel.font = [UIFont systemFontOfSize:SMALL_FONT_SIZE+1];
        self.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:SMALL_FONT_SIZE];
        self.stateLabel.textColor = [CommUtls colorWithHexString:@"#999999"];
        self.lastUpdatedTimeLabel.textColor = [CommUtls colorWithHexString:@"#999999"];
    }
    return self;
}

@end
