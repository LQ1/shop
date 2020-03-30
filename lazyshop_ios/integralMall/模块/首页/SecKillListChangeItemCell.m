//
//  SecKillListChangeItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SecKillListChangeItemCell.h"

#import "SecKillListPageViewModel.h"

@interface SecKillListChangeItemCell()

@property (nonatomic,strong)UILabel *secKillStartTimeLabel;
@property (nonatomic,strong)UILabel *secKillStateLabel;
@property (nonatomic,strong)UILabel *secKillEndTipLabel;
@property (nonatomic,strong)UILabel *secKillEndCountdownLabel;

@end

@implementation SecKillListChangeItemCell

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
    self.secKillStartTimeLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                          textAlignment:NSTextAlignmentCenter
                                                              textColor:@"#999999"
                                                           adjustsWidth:YES
                                                           cornerRadius:0
                                                                   text:nil];
    self.secKillStartTimeLabel.font = [UIFont boldSystemFontOfSize:MIDDLE_FONT_SIZE];
    [self.secKillStartTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.centerX.mas_equalTo(self);
    }];
    
    self.secKillStateLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                      textAlignment:NSTextAlignmentCenter
                                                          textColor:@"#999999"
                                                       adjustsWidth:YES
                                                       cornerRadius:0
                                                               text:nil];
    self.secKillStateLabel.font = [UIFont boldSystemFontOfSize:SMALL_FONT_SIZE];
    [self.secKillStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.secKillStartTimeLabel.bottom).offset(3);
        make.centerX.mas_equalTo(self);
    }];
    
    self.secKillEndTipLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                       textAlignment:NSTextAlignmentCenter
                                                           textColor:APP_MainColor
                                                        adjustsWidth:YES
                                                        cornerRadius:0
                                                                text:@"距离结束"];
    self.secKillEndTipLabel.font = [UIFont boldSystemFontOfSize:SMALL_FONT_SIZE];
    [self.secKillEndTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.centerX.mas_equalTo(self);
    }];

    self.secKillEndCountdownLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                             textAlignment:NSTextAlignmentCenter
                                                                 textColor:APP_MainColor
                                                              adjustsWidth:YES
                                                              cornerRadius:0
                                                                      text:nil];
    self.secKillEndCountdownLabel.font = [UIFont boldSystemFontOfSize:MIDDLE_FONT_SIZE];
    [self.secKillEndCountdownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.secKillEndTipLabel.bottom).offset(3);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.contentView addBottomLine];
}

- (void)bindViewModel:(SecKillListPageViewModel *)vm
{
    // 是否选中
    if (vm.selected) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.secKillStartTimeLabel.textColor = [CommUtls colorWithHexString:APP_MainColor];
        self.secKillStateLabel.textColor = [CommUtls colorWithHexString:APP_MainColor];
    }else{
        self.contentView.backgroundColor = [CommUtls colorWithHexString:@"#2f363b"];
        self.secKillStartTimeLabel.textColor = [CommUtls colorWithHexString:@"#999999"];
        self.secKillStateLabel.textColor = [CommUtls colorWithHexString:@"#999999"];
    }
    // 状态
    self.secKillStartTimeLabel.text = vm.startTime;
    switch (vm.state) {
        case SecKillListState_WillBegin:
        {
            self.secKillStartTimeLabel.hidden = NO;
            self.secKillStateLabel.hidden = NO;
            self.secKillEndTipLabel.hidden = YES;
            self.secKillEndCountdownLabel.hidden = YES;
            // 即将开始
            self.secKillStateLabel.text = @"即将开始";
        }
            break;
        case SecKillListState_Begining:
        {
            self.secKillStartTimeLabel.hidden = vm.selected;
            self.secKillStateLabel.hidden = vm.selected;
            self.secKillEndTipLabel.hidden = !vm.selected;
            self.secKillEndCountdownLabel.hidden = !vm.selected;
            // 抢购进行中
            self.secKillStateLabel.text = @"抢购进行中";
            @weakify(self);
            [[[RACObserve(vm, validSeconds) takeUntil:self.rac_prepareForReuseSignal] distinctUntilChanged] subscribeNext:^(id x) {
                @strongify(self);
                self.secKillEndCountdownLabel.text = [vm stringValidTime];
            }];
        }
            break;
        case SecKillListState_IsEnd:
        {
            self.secKillStartTimeLabel.hidden = NO;
            self.secKillStateLabel.hidden = NO;
            self.secKillEndTipLabel.hidden = YES;
            self.secKillEndCountdownLabel.hidden = YES;
            // 已结束
            self.secKillStateLabel.text = @"已结束";
        }
            break;
            
        default:
            break;
    }
}

@end
