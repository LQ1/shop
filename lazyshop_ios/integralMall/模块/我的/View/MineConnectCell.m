//
//  MineConnectCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "MineConnectCell.h"

@implementation MineConnectCell

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
    self.rowImageView.image = [UIImage imageNamed:@"联系我们icon"];
    // 文
    self.rowTitleLabel.text = @"联系我们";
}

@end
