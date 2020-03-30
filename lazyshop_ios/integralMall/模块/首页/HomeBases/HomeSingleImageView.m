//
//  HomeSingleImageView.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "HomeSingleImageView.h"

@interface HomeSingleImageView ()

@property (nonatomic, strong) UIImageView *imageView;


@end

@implementation HomeSingleImageView

- (instancetype)initWithHWScale:(CGFloat)hwScale
                   leftRightGap:(CGFloat)leftRightGap
{
    self = [super init];
    if (self) {
        _clickSignal = [[RACSubject subject] setNameWithFormat:@"%@ clickSignal", self.class];
        // height
        CGFloat height = [HomeSingleImageView fetchHeightWithHWScale:hwScale
                                                        leftRightGap:leftRightGap];
        _viewHeight = height;
        // imageView
        self.imageView = [self addImageViewWithImageName:nil
                                            cornerRadius:3.];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftRightGap);
            make.right.mas_equalTo(-leftRightGap);
            make.top.bottom.mas_equalTo(0);
        }];
        // click
        UIButton *clickBtn = [UIButton new];
        [self addSubview:clickBtn];
        [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        @weakify(self);
        clickBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            [self.clickSignal sendNext:nil];
            return [RACSignal empty];
        }];
    }
    return self;
}

- (void)reloadWithImageUrl:(NSString *)imgUrl
{
    [self.imageView ly_showMidImg:imgUrl];
}

+ (CGFloat)fetchHeightWithHWScale:(CGFloat)hwScale
                     leftRightGap:(CGFloat)leftRightGap
{
    CGFloat height = (KScreenWidth-leftRightGap*2)*hwScale;
    return height;
}

@end
