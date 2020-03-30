//
//  SettingItemPhoneView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/4.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SettingItemPhoneView.h"

@implementation SettingItemPhoneView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.titleLabel.text = @"手机号";
    self.rightArrowView.hidden = YES;
    UILabel *phonenumLabel = [self addLabelWithFontSize:SMALL_FONT_SIZE
                                          textAlignment:NSTextAlignmentRight
                                              textColor:@"#666666"
                                           adjustsWidth:NO
                                           cornerRadius:0
                                                   text:nil];
    [phonenumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self);
    }];
    
    RAC(phonenumLabel,text) = RACObserve(SignInUser, mobilePhone);
    
    [self addBottomLine];
}

@end
