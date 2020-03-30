//
//  MyBargainItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MyBargainItemCell.h"

#import "MyBargainItemViewModel.h"

@interface MyBargainItemCell()

@property (nonatomic,strong)UILabel *quantityLabel;

@end

@implementation MyBargainItemCell

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

- (void)bindViewModel:(MyBargainItemViewModel *)vm
{
    [super bindViewModel:vm];
    self.quantityLabel.text = [NSString stringWithFormat:@"x%@",vm.quantity];
}

@end
