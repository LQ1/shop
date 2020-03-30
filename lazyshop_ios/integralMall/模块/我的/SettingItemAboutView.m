//
//  SettingItemAboutView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/4.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SettingItemAboutView.h"

@implementation SettingItemAboutView

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
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];

    self.titleLabel.text = [NSString stringWithFormat:@"关于%@",[infoDict objectForKey:@"CFBundleDisplayName"]];

    NSString *app_Version = [infoDict objectForKey:@"CFBundleShortVersionString"];

    UILabel *versionLabel = [self addLabelWithFontSize:SMALL_FONT_SIZE
                                         textAlignment:NSTextAlignmentRight
                                             textColor:@"#666666"
                                          adjustsWidth:NO
                                          cornerRadius:0
                                                   text:[NSString stringWithFormat:@"V%@",app_Version]];
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.rightArrowView.left).offset(-12.5);
        make.centerY.mas_equalTo(self);
    }];
}


@end
