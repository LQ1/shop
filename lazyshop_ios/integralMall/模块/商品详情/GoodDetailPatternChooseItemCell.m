//
//  GoodDetailPatternChooseItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodDetailPatternChooseItemCell.h"

#import "GoodDetailPatternDetailItemViewModel.h"

@interface GoodDetailPatternChooseItemCell()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)CAShapeLayer *dottedLineLayer;

@end

@implementation GoodDetailPatternChooseItemCell

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
    // 标题
    self.titleLabel = [self addLabelWithFontSize:MIDDLE_FONT_SIZE
                                   textAlignment:NSTextAlignmentCenter
                                       textColor:@"#333333"
                                    adjustsWidth:YES
                                    cornerRadius:3
                                            text:nil];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
//    // 虚线边框
//    CAShapeLayer *border = [CAShapeLayer layer];
//    border.strokeColor = [CommUtls colorWithHexString:@"#999999"].CGColor;
//    border.fillColor = nil;
//    border.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
//    border.frame = self.bounds;
//    border.lineWidth = 1.f;
//    border.lineCap = @"square";
//    border.lineDashPattern = @[@4, @2];
//    self.dottedLineLayer = border;
}

- (void)bindViewModel:(GoodDetailPatternDetailItemViewModel *)vm
{
    self.titleLabel.text = vm.patternDetailName;
    if (vm.selected) {
        // 背景 文字颜色
        self.titleLabel.backgroundColor = [CommUtls colorWithHexString:@"#e43b3d"];
        self.titleLabel.textColor = [UIColor whiteColor];
        // 边框
//        [self.dottedLineLayer removeFromSuperlayer];
        self.titleLabel.layer.borderColor = nil;
        self.titleLabel.layer.borderWidth = 0.;
    }else{
        // 背景 文字颜色
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textColor = [CommUtls colorWithHexString:@"#333333"];
        if (vm.invalid) {
            // 边框
//            [self.titleLabel.layer addSublayer:self.dottedLineLayer];
            self.titleLabel.layer.borderColor = [CommUtls colorWithHexString:@"#999999"].CGColor;
            self.titleLabel.layer.borderWidth = 1.;
        }else{
            // 边框
//            [self.dottedLineLayer removeFromSuperlayer];
            self.titleLabel.layer.borderColor = [CommUtls colorWithHexString:APP_MainColor].CGColor;
            self.titleLabel.layer.borderWidth = 1.;
        }
    }
}

@end
