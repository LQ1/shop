//
//  GoodsDetailCommentImageCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/7.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CommentRowImageCell.h"

@interface CommentRowImageCell()

@property (nonatomic,strong)UIImageView *imageView;

@end

@implementation CommentRowImageCell

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
    self.imageView = [UIImageView new];
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark -reload
- (void)reloadWithImageUrl:(NSString *)imageUrl
{
    [self.imageView ly_showMidImg:imageUrl];
}

@end
