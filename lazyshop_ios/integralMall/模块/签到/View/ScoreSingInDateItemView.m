//
//  ScoreSingInDateItemView.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/2.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "ScoreSingInDateItemView.h"

#import "ScoreSingInDateItemModel.h"

@interface ScoreSingInDateItemView ()

@property (nonatomic, strong) UIView *rightLineView;
@property (nonatomic, strong) UIImageView *signTipView;
@property (nonatomic, strong) UILabel *titleNameLabel;

@end

@implementation ScoreSingInDateItemView

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
    self.titleNameLabel = [self addLabelWithFontSize:SMALL_FONT_SIZE
                                       textAlignment:NSTextAlignmentCenter
                                           textColor:nil
                                        adjustsWidth:NO
                                        cornerRadius:0
                                                text:nil];
    self.titleNameLabel.font = [UIFont boldSystemFontOfSize:SMALL_FONT_SIZE];
    [self.titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    UIView *topLine = [UIView new];
    topLine.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    [self addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    self.rightLineView = [UIView new];
    self.rightLineView.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    [self addSubview:self.rightLineView];
    [self.rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(0);
        make.width.mas_equalTo(1);
    }];

    self.signTipView = [self addImageViewWithImageName:@"对勾"
                                          cornerRadius:0];
    [self.signTipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(-2.5);
    }];
}

#pragma mark -Reload
- (void)reloadDataWithModel:(ScoreSingInDateItemModel *)model
{
    self.titleNameLabel.text = model.title;
    self.titleNameLabel.textColor = [CommUtls colorWithHexString:model.titleColorString];
    self.rightLineView.hidden = model.hideRightLine;
    self.signTipView.hidden = !model.hasSignIn;
}

@end
