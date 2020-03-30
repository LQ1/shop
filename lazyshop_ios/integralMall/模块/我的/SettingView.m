//
//  SettingView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/4.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SettingView.h"

#import "SettingViewModel.h"

#import "SettingItemPhoneView.h"
#import "SettingItemModifyPwdView.h"
#import "SettingItemLawView.h"
#import "SettingItemFeedBackView.h"
#import "SettingItemAboutView.h"

#import "LYMainColorButton.h"

@interface SettingView()

@property (nonatomic,strong)SettingViewModel *viewModel;

@end

@implementation SettingView

- (instancetype)initWithViewModel:(SettingViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    // 列表
    SettingItemPhoneView *phoneView = [SettingItemPhoneView new];
    [self addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(SettingViewItemBaseViewHeight);
        make.top.mas_equalTo(5);
    }];
    
    SettingItemModifyPwdView *modifyPwdView = [SettingItemModifyPwdView new];
    [self addSubview:modifyPwdView];
    [modifyPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(SettingViewItemBaseViewHeight);
        make.top.mas_equalTo(phoneView.bottom);
    }];
    @weakify(self);
    [modifyPwdView.clickSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel gotoModifyPassword];
    }];

    SettingItemLawView *lawView = [SettingItemLawView new];
    [self addSubview:lawView];
    [lawView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(SettingViewItemBaseViewHeight);
        make.top.mas_equalTo(modifyPwdView.bottom).offset(10);
    }];
    [lawView.clickSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel gotoLaw];
    }];
    
    SettingItemFeedBackView *backView = [SettingItemFeedBackView new];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(SettingViewItemBaseViewHeight);
        make.top.mas_equalTo(lawView.bottom);
    }];
    [backView.clickSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel gotoFeedBack];
    }];

    SettingItemAboutView *aboutView = [SettingItemAboutView new];
    [self addSubview:aboutView];
    [aboutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(SettingViewItemBaseViewHeight);
        make.top.mas_equalTo(backView.bottom);
    }];
    [aboutView.clickSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel gotoAboutUs];
    }];

    // 尾视图
    LYMainColorButton *logOutButton = [[LYMainColorButton alloc] initWithTitle:@"退出当前账户"
                                                                buttonFontSize:MIDDLE_FONT_SIZE
                                                                  cornerRadius:3];
    [self addSubview:logOutButton];
    [logOutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(aboutView.bottom).offset(50);
    }];
    logOutButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.viewModel logOut];
        return [RACSignal empty];
    }];
}

@end
