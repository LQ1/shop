//
//  LYProductItemBaseCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/27.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYProductItemBaseCell.h"

#import "LYProductItemBaseCellViewModel.h"

@implementation LYProductItemBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.productImgView = [self.contentView addImageViewWithImageName:nil
                                                             cornerRadius:0];
        [self.productImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.width.height.mas_equalTo(80);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        self.productNameLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                         textAlignment:NSTextAlignmentLeft
                                                             textColor:@"#000000"
                                                          adjustsWidth:NO
                                                          cornerRadius:0
                                                                  text:nil];
        self.productNameLabel.numberOfLines = 2;
        [self.productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.productImgView);
            make.left.mas_equalTo(self.productImgView.right).offset(10);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(35);
        }];
        
        self.productPriceLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                          textAlignment:NSTextAlignmentLeft
                                                              textColor:@"#ff1600"
                                                           adjustsWidth:NO
                                                           cornerRadius:0
                                                                   text:nil];
        [self.productPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productNameLabel);
            make.bottom.mas_equalTo(self.productImgView).offset(5);
        }];
        
        self.productSkuLabel = [self.contentView addLabelWithFontSize:11
                                                        textAlignment:NSTextAlignmentLeft
                                                            textColor:@"#999999"
                                                         adjustsWidth:NO
                                                         cornerRadius:0
                                                                 text:nil];
        self.productSkuLabel.numberOfLines = 2;
        self.productSkuLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [self.productSkuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.productNameLabel);
            make.top.mas_equalTo(self.productNameLabel.bottom);
            make.bottom.mas_equalTo(self.productPriceLabel.top);
        }];
    }
    return self;
}

#pragma mark -bindVM
- (void)bindViewModel:(LYProductItemBaseCellViewModel *)vm
{
    [self.productImgView ly_showMidImg:vm.productImgUrl];
    self.productNameLabel.text = vm.productName;
    self.productSkuLabel.text = vm.productSkuString;
    self.productPriceLabel.text = [NSString stringWithFormat:@"¥ %@",vm.productPrice];
}

@end
