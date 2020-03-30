//
//  HomeSecKillHeaderView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/5.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeSecKillHeaderView.h"

#import "LYCountDownView.h"
#import "HomeSecKillCellViewModel.h"

#import "SecKillCountDownManager.h"

@interface HomeSecKillHeaderView()

@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)LYCountDownView *countDownView;


@end

@implementation HomeSecKillHeaderView

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
    // 懒店秒杀
    self.leftTipLabel.text = @"懒店秒杀";
    // xx点场
    self.timeLabel = [self addLabelWithFontSize:SMALL_FONT_SIZE
                                      textAlignment:NSTextAlignmentCenter
                                          textColor:@"#262626"
                                       adjustsWidth:YES
                                       cornerRadius:0
                                               text:nil];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(38);
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(56);
    }];
    @weakify(self);
    [[RACObserve([SecKillCountDownManager sharedInstance], killTime) distinctUntilChanged] subscribeNext:^(id x) {
        @strongify(self);
        if (x) {
            self.timeLabel.hidden = NO;
            self.timeLabel.text = [NSString stringWithFormat:@"%@点场",x];
        }else{
            self.timeLabel.hidden = YES;
        }
    }];
    // 倒计时
    self.countDownView = [[LYCountDownView alloc] initWithItemBackColorString:@"#262626"
                                                            textColorString:@"#ffffff"
                                                             dotColorString:@"#262626"
                                                                   dotWidth:10.0f];
    [self addSubview:self.countDownView];
    [self.countDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeLabel.right).offset(5);
        make.width.mas_equalTo([self.countDownView totalWidth]);
        make.height.mas_equalTo(CountDownViewHeight);
        make.centerY.mas_equalTo(self.timeLabel);
    }];
    [[RACObserve([SecKillCountDownManager sharedInstance], validSeconds) distinctUntilChanged] subscribeNext:^(id x) {
        @strongify(self);
        if ([x integerValue]>0) {
            self.countDownView.hidden = NO;
            [self.countDownView setRemainingTime:[x integerValue]];
        }else{
            self.countDownView.hidden = YES;
        }
    }];
}

@end
