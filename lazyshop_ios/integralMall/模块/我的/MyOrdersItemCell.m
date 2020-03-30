//
//  MyOrdersItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/23.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MyOrdersItemCell.h"

#import "MyOrderlistProductViewModel.h"

@interface MyOrdersItemCell()

@property (nonatomic,strong)UILabel *quantityLabel;

@end
@implementation MyOrdersItemCell

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
    // 数量
    self.quantityLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                  textAlignment:NSTextAlignmentRight
                                                      textColor:@"#999999"
                                                   adjustsWidth:NO
                                                   cornerRadius:0
                                                           text:nil];
    [self.quantityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.productPriceLabel);
        make.right.mas_equalTo(-15);
    }];
    
    [self.contentView addBottomLine];
}

- (void)bindViewModel:(MyOrderlistProductViewModel *)vm
{
    [self.productImgView ly_showMidImg:vm.model.goods_thumb];
    self.productNameLabel.text = vm.model.goods_title;
    self.productSkuLabel.text = vm.model.attr_values;
    if ([vm.model.order_type integerValue]==OrderType_Score) {
        self.productPriceLabel.text = [NSString stringWithFormat:@"%@积分",vm.model.score];
    }else{
        self.productPriceLabel.text = [NSString stringWithFormat:@"¥ %@",vm.model.price];
    }
    self.quantityLabel.text = [NSString stringWithFormat:@"x%@",vm.model.quantity];
}

@end
