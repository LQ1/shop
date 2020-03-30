//
//  ScoreSignInCalendarView.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/2.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "ScoreSignInCalendarView.h"

#import "ScoreSignInCalendarViewModel.h"
#import "ScoreSingInDateItemView.h"
#import "ScoreSignInViewModel.h"

#define ScoreSignInCalendarViewItemScale 43./53.

@interface ScoreSignInCalendarView ()

@property (nonatomic, strong) ScoreSignInCalendarViewModel *viewModel;

@end

@implementation ScoreSignInCalendarView


#pragma mark -主界面
- (void)addViews
{
    self.backgroundColor = [UIColor whiteColor];
    // header
    UIImageView *calenderTipView = [self addImageViewWithImageName:@"签到日历"
                                                      cornerRadius:0];
    [calenderTipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.top).offset(22.5);
    }];
    
    NSString *yearMonthString = [NSString stringWithFormat:@"%ld年%ld月",self.viewModel.currentYear,self.viewModel.currentMonth];
    UILabel *yearMonthLabel = [self addLabelWithFontSize:SMALL_FONT_SIZE
                                           textAlignment:0
                                               textColor:APP_MainColor
                                            adjustsWidth:NO
                                            cornerRadius:0
                                                    text:yearMonthString];
    [yearMonthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(calenderTipView.right).offset(10);
        make.centerY.mas_equalTo(calenderTipView);
    }];
    // 日期块
    CGFloat itemWidth = KScreenWidth/7.;
    CGFloat itemHeight = itemWidth*ScoreSignInCalendarViewItemScale;
    for (int i = 0; i < self.viewModel.dataArray.count; i++) {
        ScoreSingInDateItemView *itemView = [ScoreSingInDateItemView new];
        [self addSubview:itemView];
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(itemWidth);
            make.height.mas_equalTo(itemHeight);
            make.left.mas_equalTo(itemWidth*(i%7));
            make.top.mas_equalTo(45+itemHeight*(i/7));
        }];
        [itemView reloadDataWithModel:[self.viewModel.dataArray objectAtIndex:i]];
        // 最后一行添加灰色块
        if (i/7 == self.viewModel.dataArray.count/7 - 1) {
            UIView *bottomGapView = [UIView new];
            bottomGapView.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
            [self addSubview:bottomGapView];
            [bottomGapView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(itemView);
                make.top.mas_equalTo(itemView.bottom);
                make.height.mas_equalTo(3);
            }];
        }
    }
}

#pragma mark -reload
- (void)reloadView
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self addViews];
}

- (void)reloadDataWithViewModel:(ScoreSignInViewModel *)viewModel
{
    self.viewModel = viewModel.signInCalendarViewModel;
    [self reloadView];
}

@end
