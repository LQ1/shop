//
//  GoodsDetailRoundIndexView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/18.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailRoundIndexView.h"

@interface GoodsDetailRoundIndexView()

@property (nonatomic,strong)UILabel *titleLabel;

@end

@implementation GoodsDetailRoundIndexView

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
    // 圆
    UIImageView *roundView = [self addImageViewWithImageName:@"图片数量" cornerRadius:GoodsDetailRoundIndexViewWidth/2.0];
    [roundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    // 文
    self.titleLabel = [self addLabelWithFontSize:LARGE_FONT_SIZE
                                   textAlignment:NSTextAlignmentCenter
                                       textColor:@"#ffffff"
                                    adjustsWidth:NO
                                    cornerRadius:0
                                            text:nil];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
    }];
}

#pragma mark -设置数量
- (void)setCurrentNumber:(NSInteger)currentNumber
             totalNumber:(NSInteger)totalNumber
{
    self.titleLabel.text = [NSString stringWithFormat:@"%ld/%ld",currentNumber,totalNumber];
}

@end
