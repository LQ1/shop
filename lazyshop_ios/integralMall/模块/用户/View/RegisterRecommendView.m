//
//  RegisterRecommendView.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/5/29.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "RegisterRecommendView.h"

#import "LYImageCheckBox.h"
#import <DLUIKit/CDELPhoneTextField.h>

@interface RegisterRecommendView ()

@property (nonatomic, strong) LYImageCheckBox *noneCheckBox;
@property (nonatomic, strong) LYImageCheckBox *sellerCheckBox;
@property (nonatomic, strong) LYImageCheckBox *userCheckBox;
@property (nonatomic, strong) CDELPhoneTextField *phoneTextField;

@property (nonatomic, assign) choiceRecommederType recommederType;
@property (nonatomic, copy) NSString *recommenderPhone;

@end

@implementation RegisterRecommendView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addViews];
        [self bindSignal];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // 是否有推荐人
    UILabel *tipLabel = [UILabel new];
    tipLabel.font = [UIFont systemFontOfSize:MIDDLE_FONT_SIZE];
    tipLabel.textColor = [CommUtls colorWithHexString:@"#000000"];
    tipLabel.text = @"是否有推荐人";
    [self addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(5);
    }];
    
    CGFloat boxWidth = 20.;
    CGFloat boxTitleGap = PhoneSmallWidth?5.:12.;
    CGFloat boxGap = PhoneSmallWidth?15.:25.;
    // 复选框 无
    self.noneCheckBox = [[LYImageCheckBox alloc] initWithCheckedImageName:@"注册对勾"
                                                         unCheckedImageName:nil
                                                                  bordColor:[CommUtls colorWithHexString:@"#000000"]
                                                                  bordWidth:1.];
    [self addSubview:self.noneCheckBox];
    [self.noneCheckBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(boxWidth);
        make.left.mas_equalTo(tipLabel.right).offset(boxGap);
        make.centerY.mas_equalTo(tipLabel);
    }];
    // 提示 无
    UILabel *noneLabel = [UILabel new];
    noneLabel.font = [UIFont systemFontOfSize:SMALL_FONT_SIZE];
    noneLabel.textColor = [CommUtls colorWithHexString:@"#000000"];
    noneLabel.text = @"无";
    [self addSubview:noneLabel];
    [noneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.noneCheckBox.right).offset(boxTitleGap);
        make.centerY.mas_equalTo(tipLabel);
    }];

    // 复选框 店员
    self.sellerCheckBox = [[LYImageCheckBox alloc] initWithCheckedImageName:@"注册对勾"
                                                         unCheckedImageName:nil
                                                                  bordColor:[CommUtls colorWithHexString:@"#000000"]
                                                                  bordWidth:1.];
    [self addSubview:self.sellerCheckBox];
    [self.sellerCheckBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(boxWidth);
        make.left.mas_equalTo(noneLabel.right).offset(boxGap);
        make.centerY.mas_equalTo(tipLabel);
    }];
    // 提示 店员
    UILabel *sellerLabel = [UILabel new];
    sellerLabel.font = [UIFont systemFontOfSize:SMALL_FONT_SIZE];
    sellerLabel.textColor = [CommUtls colorWithHexString:@"#000000"];
    sellerLabel.text = @"店员";
    [self addSubview:sellerLabel];
    [sellerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.sellerCheckBox.right).offset(boxTitleGap);
        make.centerY.mas_equalTo(tipLabel);
    }];
    
    // 复选框 用户
    self.userCheckBox = [[LYImageCheckBox alloc] initWithCheckedImageName:@"注册对勾"
                                                       unCheckedImageName:nil
                                                                bordColor:[CommUtls colorWithHexString:@"#000000"]
                                                                bordWidth:1.];
    [self addSubview:self.userCheckBox];
    [self.userCheckBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(boxWidth);
        make.left.mas_equalTo(sellerLabel.right).offset(boxGap);
        make.centerY.mas_equalTo(sellerLabel);
    }];
    // 提示 用户
    UILabel *userLabel = [UILabel new];
    userLabel.font = [UIFont systemFontOfSize:SMALL_FONT_SIZE];
    userLabel.textColor = [CommUtls colorWithHexString:@"#000000"];
    userLabel.text = @"用户";
    [self addSubview:userLabel];
    [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userCheckBox.right).offset(boxTitleGap);
        make.centerY.mas_equalTo(tipLabel);
    }];
    
    // 输入推荐人
    self.phoneTextField              = [CDELPhoneTextField new];
    self.phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    self.phoneTextField.font = [UIFont systemFontOfSize:MIDDLE_FONT_SIZE];
    self.phoneTextField.textColor = [CommUtls colorWithHexString:@"#333333"];
    self.phoneTextField.placeholder  = @"请输入推荐人手机码";
    [self addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tipLabel.bottom).offset(18);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = [CommUtls colorWithHexString:@"#a6a6a6"];
    [self.phoneTextField addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.phoneTextField);
        make.height.mas_equalTo(1);
    }];
    
    // 默认选择无
    self.noneCheckBox.checked = YES;
    self.phoneTextField.hidden = YES;
}

#pragma mark -信号绑定
- (void)bindSignal
{
    // 输入框双向反绑定
    @weakify(self);
    [self.noneCheckBox.clickSignal subscribeNext:^(id x) {
        @strongify(self);
        if (!self.noneCheckBox.checked) {
            self.phoneTextField.hidden = YES;
            self.noneCheckBox.checked = YES;
            self.sellerCheckBox.checked = NO;
            self.userCheckBox.checked = NO;
            self.phoneTextField.text = nil;
            self.recommenderPhone = nil;
            self.recommederType = choiceRecommederType_None;
        }
    }];
    [self.sellerCheckBox.clickSignal subscribeNext:^(id x) {
        @strongify(self);
        if (!self.sellerCheckBox.checked) {
            self.phoneTextField.hidden = NO;
            self.noneCheckBox.checked = NO;
            self.sellerCheckBox.checked = YES;
            self.userCheckBox.checked = NO;
            if (self.phoneTextField.text.length) {
                self.recommederType = choiceRecommederType_Seller;
            }else{
                self.recommederType = choiceRecommederType_None;
            }
        }
    }];
    [self.userCheckBox.clickSignal subscribeNext:^(id x) {
        @strongify(self);
        if (!self.userCheckBox.checked) {
            self.phoneTextField.hidden = NO;
            self.noneCheckBox.checked = NO;
            self.sellerCheckBox.checked = NO;
            self.userCheckBox.checked = YES;
            if (self.phoneTextField.text.length) {
                self.recommederType = choiceRecommederType_User;
            }else{
                self.recommederType = choiceRecommederType_None;
            }
        }
    }];

    // 推荐人手机号
    [[self.phoneTextField rac_newTextChannel] subscribeNext:^(id x) {
        @strongify(self);
        self.recommenderPhone = x;
        if (self.recommenderPhone.length) {
            if (self.userCheckBox.checked) {
                self.recommederType = choiceRecommederType_User;
            }else{
                self.recommederType = choiceRecommederType_Seller;
            }
        }else{
            self.recommederType = choiceRecommederType_None;
        }
    }];
}

#pragma mark -高度
- (CGFloat)fetchHeight
{
    return 80.;
}

#pragma mark -放弃第一响应
- (void)endEdit
{
    [self.phoneTextField resignFirstResponder];
}

@end
