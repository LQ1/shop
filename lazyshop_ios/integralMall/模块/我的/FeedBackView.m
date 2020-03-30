//
//  FeedBackView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "FeedBackView.h"

#import "LYTextView.h"
#import "LYMainColorButton.h"
#import "FeedBackTypeSwitchView.h"
#import "CDELPhoneTextField.h"
#import "FeedBackViewModel.h"

@interface FeedBackView()

@property (nonatomic,strong)FeedBackTypeSwitchView *swichView;
@property (nonatomic,strong)LYTextView *inputView;
@property (nonatomic,strong)UITextField *phoneNumTextField;
@property (nonatomic,strong)LYMainColorButton *submitBtn;
@property (nonatomic,strong)CDELPhoneTextField *phoneTextField;

@property (nonatomic,strong)FeedBackViewModel *viewModel;

@end

@implementation FeedBackView

- (instancetype)initWithViewModel:(FeedBackViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        [self addViews];
        [self bindSignal];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *tipLabel = [self addLabelWithFontSize:LARGE_FONT_SIZE
                                     textAlignment:0
                                         textColor:@"#000000"
                                      adjustsWidth:NO
                                      cornerRadius:0
                                              text:@"反馈问题类型"];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(17.5);
    }];
    
    // 列表
    self.swichView = [[FeedBackTypeSwitchView alloc] initWithHeight:34];
    [self addSubview:self.swichView];
    [self.swichView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(tipLabel.bottom).offset(9);
        make.height.mas_equalTo(34);
    }];
    [self.swichView reloadDataWithItemViewModels:[self.viewModel fetchSwitchViewModels]];
    
    // 输入框
    self.inputView = [[LYTextView alloc] initWithPlaceHolder:@"反馈内容不能超过500个字哦"];
    self.inputView.backgroundColor = [CommUtls colorWithHexString:@"#f6f9f9"];
    [self addSubview:self.inputView];
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.swichView.bottom).offset(15);
        make.height.mas_equalTo(150);
    }];
    
    // 分割
    UIView *gap1 = [UIView new];
    gap1.backgroundColor = [CommUtls colorWithHexString:@"#f6f9f9"];
    [self addSubview:gap1];
    [gap1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(self.inputView.bottom).offset(15);
    }];
    
    // 手机号
    UILabel *phoneTipLabel = [self addLabelWithFontSize:LARGE_FONT_SIZE
                                          textAlignment:0
                                              textColor:@"#333333"
                                           adjustsWidth:NO
                                           cornerRadius:0
                                                   text:@"手机号"];
    [self addSubview:phoneTipLabel];
    [phoneTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(gap1.bottom).offset(25);
        make.width.mas_equalTo(50);
    }];
    
    self.phoneTextField              = [CDELPhoneTextField new];
    self.phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    self.phoneTextField.font = [UIFont systemFontOfSize:MIDDLE_FONT_SIZE];
    self.phoneTextField.textColor = [CommUtls colorWithHexString:@"#333333"];
    self.phoneTextField.placeholder  = @"请输入手机号";
    [self addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneTipLabel.right).offset(12.5);
        make.centerY.mas_equalTo(phoneTipLabel);
        make.right.mas_equalTo(-15);

    }];
    
    self.phoneTextField.text = SignInUser.mobilePhone;
    self.viewModel.phoneNumber = SignInUser.mobilePhone;
    self.phoneTextField.isTrue = YES;
    
    // 底部灰色
    UIView *gap2View = [UIView new];
    gap2View.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    [self addSubview:gap2View];
    [gap2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(gap1.bottom).offset(50);
    }];
    
    // 提交按钮
    self.submitBtn = [[LYMainColorButton alloc] initWithTitle:@"提交"
                                               buttonFontSize:20
                                                 cornerRadius:3];
    [self addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(gap2View.top).offset(iPhone4?5:50);
        make.height.mas_equalTo(45);
    }];
    @weakify(self);
    self.submitBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        if (!self.inputView.text.length) {
            [DLLoading DLToolTipInWindow:@"请输入反馈内容"];
        }else if (!self.phoneTextField.isTrue){
            [DLLoading DLToolTipInWindow:@"请输入正确的手机号"];
        }else{
            [self.phoneTextField resignFirstResponder];
            [self.inputView resignFirstResponder];
            [self.viewModel submitFeedBack];
        }
        return [RACSignal empty];
    }];
}

#pragma mark -bindSignal
- (void)bindSignal
{
    @weakify(self);
    [[self.inputView rac_textSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self.inputView checkPlaceHolder];
        self.viewModel.content = x;
    }];
    
    [[self.phoneTextField rac_textSignal] subscribeNext:^(id x) {
        @strongify(self);
        self.viewModel.phoneNumber = x;
    }];
}

@end
