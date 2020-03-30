//
//  ShippingAddressEidtView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShippingAddressEidtView.h"

#import "ShippingAddressEditBottomLineView.h"
#import "LYTextField.h"
#import "LYTextView.h"
#import "LYMainColorButton.h"

#import "ChooseLocationView.h"

#import "ShippingAddressEidtViewModel.h"

@interface ShippingAddressEidtView()

@property (nonatomic,strong)LYTextField *userNameTextField;
@property (nonatomic,strong)LYTextField *phoneNumberTextField;
@property (nonatomic,strong)UILabel *areaLabel;
@property (nonatomic,strong)LYTextView *addressDeailTextView;

@property (nonatomic,strong)ShippingAddressEidtViewModel *viewModel;

@end

@implementation ShippingAddressEidtView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.backgroundColor = [CommUtls colorWithHexString:@"#eeeeee"];
    
    CGFloat baseRowHeight = 47.5f;
    
    ShippingAddressEditBottomLineView *userNameContentView = [ShippingAddressEditBottomLineView new];
    [self addSubview:userNameContentView];
    [userNameContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(baseRowHeight);
    }];
    self.userNameTextField = [[LYTextField alloc] initWithStyle:LYTextFieldStyle_Name
                                                    placeHolder:@"收货人姓名(2-15)字"];
    [userNameContentView addSubview:self.userNameTextField];
    [self.userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.bottom.mas_equalTo(userNameContentView);
    }];
    
    ShippingAddressEditBottomLineView *phoneNumberContentView = [ShippingAddressEditBottomLineView new];
    [self addSubview:phoneNumberContentView];
    [phoneNumberContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(userNameContentView.bottom);
        make.height.mas_equalTo(baseRowHeight);
    }];
    self.phoneNumberTextField = [[LYTextField alloc] initWithStyle:LYTextFieldStyle_Phone
                                                       placeHolder:@"电话号码"];
    [phoneNumberContentView addSubview:self.phoneNumberTextField];
    [self.phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.bottom.mas_equalTo(phoneNumberContentView);
    }];

    ShippingAddressEditBottomLineView *areaContentView = [ShippingAddressEditBottomLineView new];
    [self addSubview:areaContentView];
    [areaContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(phoneNumberContentView.bottom);
        make.height.mas_equalTo(baseRowHeight);
    }];
    UIImage *rightArrowImage = [UIImage imageNamed:@"编辑收货地址箭头"];
    UIImageView *rightArrowView = [[UIImageView alloc] initWithImage:rightArrowImage];
    [areaContentView addSubview:rightArrowView];
    [rightArrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(areaContentView);
        make.width.mas_equalTo(rightArrowImage.size.width);
        make.height.mas_equalTo(rightArrowImage.size.height);
    }];
    UILabel *areaTipLabel = [areaContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                    textAlignment:0
                                                        textColor:@"#333333"
                                                     adjustsWidth:NO
                                                     cornerRadius:0
                                                             text:@"所在地区"];
    [areaTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(areaContentView);
    }];
    self.areaLabel = [areaContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                             textAlignment:NSTextAlignmentRight
                                                 textColor:@"#333333"
                                              adjustsWidth:NO
                                              cornerRadius:0
                                                      text:nil];
    [self.areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(areaTipLabel.right).offset(5);
        make.right.mas_equalTo(rightArrowView.left).offset(-10);
        make.centerY.mas_equalTo(areaContentView);
    }];
    // 选择所在地址
    UIButton *clickBtn = [UIButton new];
    [areaContentView addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    @weakify(self);
    clickBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self selectArea];
        [self endEditting];
        return [RACSignal empty];
    }];
    
    UIView *addressContentView = [UIView new];
    addressContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:addressContentView];
    [addressContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(115);
        make.top.mas_equalTo(areaContentView.bottom);
    }];
    self.addressDeailTextView = [[LYTextView alloc] initWithPlaceHolder:@"详细地址(5-20字)"];
    [addressContentView addSubview:self.addressDeailTextView];
    [self.addressDeailTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(17.5);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-17.5);
    }];
    
    LYMainColorButton *bottomButton = [[LYMainColorButton alloc] initWithTitle:@"保存"
                                                                buttonFontSize:20
                                                                  cornerRadius:3];
    [self addSubview:bottomButton];
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(addressContentView.bottom).offset(iPhone4?10:50);
        make.height.mas_equalTo(45);
    }];
    bottomButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self saveClick];
        return [RACSignal empty];
    }];
}

- (void)selectArea
{
    ChooseLocationView *areaPicker = [[ChooseLocationView alloc] initWithFrame:CGRectMake(0, KScreenHeight-400, KScreenWidth, 400)];
    areaPicker.backgroundColor = [UIColor whiteColor];
    [areaPicker bindViewModel:self.viewModel];
    [DLAlertShowAnimate showInView:self
                         alertView:areaPicker
                         popupMode:View_Popup_Mode_Down
                           bgAlpha:.5
                  outsideDisappear:YES];
}

- (void)saveClick
{
    [self endEditting];
    [self.viewModel savaAddress];
}

- (void)endEditting
{
    [self.userNameTextField resignFirstResponder];
    [self.phoneNumberTextField resignFirstResponder];
    [self.addressDeailTextView resignFirstResponder];
}

- (void)reloadDataWithViewModel:(ShippingAddressEidtViewModel *)viewModel
{
    self.viewModel = viewModel;
    // 输入框和VM双向绑定
    RACChannelTerminal *modelValue1Terminal = RACChannelTo(self.viewModel,addressUserName);
    RACChannelTerminal *fieldValue1Terminal = [self.userNameTextField rac_newTextChannel];
    [modelValue1Terminal subscribe:fieldValue1Terminal];
    [fieldValue1Terminal subscribe:modelValue1Terminal];
    
    RACChannelTerminal *modelValue2Terminal = RACChannelTo(self.viewModel,addressPhoneNumber);
    RACChannelTerminal *fieldValue2Terminal = [self.phoneNumberTextField rac_newTextChannel];
    [modelValue2Terminal subscribe:fieldValue2Terminal];
    [fieldValue2Terminal subscribe:modelValue2Terminal];
    
    @weakify(self);
    [RACObserve(self.viewModel, adressAreaName) subscribeNext:^(id x) {
        @strongify(self);
        self.areaLabel.text = x;
    }];
    
    self.addressDeailTextView.text = self.viewModel.addressDetail;
    [[self.addressDeailTextView rac_textSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self.addressDeailTextView checkPlaceHolder];
        self.viewModel.addressDetail = x;
    }];
}

@end
