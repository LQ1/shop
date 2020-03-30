//
//  DLGuidPage.m
//  MobileClassPhone
//
//  Created by Bryce on 15/1/23.
//  Copyright (c) 2015年 CDEL. All rights reserved.
//

#import "DLGuidPage.h"

#define SC_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface DLGuidPage ()

@property (nonatomic, copy) NSString *topImageName;
@property (nonatomic, copy) NSString *bottomImageName;
@property (nonatomic, copy) NSString *backImageName;

@end

@implementation DLGuidPage

- (instancetype)initWithTopImageName:(NSString *)topImageName
                     bottomImageName:(NSString *)bottomImageName
                       backImageName:(NSString *)backImageName
{
    self = [super init];
    if (self) {
        self.clipsToBounds = YES;
        self.topImageName = topImageName;
        self.bottomImageName = bottomImageName;
        self.backImageName = backImageName;
        [self addViews];
    }
    return self;
}

- (void)addViews
{
    @weakify(self);
    // 背景
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.backImageName]];
    [self addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    // 底部图
    UIImageView *bottomView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.bottomImageName]];
    [bottomView sizeToFit];
    [self addSubview:bottomView];
    CGFloat bottomHeight = bottomView.frame.size.height;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(self);
    }];
    // 顶部图
    UIImageView *topView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.topImageName]];
    [topView sizeToFit];
    [self addSubview:topView];
    CGFloat topWidth = topView.frame.size.width;
    CGFloat topHeight = topView.frame.size.height;
    CGFloat topViewEadge = (SC_HEIGHT - bottomHeight - topHeight)/2;
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.mas_equalTo(topWidth);
        make.height.mas_equalTo(topHeight);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(topViewEadge);
    }];
}

@end
