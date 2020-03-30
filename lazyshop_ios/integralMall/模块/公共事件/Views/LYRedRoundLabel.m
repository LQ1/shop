//
//  LYRedRoundLabel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYRedRoundLabel.h"

@implementation LYRedRoundLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.font = [UIFont systemFontOfSize:MIN_FONT_SIZE];
        self.textColor = [UIColor whiteColor];
        self.backgroundColor = [CommUtls colorWithHexString:@"#e33a3c"];
        self.layer.cornerRadius = LYRedRoundLabelHeight/2.0;
        self.layer.masksToBounds = YES;
        self.textAlignment = NSTextAlignmentCenter;
        self.adjustsFontSizeToFitWidth = YES;
    }
    return self;
}

@end
