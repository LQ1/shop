//
//  MyScoreHeaderView.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/2.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "MyScoreHeaderView.h"

#import "MyScoreViewModel.h"

@interface MyScoreHeaderView()

@property (nonatomic, strong) UILabel *vipLevelLabel;
@property (nonatomic, strong) UILabel *myScoreLabel;
@property (nonatomic, strong) UILabel *levelTipLabel;

@end

@implementation MyScoreHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _gotoSignSingal = [[RACSubject subject] setNameWithFormat:@"%@ gotoSignSingal", self.class];
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.backgroundColor = [UIColor whiteColor];
    // 去签到
    UIButton *signBtn = [UIButton new];
    signBtn.titleLabel.font = [UIFont systemFontOfSize:MIDDLE_FONT_SIZE];
    [signBtn setImage:[UIImage imageNamed:@"去签到"]
             forState:UIControlStateNormal];
    [self addSubview:signBtn];
    [signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
    }];
    @weakify(self);
    signBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.gotoSignSingal sendNext:nil];
        return [RACSignal empty];
    }];
    // 会员等级
    UILabel *vipLevelLabel = [UILabel new];
    self.vipLevelLabel = vipLevelLabel;
    vipLevelLabel.font = [UIFont boldSystemFontOfSize:MAX_LARGE_FONT_SIZE];
    vipLevelLabel.textAlignment = NSTextAlignmentCenter;
    vipLevelLabel.textColor = [CommUtls colorWithHexString:@"#f13234"];
    [self addSubview:vipLevelLabel];
    [vipLevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(signBtn);
    }];
    // 我的积分
    UILabel *myScoreLabel = [UILabel new];
    self.myScoreLabel = myScoreLabel;
    myScoreLabel.font = [UIFont systemFontOfSize:SMALL_FONT_SIZE];
    myScoreLabel.textAlignment = NSTextAlignmentCenter;
    myScoreLabel.textColor = [CommUtls colorWithHexString:App_TxtBColor];
    [self addSubview:myScoreLabel];
    [myScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.vipLevelLabel.bottom).offset(8);
        make.centerX.mas_equalTo(self.vipLevelLabel);
    }];
    // 灰色线
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [CommUtls colorWithHexString:@"#bfbfbf"];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(2);
        make.top.mas_equalTo(myScoreLabel.bottom).offset(30);
    }];
    // 图片布局
    //  当前用户等级
    UIImageView *midImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:SignInUser.vipLevelName]];
    [self addSubview:midImgView];
    [midImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lineView);
        make.centerX.mas_equalTo(0);
    }];
    //  上一个
    UIImage *lastImg = [UIImage imageNamed:[SignInUser vipLevelNameWithLevel:SignInUser.vipLevel-1]];
    if (lastImg) {
        UIImageView *lastImgView = [[UIImageView alloc] initWithImage:lastImg];
        [self addSubview:lastImgView];
        [lastImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(lineView);
            make.left.mas_equalTo(15);
        }];
    }
    //  下一个
    UIImage *nextImg = [UIImage imageNamed:[SignInUser vipLevelNameWithLevel:SignInUser.vipLevel+1]];
    if (nextImg) {
        UIImageView *nextImgView = [[UIImageView alloc] initWithImage:nextImg];
        [self addSubview:nextImgView];
        [nextImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(lineView);
            make.right.mas_equalTo(-15);
        }];
    }
    // 升级提示
    UILabel *levelTipLabel = [UILabel new];
    self.levelTipLabel = levelTipLabel;
    levelTipLabel.layer.cornerRadius = 10.;
    levelTipLabel.layer.masksToBounds = YES;
    levelTipLabel.font = [UIFont systemFontOfSize:SMALL_FONT_SIZE];
    levelTipLabel.textAlignment = NSTextAlignmentCenter;
    levelTipLabel.textColor = [UIColor whiteColor];
    levelTipLabel.backgroundColor = [CommUtls colorWithHexString:@"#bfbfbf"];
    [self addSubview:levelTipLabel];
    [levelTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.bottom).offset(42);
        make.height.mas_equalTo(20);
        make.centerX.mas_equalTo(self);
    }];
}

#pragma mark -Reload
- (void)reloadDataWithViewModel:(MyScoreViewModel *)viewModel
{
    self.vipLevelLabel.text = viewModel.vipLevelName;
    self.myScoreLabel.text = viewModel.growthTip;
    CGFloat levelTipWidth = [CommUtls getContentSize:viewModel.levelTip
                                                font:[UIFont systemFontOfSize:SMALL_FONT_SIZE]
                                                size:CGSizeMake(CGFLOAT_MAX, 20)].width +25;
    [self.levelTipLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(levelTipWidth);
    }];
    self.levelTipLabel.text = viewModel.levelTip;
}

@end
