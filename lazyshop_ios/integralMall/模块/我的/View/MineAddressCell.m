//
//  MineAddressCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MineAddressCell.h"

@implementation MineAddressCell

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
    self.rowImageView.image = [UIImage imageNamed:@"地址管理图标"];
    // 文
    self.rowTitleLabel.text = @"地址管理";
    
    [self.backContentView addBottomLine];
}

@end
