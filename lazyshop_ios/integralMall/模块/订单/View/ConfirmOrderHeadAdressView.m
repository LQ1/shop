//
//  ConfirmOrderHeadAdressView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ConfirmOrderHeadAdressView.h"

#import "ConfirmOrderViewModel.h"

@interface ConfirmOrderHeadAdressView()

@property (nonatomic,strong)UILabel *userNameLabel;
@property (nonatomic,strong)UILabel *userPhoneLabel;
@property (nonatomic,strong)UILabel *defaultAdressTipLabel;
@property (nonatomic,strong)UILabel *addressStrLabel;

@property (nonatomic,strong)UILabel *noAdressTipLabel;

@property (nonatomic,strong)ConfirmOrderViewModel *viewModel;

@end

@implementation ConfirmOrderHeadAdressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _clickSignal = [[RACSubject subject] setNameWithFormat:@"%@ clickSignal", self.class];
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.backgroundColor = [UIColor whiteColor];
    // 位置标志
    UIImage *addressImage = [UIImage imageNamed:@"收货地址"];
    UIImageView *addressTipView = [[UIImageView alloc] initWithImage:addressImage];
    [self addSubview:addressTipView];
    [addressTipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(addressImage.size.width);
        make.height.mas_equalTo(addressImage.size.height);
    }];
    
    // 姓名
    self.userNameLabel = [self addLabelWithFontSize:MIDDLE_FONT_SIZE
                                      textAlignment:0
                                          textColor:@"#000000"
                                       adjustsWidth:NO
                                       cornerRadius:0
                                               text:nil];
    self.userNameLabel.font = [UIFont boldSystemFontOfSize:MIDDLE_FONT_SIZE];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(addressTipView.right).offset(10);
        make.top.mas_equalTo(15);
        make.width.mas_equalTo(58);
    }];
    
    // 手机号
    self.userPhoneLabel = [self addLabelWithFontSize:MIDDLE_FONT_SIZE
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
    
    // 默认地址标识
    self.defaultAdressTipLabel = [self addLabelWithFontSize:SMALL_FONT_SIZE
                                              textAlignment:NSTextAlignmentCenter
                                                  textColor:APP_MainColor
                                               adjustsWidth:NO
                                               cornerRadius:2
                                                       text:@"默认"];
    self.defaultAdressTipLabel.layer.borderWidth = 1;
    self.defaultAdressTipLabel.layer.borderColor = [CommUtls colorWithHexString:APP_MainColor].CGColor;
    [self.defaultAdressTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(15);
        make.left.mas_equalTo(self.userPhoneLabel.right).offset(5);
        make.centerY.mas_equalTo(self.userPhoneLabel.centerY);
    }];
    
    // 编辑箭头
    UIImage *rightArrowImage = [UIImage imageNamed:@"编辑收货地址箭头"];
    UIImageView *rightArrowView = [[UIImageView alloc] initWithImage:rightArrowImage];
    [self addSubview:rightArrowView];
    [rightArrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(rightArrowImage.size.width);
        make.height.mas_equalTo(rightArrowImage.size.height);
    }];
    
    // 无收货地址提示
    self.noAdressTipLabel = [self addLabelWithFontSize:MIDDLE_FONT_SIZE
                                         textAlignment:NSTextAlignmentRight
                                             textColor:@"#999999"
                                          adjustsWidth:NO
                                          cornerRadius:0
                                                  text:@"请选择收货地址"];
    [self.noAdressTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(rightArrowView.left).offset(-20);
        make.centerY.mas_equalTo(rightArrowView);
    }];
    self.noAdressTipLabel.hidden = YES;

    // 地址
    self.addressStrLabel = [self addLabelWithFontSize:SMALL_FONT_SIZE
                                        textAlignment:0
                                            textColor:@"#000000"
                                         adjustsWidth:NO
                                         cornerRadius:0
                                                 text:nil];
    self.addressStrLabel.numberOfLines = 2;
    [self.addressStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userNameLabel);
        make.right.mas_equalTo(rightArrowView.left).offset(-16.5);
        make.top.mas_equalTo(self.userNameLabel.bottom).offset(15);
    }];
    
    // 底部线
    UIEdgeInsets edge=UIEdgeInsetsMake(1, 5, 1, 5);
    UIImageView *bottomLineView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"地址边框"] resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch]];
    [self addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(2.5);
    }];
    
    UIButton *clickBtn = [UIButton new];
    [self addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    @weakify(self);
    clickBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.clickSignal sendNext:nil];
        return [RACSignal empty];
    }];
}

#pragma mark - reload
- (void)reloadDataWithViewModel:(ConfirmOrderViewModel *)viewModel
{
    self.viewModel = viewModel;
    
    self.userNameLabel.text = viewModel.userName;
    // 手机号加密显示
    if (viewModel.userPhone.length == 11) {
        self.userPhoneLabel.text = [viewModel.userPhone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }else{
        self.userPhoneLabel.text = viewModel.userPhone;
    }
    self.defaultAdressTipLabel.hidden = !viewModel.userDefaulAdress;
    self.addressStrLabel.text = viewModel.adressContent;
    // 是否显示选择收货地址
    if ([self.viewModel.user_address_id integerValue]>0) {
        self.noAdressTipLabel.hidden = YES;
    }else{
        self.noAdressTipLabel.hidden = NO;
    }
}

@end
