//
//  LYTextView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYTextView.h"

@interface LYTextView()

@property (nonatomic,strong)UILabel *placeHolderLabel;

@end

@implementation LYTextView

- (instancetype)initWithPlaceHolder:(NSString *)placeHolder
{
    self = [super init];
    if (self) {
        self.font = [UIFont systemFontOfSize:MIDDLE_FONT_SIZE];
        self.placeHolderLabel = [self addLabelWithFontSize:MIDDLE_FONT_SIZE
                                             textAlignment:0
                                                 textColor:@"#d6d6d6"
                                              adjustsWidth:NO
                                              cornerRadius:0
                                                      text:placeHolder];
        [self.placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(6);
            make.left.mas_equalTo(5);
            make.right.equalTo(-10);
            make.height.equalTo(20);
        }];
    }
    return self;
}

- (void)checkPlaceHolder
{
    if (self.text.length) {
        self.placeHolderLabel.hidden = YES;
    }else {
        self.placeHolderLabel.hidden = NO;
    }
}

@end
