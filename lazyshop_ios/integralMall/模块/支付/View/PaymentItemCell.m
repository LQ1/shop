//
//  PaymentItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/30.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "PaymentItemCell.h"

#import <CheckBoxButton.h>
#import "PaymentItemCellViewModel.h"

@interface PaymentItemCell()

@property (nonatomic,strong)UIImageView *paymentImageView;
@property (nonatomic,strong)UILabel *paymentTitleLabel;
@property (nonatomic,strong)UILabel *paymentDescLabel;
@property (nonatomic,strong)CheckBoxButton *checkBox;


@end

@implementation PaymentItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

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
    self.paymentImageView = [self.contentView addImageViewWithImageName:nil
                                                           cornerRadius:0];
    [self.paymentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(27);
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    self.paymentImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.paymentTitleLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                      textAlignment:0
                                                          textColor:@"#000000"
                                                       adjustsWidth:NO
                                                       cornerRadius:0
                                                               text:nil];
    [self.paymentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.paymentImageView.right).offset(10);
        make.top.mas_equalTo(14);
    }];
    
    self.paymentDescLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                     textAlignment:0
                                                         textColor:@"#d5d5d5"
                                                      adjustsWidth:NO
                                                      cornerRadius:0
                                                              text:nil];
    [self.paymentDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.paymentTitleLabel);
        make.top.mas_equalTo(self.paymentTitleLabel.bottom).offset(5);
    }];
    
    self.checkBox = [[CheckBoxButton alloc] initWithFrame:CGRectMake(0, 0, 17, 17)
                                            checkImgeWith:[UIImage imageNamed:@"选择收货地址未选中"]
                                          checkedImgeWith:[UIImage imageNamed:@"默认地址选中"] selectCheckedWith:NO];
    [self addSubview:self.checkBox];
    self.checkBox.userInteractionEnabled = NO;
    [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.width.height.mas_equalTo(17);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.contentView addBottomLine];
}

- (void)bindViewModel:(PaymentItemCellViewModel *)vm
{
    self.paymentImageView.image = [UIImage imageNamed:vm.paymentImageName];
    self.paymentTitleLabel.text = vm.paymentTitle;
    self.paymentDescLabel.text = vm.paymentDesc;
    self.checkBox.checked = vm.selected;
    if (vm.payMentType == PayMentType_ShopPay) {
        [self.paymentTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.paymentImageView.right).offset(10);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }else{
        [self.paymentTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.paymentImageView.right).offset(10);
            make.top.mas_equalTo(14);
        }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
