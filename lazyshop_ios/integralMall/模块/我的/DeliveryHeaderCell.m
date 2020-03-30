//
//  DeliveryHeaderCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/12.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "DeliveryHeaderCell.h"

#import "DeliveryHeaderCellViewModel.h"

@interface DeliveryHeaderCell()

@property (nonatomic, strong) UILabel *deliveryNoLabel;
@property (nonatomic, strong) UILabel *deliveryNameLabel;

@end

@implementation DeliveryHeaderCell

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
    // 运单号
    UILabel *deliveryNoTipLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                           textAlignment:0
                                                               textColor:@"#333333"
                                                            adjustsWidth:NO
                                                            cornerRadius:0
                                                                    text:@"运单号:"];
    [deliveryNoTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.width.mas_equalTo(55);
    }];
    self.deliveryNoLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                    textAlignment:0
                                                        textColor:@"#333333"
                                                     adjustsWidth:NO
                                                     cornerRadius:0
                                                             text:nil];
    [self.deliveryNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(deliveryNoTipLabel.right).offset(3);
        make.centerY.mas_equalTo(deliveryNoTipLabel);
    }];
    
    // 快递方式
    UILabel *deliveryNameTipLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                             textAlignment:0
                                                                 textColor:@"#333333"
                                                              adjustsWidth:NO
                                                              cornerRadius:0
                                                                      text:@"快递方式:"];
    [deliveryNameTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(deliveryNoTipLabel.bottom).offset(12.5);
        make.width.mas_equalTo(68);
    }];
    self.deliveryNameLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                      textAlignment:0
                                                          textColor:@"#333333"
                                                       adjustsWidth:NO
                                                       cornerRadius:0
                                                               text:nil];
    [self.deliveryNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(deliveryNameTipLabel.right).offset(3);
        make.centerY.mas_equalTo(deliveryNameTipLabel);
    }];
}

- (void)bindViewModel:(DeliveryHeaderCellViewModel *)vm
{
    self.deliveryNoLabel.text = vm.delivery_no;
    self.deliveryNameLabel.text = vm.delivery_name;
}

@end
