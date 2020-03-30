//
//  ConfirmDetailAddressCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailAddressCell.h"

#import "OrderDetailAddressCellViewModel.h"

@interface OrderDetailAddressCell()

@property (nonatomic,strong)UILabel *userNameLabel;
@property (nonatomic,strong)UILabel *userPhoneLabel;
@property (nonatomic,strong)UILabel *addressStrLabel;

@end

@implementation OrderDetailAddressCell

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
    self.contentView.backgroundColor = [UIColor whiteColor];
    // 位置标志
    UIImage *addressImage = [UIImage imageNamed:@"收货地址"];
    UIImageView *addressTipView = [[UIImageView alloc] initWithImage:addressImage];
    [self.contentView addSubview:addressTipView];
    [addressTipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(addressImage.size.width);
        make.height.mas_equalTo(addressImage.size.height);
    }];
    
    self.userNameLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                      textAlignment:0
                                          textColor:@"#000000"
                                       adjustsWidth:NO
                                       cornerRadius:0
                                               text:nil];
    self.userNameLabel.font = [UIFont boldSystemFontOfSize:MIDDLE_FONT_SIZE];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(addressTipView.right).offset(10);
        make.top.mas_equalTo(15);
    }];
    
    self.userPhoneLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                       textAlignment:0
                                           textColor:@"#000000"
                                        adjustsWidth:YES
                                        cornerRadius:0
                                                text:nil];
    self.userPhoneLabel.font = [UIFont boldSystemFontOfSize:MIDDLE_FONT_SIZE];
    [self.userPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userNameLabel.right).offset(20);
        make.centerY.mas_equalTo(self.userNameLabel);
        make.width.mas_equalTo(100);
    }];
    
    self.addressStrLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                        textAlignment:0
                                            textColor:@"#000000"
                                         adjustsWidth:NO
                                         cornerRadius:0
                                                 text:nil];
    self.addressStrLabel.numberOfLines = 2;
    [self.addressStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userNameLabel);
        make.right.mas_equalTo(-30);
        make.top.mas_equalTo(self.userNameLabel.bottom).offset(15);
    }];
}

#pragma mark - reload
- (void)bindViewModel:(OrderDetailAddressCellViewModel *)vm
{
    self.userNameLabel.text = vm.receiver;
    // 手机号加密显示
    if (vm.receiver_mobile.length == 11) {
        if (vm.showWholePhoneNumber) {
            self.userPhoneLabel.text = vm.receiver_mobile;
        }else{
            self.userPhoneLabel.text = [vm.receiver_mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        }
    }else{
        self.userPhoneLabel.text = vm.receiver_mobile;
    }
    self.addressStrLabel.text = vm.receiver_address_detail;
}

@end
