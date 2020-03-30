//
//  LYSloganView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/23.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYSloganView.h"

@interface LYSloganView()

@property (nonatomic, strong) UILabel *sloganLabel;

@end

@implementation LYSloganView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layer.borderColor = [CommUtls colorWithHexString:APP_MainColor].CGColor;
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        self.sloganLabel = [self addLabelWithFontSize:MIN_FONT_SIZE
                                        textAlignment:NSTextAlignmentCenter
                                            textColor:APP_MainColor
                                         adjustsWidth:NO
                                         cornerRadius:0
                                                 text:nil];
        [self.sloganLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(3);
            make.right.bottom.mas_equalTo(-3);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    self.sloganLabel.text = title;
    if (title.length&&[LYAppCheckManager shareInstance].isAppAgree) {
        self.hidden = NO;
    }else{
        self.hidden = YES;
    }
}

@end
