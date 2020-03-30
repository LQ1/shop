//
//  MyBargainSecFooterView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MyBargainSecFooterView.h"

#import "LYTextColorButton.h"
#import "LYMainColorButton.h"
#import "MyBargainItemViewModel.h"

@interface MyBargainSecFooterView()

@property (nonatomic,strong)UILabel *bargainPriceLabel;

@end

@implementation MyBargainSecFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _clickSignal = [[RACSubject subject] setNameWithFormat:@"%@ clickSignal", self.class];
        [self addViews];
    }
    return self;
}

- (void)addViews
{
    UIView *topContentView = [UIView new];
    topContentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:topContentView];
    [topContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(MyBargainSecFooterViewHeight/2.);
    }];
    [topContentView addBottomLine];
    // 已砍价
    UILabel *totalPriceTipLabel = [topContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                         textAlignment:NSTextAlignmentCenter
                                                             textColor:@"#333333"
                                                          adjustsWidth:NO
                                                          cornerRadius:0
                                                                  text:@"已砍价:"];
    [totalPriceTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topContentView.centerX).offset(-20);
        make.centerY.mas_equalTo(topContentView);
        make.width.mas_equalTo(MIDDLE_FONT_SIZE*4);
    }];
    // 砍价金额
    self.bargainPriceLabel = [topContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                  textAlignment:0
                                                      textColor:nil
                                                   adjustsWidth:NO
                                                   cornerRadius:0
                                                           text:nil];
    [self.bargainPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(totalPriceTipLabel.right);
        make.centerY.mas_equalTo(totalPriceTipLabel);
    }];
    
    // 底
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(topContentView.bottom);
    }];
    
    LYMainColorButton *buyBtn = [[LYMainColorButton alloc] initWithTitle:@"立即购买"
                                                          buttonFontSize:SMALL_FONT_SIZE
                                                            cornerRadius:3];
    [bottomView addSubview:buyBtn];
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(bottomView);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(30);
    }];
    @weakify(self);
    buyBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.clickSignal sendNext:@(MyBargainSecFooterViewClickType_ImediatelyBuy)];
        return [RACSignal empty];
    }];
    
    LYTextColorButton *reviteFriendsBtn = [[LYTextColorButton alloc] initWithTitle:@"邀好友帮忙砍价"
                                                                    buttonFontSize:SMALL_FONT_SIZE
                                                                      cornerRadius:3];
    [self.contentView addSubview:reviteFriendsBtn];
    [reviteFriendsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(buyBtn.left).offset(-7.5);
        make.centerY.mas_equalTo(buyBtn);
        make.height.mas_equalTo(buyBtn);
        make.width.mas_equalTo(100);
    }];
    reviteFriendsBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.clickSignal sendNext:@(MyBargainSecFooterViewClickType_InviteFriends)];
        return [RACSignal empty];
    }];
}

#pragma mark -bind
- (void)bindViewModel:(MyBargainItemViewModel *)vm
{
    // 已砍价
    NSString *totalMoeny = [NSString stringWithFormat:@"¥%@",vm.bargain_price];
    
    NSString *postage = @"";
    NSString *allMoney = [totalMoeny stringByAppendingString:postage];
    self.bargainPriceLabel.attributedText = [CommUtls changeText:postage
                                                       content:allMoney
                                                changeTextFont:[UIFont systemFontOfSize:SMALL_FONT_SIZE]
                                                      textFont:[UIFont systemFontOfSize:MIDDLE_FONT_SIZE]
                                               changeTextColor:[CommUtls colorWithHexString:@"#5b5b5b"]
                                                     textColor:[CommUtls colorWithHexString:APP_MainColor]];
}

@end
