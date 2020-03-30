//
//  ConfirmOrderListAmountCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/27.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ConfirmOrderListAmountCell.h"

#import "ConfirmOrderListAmountCellViewModel.h"

@interface ConfirmOrderListAmountCell()

@property (nonatomic,strong)UILabel *productNumberLabel;
@property (nonatomic,strong)UILabel *productPriceLabel;

@end

@implementation ConfirmOrderListAmountCell

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
    self.productPriceLabel = [UILabel new];
    self.productPriceLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.productPriceLabel];
    [self.productPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    self.productNumberLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                       textAlignment:NSTextAlignmentRight
                                                           textColor:@"#000000"
                                                        adjustsWidth:NO
                                                        cornerRadius:0
                                                                text:nil];
    [self.productNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.productPriceLabel.left).offset(-20);
        make.centerY.mas_equalTo(self.productPriceLabel);
    }];
}

#pragma mark -reload
- (void)bindViewModel:(ConfirmOrderListAmountCellViewModel *)vm
{
    NSString *changeString = vm.productTotalPrice;
    NSString *prefixString = @"小计: ";
    NSString *contentString = [prefixString stringByAppendingString:changeString];
    self.productPriceLabel.attributedText = [CommUtls changeText:changeString
                                                         content:contentString
                                                  changeTextFont:[UIFont systemFontOfSize:MIDDLE_FONT_SIZE]
                                                        textFont:[UIFont systemFontOfSize:MIDDLE_FONT_SIZE]
                                                 changeTextColor:[CommUtls colorWithHexString:APP_MainColor]
                                                       textColor:[CommUtls colorWithHexString:@"#000000"]];
    self.productNumberLabel.text = [NSString stringWithFormat:@"共%ld件商品",(long)vm.productTotalNumber];
}

@end
