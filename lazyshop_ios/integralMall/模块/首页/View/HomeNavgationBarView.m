//
//  HomeNavgationBarView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/5.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeNavgationBarView.h"

#import "ProductSearchNavView.h"
#import "ScanViewController.h"

@implementation HomeNavgationBarView

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
    // 背景
    self.backgroundColor = [CommUtls colorWithHexString:APP_MainColor];
    // logo
    UIImageView *logoView = [self addImageViewWithImageName:@"logo"
                                               cornerRadius:0];
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.centerX.mas_equalTo(self.left).offset(30);
    }];
    // 扫一扫
    UIButton *scanBtn = [UIButton new];
    [scanBtn setImage:[UIImage imageNamed:@"扫一扫"]
             forState:UIControlStateNormal];
    [self addSubview:scanBtn];
    [scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(logoView.right).offset(5);
        make.centerY.mas_equalTo(logoView);
    }];
    @weakify(self);
    scanBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self gotoScanVC];
        return [RACSignal empty];
    }];
    // 搜索框
    ProductSearchNavView *searchView = [[ProductSearchNavView alloc] initWithInputEnabled:NO tipTitle:@"爆款商品随便搜" ProductSearchFrom:ProductSearchFrom_HomePage searchTitleBackBlock:nil];
    [self addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scanBtn.right).offset(3);
        make.right.mas_equalTo(-48);
        make.height.mas_equalTo(33);
        make.centerY.mas_equalTo(self);
    }];
    
    // 消息
    UIButton *msgBtn = [[PublicEventManager shareInstance] fetchMessageButtonWithNavigationController:nil];
    [self addSubview:msgBtn];
    [msgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(40);
        make.centerY.mas_equalTo(self);
        make.centerX.mas_equalTo(self.right).offset(-24);
    }];
}

#pragma mark -GoTo
- (void)gotoScanVC
{
    ScanViewController *vc = [ScanViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [[PublicEventManager fetchPushNavigationController:nil] pushViewController:vc
                                                                      animated:YES];
}

@end
