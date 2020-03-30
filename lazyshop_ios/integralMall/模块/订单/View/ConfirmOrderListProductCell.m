//
//  ConfirmOrderListProductCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ConfirmOrderListProductCell.h"

#import "ConfirmOrderListProductCellViewModel.h"

@interface ConfirmOrderListProductCell()

@property (nonatomic,strong)UILabel *productQuantityLabel;

@end

@implementation ConfirmOrderListProductCell

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
    [self.productNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.productImgView.right).offset(10);
        make.top.mas_equalTo(self.productImgView);
        make.height.mas_equalTo(35);
        make.right.mas_equalTo(-45);
    }];
    
    self.productQuantityLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                         textAlignment:NSTextAlignmentRight
                                                             textColor:@"#999999"
                                                          adjustsWidth:NO
                                                          cornerRadius:0
                                                                  text:nil];
    [self.productQuantityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.productPriceLabel);
    }];
    
    [self.contentView addBottomLine];
}

#pragma mark -reload
- (void)bindViewModel:(ConfirmOrderListProductCellViewModel *)vm
{
    [super bindViewModel:vm];
    self.productPriceLabel.text = vm.productPrice;
    self.productQuantityLabel.text = [NSString stringWithFormat:@"x%ld",(long)vm.productQuantiry];
}

@end
