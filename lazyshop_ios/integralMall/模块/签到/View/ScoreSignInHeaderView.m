//
//  ScoreSignInHeaderView.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/2.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "ScoreSignInHeaderView.h"

#import "ScoreSignInViewModel.h"

@interface ScoreSignInHeaderView ()

@property (nonatomic, strong) ScoreSignInViewModel *viewModel;

@property (nonatomic, strong) UILabel *continueSignDaysLabel;
@property (nonatomic, strong) UILabel *wholeSignDaysLabel;
@property (nonatomic, strong) UILabel *myScoreLabel;
@property (nonatomic, strong) UIButton *signInButton;
@property (nonatomic, strong) UIImageView *helloImageView;

@end

@implementation ScoreSignInHeaderView

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
    self.backgroundColor = [CommUtls colorWithHexString:APP_MainColor];
    // 连续签到
    UILabel *continueSignDaysTipLabel = [self addLabelWithFontSize:LARGE_FONT_SIZE
                                                     textAlignment:0
                                                         textColor:@"#ffffff"
                                                      adjustsWidth:NO
                                                      cornerRadius:0
                                                              text:@"连续签到"];
    [continueSignDaysTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(iPhone4?5:55);
    }];
    // 连续签到天数
    self.continueSignDaysLabel = [self addLabelWithFontSize:LARGE_FONT_SIZE
                                                     textAlignment:NSTextAlignmentCenter
                                                         textColor:@"#ffffff"
                                                      adjustsWidth:NO
                                                      cornerRadius:0
                                                              text:nil];
    [self.continueSignDaysLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(continueSignDaysTipLabel.bottom).offset(iPhone4?4:14);
        make.centerX.mas_equalTo(continueSignDaysTipLabel);
    }];

    // 总签到
    UILabel *wholeSignDaysTipLabel = [self addLabelWithFontSize:LARGE_FONT_SIZE
                                                     textAlignment:NSTextAlignmentRight
                                                         textColor:@"#ffffff"
                                                      adjustsWidth:NO
                                                      cornerRadius:0
                                                              text:@"总签到"];
    [wholeSignDaysTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-30);
        make.top.mas_equalTo(continueSignDaysTipLabel);
    }];
    // 总签到天数
    self.wholeSignDaysLabel = [self addLabelWithFontSize:LARGE_FONT_SIZE
                                              textAlignment:NSTextAlignmentCenter
                                                  textColor:@"#ffffff"
                                               adjustsWidth:NO
                                               cornerRadius:0
                                                       text:nil];
    [self.wholeSignDaysLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.continueSignDaysLabel);
        make.centerX.mas_equalTo(wholeSignDaysTipLabel);
    }];

    // 笑脸
    UIImageView *helloImageView = [self addImageViewWithImageName:@"未登录默认头像"
                                                     cornerRadius:0];
    self.helloImageView = helloImageView;
    CGFloat imgWidth = iPhone4?5:62;
    self.helloImageView.layer.cornerRadius = imgWidth/2.;
    self.helloImageView.layer.masksToBounds = YES;
    [self addSubview:helloImageView];
    [helloImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(imgWidth);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(10);
    }];
    // 我的积分
    self.myScoreLabel = [self addLabelWithFontSize:MIDDLE_FONT_SIZE
                                           textAlignment:NSTextAlignmentCenter
                                               textColor:@"#ffffff"
                                            adjustsWidth:NO
                                            cornerRadius:0
                                                    text:nil];
    [self.myScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(helloImageView.bottom).offset(iPhone4?5:10);
        make.centerX.mas_equalTo(helloImageView);
    }];
    // 点击签到
    self.signInButton = [UIButton new];
    [self.signInButton setImage:[UIImage imageNamed:@"点击签到"]
                       forState:UIControlStateNormal];
    [self.signInButton setImage:[UIImage imageNamed:@"今日已签"]
                       forState:UIControlStateDisabled];
    [self addSubview:self.signInButton];
    [self.signInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.myScoreLabel.bottom).offset(iPhone4?5:15);
        make.centerX.mas_equalTo(self.myScoreLabel);
    }];
    @weakify(self);
    self.signInButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.viewModel signIn];
        return [RACSignal empty];
    }];
}

#pragma mark -Reload
- (void)reloadDataWithViewModel:(ScoreSignInViewModel *)viewModel
{
    self.viewModel = viewModel;
    self.continueSignDaysLabel.text = [NSString stringWithFormat:@"%ld天",(long)viewModel.continueSignDays];
    self.wholeSignDaysLabel.text = [NSString stringWithFormat:@"%ld天",(long)viewModel.wholeSignDays];
    self.myScoreLabel.text = [NSString stringWithFormat:@"我的积分：%ld",(long)SignInUser.integralTotalNumber];
    [self.helloImageView sd_setImageWithURL:[NSURL URLWithString:SignInUser.headImageUrl
                                             ]
                           placeholderImage:[UIImage imageNamed:@"未登录默认头像"]];
    if (viewModel.todaySigned) {
        self.signInButton.enabled = NO;
    }else{
        self.signInButton.enabled = YES;
    }
}

@end
