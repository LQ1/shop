//
//  LazyShopShareView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/29.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LazyShopShareView.h"

@interface LazyShopShareView()

@property (nonatomic,strong)NSString *title;

@end

@implementation LazyShopShareView

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.title = title;
        [self addViews];
    }
    return self;
}

#pragma mark -添加布局

- (void)addViews
{
    // 视图出现位置
    self.appearDirection = animateDirectionFromBottom;
    // 背景
    self.backgroundColor = [UIColor clearColor];
    @weakify(self);
    // 分享视图载体
    UIImageView *sourceView = [self addImageViewWithImageName:@"分享到微信朋友圈"
                                                 cornerRadius:5];
    [sourceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(147.);
        make.width.mas_equalTo(270.);
        make.center.mas_equalTo(self);
    }];
    sourceView.userInteractionEnabled = YES;
    
    // 微信好友
    UIButton *wxFriendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.wxFriendButton = wxFriendBtn;
    [sourceView addSubview:wxFriendBtn];
    [wxFriendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(70);
        make.centerY.mas_equalTo(sourceView);
        make.right.mas_equalTo(sourceView.centerX).offset(-15);
    }];
    UILabel *wxFriendLabel = [UILabel new];
    wxFriendLabel.text = @"微信";
    wxFriendLabel.textAlignment = NSTextAlignmentCenter;
    wxFriendLabel.font = [UIFont systemFontOfSize:LARGE_FONT_SIZE];
    [sourceView addSubview:wxFriendLabel];
    [wxFriendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.mas_equalTo(self.wxFriendButton.bottom).offset(5);
        make.left.mas_equalTo(self.wxFriendButton).offset(-10);
        make.right.mas_equalTo(self.wxFriendButton).offset(10);
    }];
    
    // 微信朋友圈
    UIButton *wxGroupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.wxGroupButton = wxGroupBtn;
    [sourceView addSubview:wxGroupBtn];
    [wxGroupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.height.mas_equalTo(self.wxFriendButton);
        make.left.mas_equalTo(self.centerX).offset(15);
        make.centerY.equalTo(self.wxFriendButton);
    }];
    UILabel *wxGroupLabel = [UILabel new];
    wxGroupLabel.text = @"微信朋友圈";
    wxGroupLabel.textAlignment = NSTextAlignmentCenter;
    wxGroupLabel.font = [UIFont systemFontOfSize:LARGE_FONT_SIZE];
    [sourceView addSubview:wxGroupLabel];
    [wxGroupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.mas_equalTo(self.wxGroupButton.bottom).offset(5);
        make.left.mas_equalTo(self.wxGroupButton).offset(-10);
        make.right.mas_equalTo(self.wxGroupButton).offset(10);
    }];
    
    // 邀请朋友来
    UILabel *titleLabel = [sourceView addLabelWithFontSize:LARGE_FONT_SIZE
                                       textAlignment:NSTextAlignmentCenter
                                           textColor:@"#000000"
                                        adjustsWidth:NO
                                        cornerRadius:0
                                                text:self.title];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.centerX.mas_equalTo(sourceView);
    }];
}

@end
