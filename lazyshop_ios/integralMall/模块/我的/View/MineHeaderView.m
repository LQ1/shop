//
//  MineHeaderView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MineHeaderView.h"

#import "LYUpImgDownTxtView.h"

#import "MineViewModel.h"

@interface MineHeaderView()

@property (nonatomic,strong)MineViewModel *viewModel;

@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UIImageView *headerImgView;
@property (nonatomic,strong)UILabel *nickNameLabel;

@property (nonatomic,strong)UIImageView *scoreContentView;
@property (nonatomic,strong)UILabel *scoreMsgLabel;
@property (nonatomic,strong)UIImageView *vipContentView;
@property (nonatomic,strong)UIImageView *vipMsgView;
@property (nonatomic,strong)UILabel *vipMsgLabel;

@property (nonatomic,strong)UILabel *couponNumberLabel;

@end

@implementation MineHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.contentView = [UIView new];
    self.contentView.backgroundColor = [CommUtls colorWithHexString:APP_MainColor];
    self.contentView.layer.cornerRadius = 5;
    self.contentView.layer.masksToBounds = YES;
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(0);
    }];
    
    // 头像
    CGFloat headerImgViewWith = 58.0f;
    self.headerImgView = [self.contentView addImageViewWithImageName:nil
                                                        cornerRadius:headerImgViewWith/2];
    [self.headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(headerImgViewWith);
        make.left.top.mas_equalTo(10);
    }];
    // 用户名
    self.nickNameLabel = [self.contentView addLabelWithFontSize:LARGE_FONT_SIZE
                                                  textAlignment:0
                                                      textColor:@"#ffffff"
                                                   adjustsWidth:NO
                                                   cornerRadius:0
                                                           text:nil];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImgView.right).offset(7.5);
        make.centerY.mas_equalTo(self.headerImgView);
    }];
    // 点击事件
    UIButton *clickBtn = [UIButton new];
    [self.contentView addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self.headerImgView);
        make.right.mas_equalTo(self.nickNameLabel);
    }];
    @weakify(self);
    clickBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self headerClick];
        return [RACSignal empty];
    }];
    
    UIImage *roundBackImg = [UIImage imageNamed:@"积分展示圆角矩形"];
    CGFloat roundBackImgWidth = roundBackImg.size.width;
    CGFloat roundBackImgHeight = roundBackImg.size.height;
    // 积分信息
    UIImageView *scoreContentView = [self.contentView addImageViewWithImageName:@"积分展示圆角矩形"
                                                                   cornerRadius:0];
    self.scoreContentView = scoreContentView;
    [self.contentView addSubview:scoreContentView];
    [scoreContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerImgView.top);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(roundBackImgWidth);
        make.height.mas_equalTo(roundBackImgHeight);
    }];
    
    // scoreMsgLabel
    self.scoreMsgLabel = [self.scoreContentView addLabelWithFontSize:MIN_FONT_SIZE
                                                       textAlignment:NSTextAlignmentRight
                                                           textColor:APP_MainColor
                                                        adjustsWidth:YES
                                                        cornerRadius:0
                                                                text:nil];
    [self.scoreMsgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(3);
        make.centerY.mas_equalTo(self.scoreContentView);
        make.right.mas_equalTo(0);
    }];

    
    // 会员信息
    UIImageView *vipContentView = [self.contentView addImageViewWithImageName:@"积分展示圆角矩形"
                                                                 cornerRadius:0];
    self.vipContentView = vipContentView;
    [self.contentView addSubview:vipContentView];
    [vipContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scoreContentView.bottom).offset(5);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(roundBackImgWidth);
        make.height.mas_equalTo(roundBackImgHeight);
    }];
    
    // vipMsgView
    self.vipMsgView = [self.vipContentView addImageViewWithImageName:nil
                                                        cornerRadius:0];
    [self.vipMsgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.width.mas_equalTo(19);
        make.height.mas_equalTo(18);
        make.centerY.mas_equalTo(0);
    }];
    
    // visMsgLabel
    self.vipMsgLabel = [self.vipContentView addLabelWithFontSize:MIN_FONT_SIZE
                                                   textAlignment:NSTextAlignmentRight
                                                       textColor:APP_MainColor
                                                    adjustsWidth:YES
                                                    cornerRadius:0
                                                            text:nil];
    [self.vipMsgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.vipMsgView.right).offset(2);
        make.centerY.mas_equalTo(self.vipMsgView);
        make.right.mas_equalTo(0);
    }];

    // 点击进入我的积分
    UIButton *myScoreBtn = [UIButton new];
    [self.contentView addSubview:myScoreBtn];
    [myScoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(scoreContentView);
        make.bottom.mas_equalTo(vipContentView);
    }];
    myScoreBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self gotoMyScore];
        return [RACSignal empty];
    }];

    // 返利
    LYUpImgDownTxtView *backCashView = [[LYUpImgDownTxtView alloc] initWithImageName:@"返利图标"
                                                                               title:@"返利"
                                                                          titleColor:@"#ffffff"
                                                                          clickBlock:^{
                                                                              @strongify(self);
                                                                              [self gotoCashBack];
                                                                          }];
    [self.contentView addSubview:backCashView];
    [backCashView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(60);
        make.bottom.mas_equalTo(-12.5);
    }];
    // 签到
    LYUpImgDownTxtView *unionStoreView = [[LYUpImgDownTxtView alloc] initWithImageName:@"签到"
                                                                                 title:@"签到"
                                                                            titleColor:@"#ffffff"
                                                                            clickBlock:^{
                                                                              @strongify(self);
                                                                                [self gotoScoreSignIn];
                                                                            }];
    [self.contentView addSubview:unionStoreView];
    [unionStoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.centerY.mas_equalTo(backCashView);
        make.right.mas_equalTo(backCashView.left).offset(-15);
    }];
    // 优惠券
    LYUpImgDownTxtView *couponNumberView = [[LYUpImgDownTxtView alloc] initWithImageName:@"优惠券-图标"
                                                                                 title:@"优惠券"
                                                                            titleColor:@"#ffffff"
                                                                            clickBlock:^{
                                                                                @strongify(self);
                                                                                [self gotoMyCoupons];
                                                                            }];
    [self.contentView addSubview:couponNumberView];
    [couponNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.centerY.mas_equalTo(backCashView);
        make.left.mas_equalTo(backCashView.right).offset(15);
    }];
    self.couponNumberLabel = couponNumberView.titleLabel;
    // 审核期间隐藏返利
    if (![LYAppCheckManager shareInstance].isAppAgree) {
        backCashView.hidden = YES;
        [unionStoreView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.height.centerY.mas_equalTo(backCashView);
            make.right.mas_equalTo(self.contentView.centerX).offset(-15);
        }];
        [couponNumberView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.height.centerY.mas_equalTo(backCashView);
            make.left.mas_equalTo(self.contentView.centerX).offset(15);
        }];
    }
}

