//
//  ShippingAddressManageCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/1.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShippingAddressManageCell.h"

#import "LYCheckBoxButton.h"
#import "LYBolderButton.h"
#import "ShippingAddressManageCellViewModel.h"

@interface ShippingAddressManageCell()

@property (nonatomic,strong)CheckBoxButton *checkBox;
@property (nonatomic,strong)UILabel *defualtTipLabel;
@property (nonatomic,strong)LYBolderButton *editButton;
@property (nonatomic,strong)LYBolderButton *deleteButton;

@end

@implementation ShippingAddressManageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _clickSignal = [[RACSubject subject] setNameWithFormat:@"%@ clickSignal", self.class];
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    [self.shippingUserNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(12.5);
    }];
    [self.shippingPhoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
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
    
    UIView *bottomContentView = [UIView new];
    [self.contentView addSubview:bottomContentView];
    [bottomContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(bottomGap.top);
        make.height.mas_equalTo(42.5);
    }];
    [bottomContentView addTopLine];
    
    self.checkBox = [LYCheckBoxButton new];
    self.checkBox.userInteractionEnabled = NO;
    [bottomContentView addSubview:self.checkBox];
    [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.height.mas_equalTo(LYCheckBoxButtonWidth);
        make.centerY.mas_equalTo(bottomContentView);
    }];
    
    self.defualtTipLabel = [bottomContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                     textAlignment:0
                                                         textColor:@"#333333"
                                                      adjustsWidth:NO
                                                      cornerRadius:0
                                                              text:@"设为默认"];
    [self.defualtTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.checkBox.right).offset(7.5);
        make.centerY.mas_equalTo(self.checkBox);
    }];
    
    UIButton *realCheckBtn = [UIButton new];
    [bottomContentView addSubview:realCheckBtn];
    [realCheckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.checkBox);
        make.right.mas_equalTo(self.defualtTipLabel);
        make.top.bottom.mas_equalTo(self.checkBox);
    }];
    @weakify(self);
    realCheckBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.clickSignal sendNext:@(ShippingAddressManageCellClickType_SetDefault)];
        return [RACSignal empty];
    }];
    
    self.deleteButton = [[LYBolderButton alloc] initWithBolderColorString:APP_MainColor
                                                         titleColorString:APP_MainColor
                                                                    title:@"删除"];
    [bottomContentView addSubview:self.deleteButton];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(bottomContentView);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(25);
    }];
    self.deleteButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.clickSignal sendNext:@(ShippingAddressManageCellClickType_Delete)];
        return [RACSignal empty];
    }];
    
    self.editButton = [[LYBolderButton alloc] initWithBolderColorString:@"#333333"
                                                       titleColorString:@"#333333"
                                                                  title:@"编辑"];
    [bottomContentView addSubview:self.editButton];
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.deleteButton.left).offset(-7.5);
        make.centerY.mas_equalTo(bottomContentView);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(25);
    }];
    self.editButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.clickSignal sendNext:@(ShippingAddressManageCellClickType_Edit)];
        return [RACSignal empty];
    }];
}

- (void)bindViewModel:(ShippingAddressManageCellViewModel *)vm
{
    self.shippingUserNameLabel.text = vm.shippingUserName;
    self.shippingPhoneNumberLabel.text = vm.shippingPhoneNumber;
    self.shippingAddressLabel.text = vm.shippingAddress;
    if (vm.isDefault) {
        self.checkBox.checked = YES;
        self.defualtTipLabel.text = @"默认地址";
        self.defualtTipLabel.textColor = [CommUtls colorWithHexString:APP_MainColor];
    }else{
        self.checkBox.checked = NO;
        self.defualtTipLabel.text = @"设为默认";
        self.defualtTipLabel.textColor = [CommUtls colorWithHexString:@"#333333"];
    }
}

@end
