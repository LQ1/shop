//
//  LYItemUISectionBaseView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUISectionBaseView.h"

@implementation LYItemUISectionBaseView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _baseClickSignal = [[RACSubject subject] setNameWithFormat:@"%@ baseClickSignal", self.class];
    }
    return self;
}

- (void)bindViewModel:(id)vm
{

}

@end
