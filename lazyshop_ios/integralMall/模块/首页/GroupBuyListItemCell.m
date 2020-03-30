//
//  GroupBuyListItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GroupBuyListItemCell.h"

@implementation GroupBuyListItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViews];
    }
    return self;
}

- (void)addViews
{
    [self.sloganLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(17);
        make.left.mas_equalTo(self.productImageView.right).offset(10);
        make.bottom.mas_equalTo(self.productImageView.bottom);
    }];
    [self.panicBuyButton setTitle:@"立即拼单" forState:UIControlStateNormal];
}

@end