// 跳转我的积分
- (void)gotoMyScore
{
    [self.viewModel gotoMyScore];
}
// 跳转积分签到
- (void)gotoScoreSignIn
{
    [self.viewModel gotoScoreSignIn];
}
// 跳转关联店铺
- (void)gotoRelateStore
{
    [self.viewModel gotoRelateStore];
}
// 跳转返利
- (void)gotoCashBack
{
    [self.viewModel gotoCashBack];
}
// 跳转优惠券
- (void)gotoMyCoupons
{
    [self.viewModel gotoMyCoupons];
}
// 点击头部
- (void)headerClick
{
    [self.viewModel headerClick];
}

#pragma mark -刷新数据
- (void)reloadDataWithViewModel:(MineViewModel *)viewModel
{
    self.viewModel = viewModel;
    // 头像
    if ([AccountService shareInstance].isLogin) {
        [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:SignInUser.headImageUrl]
                              placeholderImage:[UIImage imageNamed:@"未登录默认头像"]];
    }else{
        self.headerImgView.image = [UIImage imageNamed:@"未登录默认头像"];
    }
    // 昵称
    if ([AccountService shareInstance].isLogin) {
        self.nickNameLabel.text = SignInUser.nickName;
    }else{
        self.nickNameLabel.text = @"登录/注册";
    }
    // 会员积分信息
    if ([AccountService shareInstance].isLogin) {
        self.scoreContentView.hidden = NO;
        self.vipContentView.hidden = NO;
        self.vipMsgView.image = [UIImage imageNamed:[SignInUser vipLevelImageName]];
        self.vipMsgLabel.text = [NSString stringWithFormat:@"%@ > ",[SignInUser vipLevelName]];
        @weakify(self);
        [RACObserve(SignInUser, integralTotalNumber) subscribeNext:^(id x) {
            @strongify(self);
            self.scoreMsgLabel.text = [NSString stringWithFormat:@"积分: %ld > ",(long)SignInUser.integralTotalNumber];
        }];
    }else{
        self.scoreContentView.hidden = YES;
        self.vipContentView.hidden = YES;
        self.vipMsgView.image = nil;
        self.vipMsgLabel.text = nil;
        self.scoreMsgLabel.text = nil;
    }
    
    // 优惠券
    NSString *couponString = @"优惠券";
    if (SignInUser.couponTotalNumber>0) {
        couponString = [couponString stringByAppendingString:[NSString stringWithFormat:@"(%ld)",(long)SignInUser.couponTotalNumber]];
    }
    self.couponNumberLabel.text = couponString;
}

@end
