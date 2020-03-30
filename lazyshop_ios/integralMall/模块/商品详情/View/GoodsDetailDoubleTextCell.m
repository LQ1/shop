//
//  GoodsDetailDoubleTextCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/15.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailDoubleTextCell.h"

#import "GoodsDetailDiscountItemViewModel.h"

@interface GoodsDetailDoubleTextCell()

@property (nonatomic,strong)UILabel *rightTextLabel;

@end

@implementation GoodsDetailDoubleTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addViews];
    }
    return self;
}

- (void)addViews
{
    self.rightTextLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                   textAlignment:0
                                                       textColor:@"#333333"
                                                    adjustsWidth:NO
                                                    cornerRadius:0
                                                            text:nil];
    self.rightTextLabel.numberOfLines = 0;
    [self.rightTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftTitleLabel.right);
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

- (void)bindViewModel:(GoodsDetailDiscountItemViewModel *)vm
{
    self.leftTitleLabel.text = vm.title;
    self.rightTextLabel.text = vm.detail;
}

@end
