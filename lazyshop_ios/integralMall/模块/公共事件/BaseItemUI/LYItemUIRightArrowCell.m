//
//  LYItemUIRightArrowCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/27.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIRightArrowCell.h"

@implementation LYItemUIRightArrowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImage *rightArrowImage = [UIImage imageNamed:@"编辑收货地址箭头"];
        _rightArrowView = [[UIImageView alloc] initWithImage:rightArrowImage];
        [self.contentView addSubview:_rightArrowView];
        [_rightArrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(rightArrowImage.size.width);
            make.height.mas_equalTo(rightArrowImage.size.height);
        }];
    }
    return self;
}

@end
