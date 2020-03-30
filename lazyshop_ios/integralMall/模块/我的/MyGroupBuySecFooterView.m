//
//  MyGroupBuySecFooterView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MyGroupBuySecFooterView.h"

#import "LYMainColorButton.h"

#import "MyBargainItemViewModel.h"

@interface MyGroupBuySecFooterView()

@property (nonatomic,strong)UILabel *totalCountLabel;
@property (nonatomic,strong)UILabel *totalPriceLabel;

@end

@implementation MyGroupBuySecFooterView

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
        make.height.mas_equalTo(MyGroupBuySecFooterViewHeight/2.);
    }];
    [topContentView addBottomLine];
    // 总金额
    UILabel *totalPriceTipLabel = [topContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                         textAlignment:NSTextAlignmentCenter
                                                             textColor:@"#333333"
                                                          adjustsWidth:NO
                                                          cornerRadius:0
                                                                  text:@"总金额:"];
    [totalPriceTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topContentView.centerX).offset(-20);
        make.centerY.mas_equalTo(topContentView);
        make.width.mas_equalTo(MIDDLE_FONT_SIZE*4);
    }];
    // 具体金额
    self.totalPriceLabel = [topContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                  textAlignment:0
                                                      textColor:nil
                                                   adjustsWidth:NO
                                                   cornerRadius:0
                                                           text:nil];
    [self.totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(totalPriceTipLabel.right);
        make.centerY.mas_equalTo(totalPriceTipLabel);
    }];
    // 共多少件商品
    self.totalCountLabel = [topContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                  textAlignment:NSTextAlignmentRight
                                                      textColor:@"#333333"
                                                   adjustsWidth:NO
                                                   cornerRadius:0
                                                           text:nil];
    [self.totalCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(totalPriceTipLabel.left).offset(-20);
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
    
    LYMainColorButton *buyBtn = [[LYMainColorButton alloc] initWithTitle:@"邀请好友拼团"
                                                          buttonFontSize:SMALL_FONT_SIZE
                                                            cornerRadius:3];
    [bottomView addSubview:buyBtn];
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(bottomView);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    @weakify(self);
    buyBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.clickSignal sendNext:nil];
        return [RACSignal empty];
    }];
}

#pragma mark -bind
- (void)bindViewModel:(MyBargainItemViewModel *)vm
{
    // 总个数
    self.totalCountLabel.text = [NSString stringWithFormat:@"共%@件商品",vm.quantity];
    // 总金额
    NSString *totalMoeny = [NSString stringWithFormat:@"¥%@",vm.pay_total_price];
    
    NSString *postage = @"";
    if (vm.delivery_price.length) {
        postage = [NSString stringWithFormat:@"(含运费¥%@)",vm.delivery_price];
    }
    NSString *allMoney = [totalMoeny stringByAppendingString:postage];
    self.totalPriceLabel.attributedText = [CommUtls changeText:postage
                                                       content:allMoney
                                                changeTextFont:[UIFont systemFontOfSize:SMALL_FONT_SIZE]
                                                      textFont:[UIFont systemFontOfSize:MIDDLE_FONT_SIZE]
                                               changeTextColor:[CommUtls colorWithHexString:@"#5b5b5b"]
                                                     textColor:[CommUtls colorWithHexString:APP_MainColor]];
}

@end
