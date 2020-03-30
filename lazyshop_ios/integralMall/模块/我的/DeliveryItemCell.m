//
//  DeliveryItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/12.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "DeliveryItemCell.h"

#import "DeliveryItemCellViewModel.h"

@interface DeliveryItemCell()

@property (nonatomic, strong) UILabel *deliveryDescLabel;
@property (nonatomic, strong) UILabel *deliveryTimeLabel;

@end

@implementation DeliveryItemCell

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
    // 追踪详情
    self.deliveryDescLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                      textAlignment:0
                                                          textColor:@"#999999"
                                                       adjustsWidth:NO
                                                       cornerRadius:0
                                                               text:nil];
    self.deliveryDescLabel.numberOfLines = 0;
    [self.deliveryDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(12.5);
        make.right.mas_equalTo(-15);
    }];
    // 追踪时间
    self.deliveryTimeLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                      textAlignment:0
                                                          textColor:@"#999999"
                                                       adjustsWidth:NO
                                                       cornerRadius:0
                                                               text:nil];
    [self.deliveryTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.deliveryDescLabel);
        make.top.mas_equalTo(self.deliveryDescLabel.bottom).offset(12.5);
        make.right.mas_equalTo(-15);
    }];
    
    [self addBottomLine];
}

- (void)bindViewModel:(DeliveryItemCellViewModel *)vm
{
    NSString *changeStr = vm.remark;
    NSString *allStr = [vm.accept_station stringByAppendingString:changeStr];
    self.deliveryDescLabel.attributedText = [CommUtls changeText:changeStr
                                                         content:allStr
                                                  changeTextFont:[UIFont systemFontOfSize:SMALL_FONT_SIZE]
                                                        textFont:[UIFont systemFontOfSize:SMALL_FONT_SIZE]
                                                 changeTextColor:[UIColor blueColor]
                                                       textColor:[CommUtls colorWithHexString:@"#999999"]];
    
    self.deliveryTimeLabel.text = vm.accept_time;
}

@end
