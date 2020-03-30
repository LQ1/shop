//
//  OrderDetailGroupProgressCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/8.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailGroupProgressCell.h"

#import "LYTextColorButton.h"
#import "OrderDetailGroupProgressCellViewModel.h"

#import "GroupBuyProgressViewController.h"

@interface OrderDetailGroupProgressCell()

@property (nonatomic,strong)OrderDetailGroupProgressCellViewModel *viewModel;

@end

@implementation OrderDetailGroupProgressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    LYTextColorButton *refoundBtn = [[LYTextColorButton alloc] initWithTitle:@"查看拼单进度"
                                                              buttonFontSize:MIDDLE_FONT_SIZE
                                                                cornerRadius:3];
    [self.contentView addSubview:refoundBtn];
    [refoundBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(30);
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(-15);
    }];
    @weakify(self);
    refoundBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self gotoProgressWebView];
        return [RACSignal empty];
    }];
    
    [self.contentView addBottomLine];
}

// 查看拼团进度
- (void)gotoProgressWebView
{
    UINavigationController *navigationController = [PublicEventManager fetchPushNavigationController:nil];
    GroupBuyProgressViewController *webVC = [GroupBuyProgressViewController new];
    webVC.urlString = self.viewModel.group_url;
    webVC.hidesBottomBarWhenPushed = YES;
    @weakify(self);
    webVC.inviteFriendsBlock = ^{
        @strongify(self);
        // 邀请好友拼团
        [self.baseClickSignal sendNext:nil];
    };
    [navigationController pushViewController:webVC animated:YES];
}

#pragma mark -bind
- (void)bindViewModel:(OrderDetailGroupProgressCellViewModel *)vm
{
    self.viewModel = vm;
}

@end
