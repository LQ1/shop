//
//  MineSettingCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MineSettingCell.h"

@implementation MineSettingCell

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
    self.rowImageView.image = [UIImage imageNamed:@"设置图标"];
    // 文
    self.rowTitleLabel.text = @"设置";
}
@end
