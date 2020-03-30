//
//  ShippingAddressSelectCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShippingAddressSelectCell.h"

#import <DLUIKit/CheckBoxButton.h>
#import "ShippingAddressSelectCellViewModel.h"

@interface ShippingAddressSelectCell()

@property (nonatomic,strong)CheckBoxButton *checkBox;

@end

@implementation ShippingAddressSelectCell

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
    self.checkBox = [[CheckBoxButton alloc] initWithFrame:CGRectMake(0, 0, 17, 17)
                                            checkImgeWith:[UIImage imageNamed:@"选择收货地址未选中"]
                                          checkedImgeWith:[UIImage imageNamed:@"默认地址选中"] selectCheckedWith:NO];
    self.checkBox.userInteractionEnabled = NO;
    [self.contentView addSubview:self.checkBox];
    [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(17);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(35);
    }];
    
    [self.shippingUserNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(12.5);
    }];
    [self.shippingPhoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.checkBox.left).offset(-15);
        make.centerY.mas_equalTo(self.shippingUserNameLabel);
    }];
    [self.shippingAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shippingUserNameLabel);
        make.right.mas_equalTo(self.shippingPhoneNumberLabel);
        make.top.mas_equalTo(self.shippingUserNameLabel.bottom).offset(15);
    }];
    
    UIView *bottomGap = [UIView new];
    bottomGap.backgroundColor = [CommUtls colorWithHexString:@"#eeeeee"];
    [self.contentView addSubview:bottomGap];
    [bottomGap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(7.5);
    }];
}

- (void)bindViewModel:(ShippingAddressSelectCellViewModel *)vm
{
    self.shippingUserNameLabel.text = vm.shippingUserName;
    self.shippingPhoneNumberLabel.text = vm.shippingPhoneNumber;
    NSString *prefix = @"";
    if (vm.isDefault) {
        prefix = @"[默认地址]";
    }
    NSString *contentString = [prefix stringByAppendingString:vm.shippingAddress];
    self.shippingAddressLabel.attributedText = [CommUtls changeText:prefix
                                                            content:contentString
                                                     changeTextFont:[UIFont systemFontOfSize:SMALL_FONT_SIZE]
                                                           textFont:[UIFont systemFontOfSize:MIDDLE_FONT_SIZE]
                                                    changeTextColor:[CommUtls colorWithHexString:APP_MainColor]
                                                          textColor:[CommUtls colorWithHexString:@"#333333"]];
    self.checkBox.checked = vm.selected;
}

@end
