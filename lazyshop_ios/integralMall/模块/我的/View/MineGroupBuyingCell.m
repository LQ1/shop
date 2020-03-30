//
//  MineGroupBuyingCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MineGroupBuyingCell.h"

@implementation MineGroupBuyingCell

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
    [self fillBottomCorner];
    // 图
    self.rowImageView.image = [UIImage imageNamed:@"我的拼团图标"];
    // 文
    self.rowTitleLabel.text = @"我的拼团";
    
    [self.backContentView addBottomLine];
}

#pragma mark -reload
- (void)reload
{
    NSString *title = @"我的拼团";
    if (SignInUser.myGroupByOrdersNumber>0) {
        title = [title stringByAppendingString:[NSString stringWithFormat:@" (%ld)",(long)SignInUser.myGroupByOrdersNumber]];
    }
    self.rowTitleLabel.text = title;
}

@end
