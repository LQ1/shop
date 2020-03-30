//
//  DLShareBottomView.m
//  DLShareSDK
//
//  Created by LY on 16/7/6.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "DLShareBottomView.h"
#import <DLUtls/CommUtls.h>
// masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import <Masonry/Masonry.h>
// 布局
#define ITEM_EDGE ([UIScreen mainScreen].bounds.size.width - ITEM_COUNT*ITEM_WIDTH)/(ITEM_COUNT+1)
#define ITEM_COUNT 4
#define ITEM_WIDTH 50

@implementation DLShareBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
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
    __weak DLShareBottomView *selfView = self;
    
    // 分享视图载体
    UIView *sourceView = [UIView new];
    sourceView.backgroundColor = [UIColor whiteColor];
    [self addSubview:sourceView];
    [sourceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(188.0f);
    }];
    // 分享按钮图片
    NSString *qqImgUrl = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"DLShareSDK.bundle/%@",@"share_btn_qq@2x.png"]];
    NSString *qzoneImgUrl = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"DLShareSDK.bundle/%@",@"share_btn_qqkj@2x.png"]];
    NSString *fimgUrl = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"DLShareSDK.bundle/%@",@"share_btn_wx@2x.png"]];
    NSString *gimgUrl = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"DLShareSDK.bundle/%@",@"share_btn_pyq@2x.png"]];
    UIImage *qImg = [UIImage imageWithContentsOfFile:qqImgUrl];
    UIImage *qzoneImg = [UIImage imageWithContentsOfFile:qzoneImgUrl];
    UIImage *fimg = [UIImage imageWithContentsOfFile:fimgUrl];
    UIImage *gimg = [UIImage imageWithContentsOfFile:gimgUrl];
    
    // 微信好友
    UIButton *wxFriendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.wxFriendButton = wxFriendBtn;
    [wxFriendBtn setImage:fimg forState:UIControlStateNormal];
    [sourceView addSubview:wxFriendBtn];
    [wxFriendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(ITEM_WIDTH);
        make.left.mas_equalTo(ITEM_EDGE);
        make.top.mas_equalTo(30);
    }];
    UILabel *wxFriendLabel = [UILabel new];
    wxFriendLabel.text = @"微信好友";
    wxFriendLabel.textAlignment = NSTextAlignmentCenter;
    wxFriendLabel.font = [UIFont systemFontOfSize:12];
    [sourceView addSubview:wxFriendLabel];
    [wxFriendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(selfView.wxFriendButton.bottom).offset(15);
        make.left.right.mas_equalTo(selfView.wxFriendButton);
        make.height.mas_equalTo(15);
    }];
    
    // QQ
    UIButton *qqButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.qqButton = qqButton;
    [qqButton setImage:qImg forState:UIControlStateNormal];
    [sourceView addSubview:qqButton];
    [qqButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(ITEM_WIDTH);
        make.left.mas_equalTo(selfView.wxFriendButton.right).offset(ITEM_EDGE);
        make.top.equalTo(selfView.wxFriendButton);
    }];
    UILabel *qqLabel = [UILabel new];
    qqLabel.text = @"QQ好友";
    qqLabel.textAlignment = NSTextAlignmentCenter;
    qqLabel.font = [UIFont systemFontOfSize:12];
    [sourceView addSubview:qqLabel];
    [qqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(selfView.qqButton.bottom).offset(15);
        make.left.right.mas_equalTo(selfView.qqButton);
        make.height.mas_equalTo(12);
    }];
    
    // QQ空间
    UIButton *qzoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.qzoneButton = qzoneButton;
    [qzoneButton setImage:qzoneImg forState:UIControlStateNormal];
    [sourceView addSubview:qzoneButton];
    [qzoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(ITEM_WIDTH);
        make.left.mas_equalTo(selfView.qqButton.right).offset(ITEM_EDGE);
        make.top.equalTo(selfView.qqButton);
    }];
    UILabel *qzoneLabel = [UILabel new];
    qzoneLabel.text = @"QQ空间";
    qzoneLabel.textAlignment = NSTextAlignmentCenter;
    qzoneLabel.font = [UIFont systemFontOfSize:12];
    [sourceView addSubview:qzoneLabel];
    [qzoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(selfView.qzoneButton.bottom).offset(15);
        make.left.right.mas_equalTo(selfView.qzoneButton);
        make.height.mas_equalTo(15);
    }];
    
    // 微信朋友圈
    UIButton *wxGroupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.wxGroupButton = wxGroupBtn;
    [wxGroupBtn setImage:gimg forState:UIControlStateNormal];
    [sourceView addSubview:wxGroupBtn];
    [wxGroupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(ITEM_WIDTH);
        make.left.mas_equalTo(selfView.qzoneButton.right).offset(ITEM_EDGE);
        make.top.equalTo(selfView.qzoneButton);
    }];
    UILabel *wxGroupLabel = [UILabel new];
    wxGroupLabel.text = @"朋友圈";
    wxGroupLabel.textAlignment = NSTextAlignmentCenter;
    wxGroupLabel.font = [UIFont systemFontOfSize:12];
    [sourceView addSubview:wxGroupLabel];
    [wxGroupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(selfView.wxGroupButton.bottom).offset(15);
        make.left.right.mas_equalTo(selfView.wxGroupButton);
        make.height.mas_equalTo(15);
    }];
    
    // 分割线
    UIColor *color = [UIColor colorWithRed:204./255. green:204./255. blue:204./255. alpha:1.];
    CGFloat lineHeight = 1.0 / [UIScreen mainScreen].scale;
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = color;
    [sourceView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(wxGroupLabel.bottom).offset(30);
        make.height.equalTo(lineHeight);
    }];
    // 取消
    UILabel *cancelLabel = [UILabel new];
    cancelLabel.text = @"取消";
    cancelLabel.textAlignment = NSTextAlignmentCenter;
    cancelLabel.font = [UIFont boldSystemFontOfSize:16];
    cancelLabel.textColor = [CommUtls colorWithHexString:@"#0099ff"];
    [sourceView addSubview:cancelLabel];
    [cancelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(36);
        make.centerX.mas_equalTo(selfView);
        make.top.mas_equalTo(line.bottom).offset(16);
    }];
}

@end
