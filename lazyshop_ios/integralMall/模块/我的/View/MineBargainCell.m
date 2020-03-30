//
//  MineBargainCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MineBargainCell.h"

@implementation MineBargainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    [self fillTopCorner];
    // 图
    self.rowImageView.image = [UIImage imageNamed:@"我的砍价图标"];
    // 文
    self.rowTitleLabel.text = @"我的砍价";
}

#pragma mark -reload
- (void)reload
{
    NSString *title = @"我的砍价";
    if (SignInUser.myBargainOrdersNumber>0) {
        title = [title stringByAppendingString:[NSString stringWithFormat:@" (%ld)",(long)SignInUser.myBargainOrdersNumber]];
    }
    self.rowTitleLabel.text = title;
}

@end
