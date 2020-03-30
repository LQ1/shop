//
//  ConfirmOrderListBottomView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/28.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ConfirmOrderListBottomView.h"

#import "ConfirmOrderViewModel.h"

@interface ConfirmOrderListBottomView()

@property (nonatomic,strong)UIButton *payButton;
@property (nonatomic,strong)UILabel *payMsgLabel;

@property (nonatomic,strong)ConfirmOrderViewModel *viewModel;

@end

@implementation ConfirmOrderListBottomView

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
    self.backgroundColor = [UIColor whiteColor];
    
    self.payButton = [UIButton new];
    self.payButton.backgroundColor = [CommUtls colorWithHexString:APP_MainColor];
    self.payButton.titleLabel.font = [UIFont systemFontOfSize:SMALL_FONT_SIZE];
    [self addSubview:self.payButton];
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(0);
        make.width.mas_equalTo(95);
    }];
    @weakify(self);
    self.payButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.viewModel gotoPaymentList];
        return [RACSignal empty];
    }];
    
    self.payMsgLabel = [UILabel new];
    self.payMsgLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.payMsgLabel];
    [self.payMsgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.payButton.left).offset(-25);
        make.centerY.mas_equalTo(self);
    }];
}

#pragma mark -reload
- (void)reloadDataWithViewModel:(ConfirmOrderViewModel *)viewModel
{
    self.viewModel = viewModel;
    NSString *tipString = (viewModel.goods_type == GoodsDetailType_Store ? @"总积分":@"总金额");
    NSString *prefixString = [NSString stringWithFormat:@"共%ld件,%@: ",(long)viewModel.productTotalCount,tipString];
    NSString *subfixString = viewModel.productTotalPrice;
    NSString *contentString = [prefixString stringByAppendingString:subfixString];
    self.payMsgLabel.attributedText = [CommUtls changeText:subfixString
                                                   content:contentString
                                            changeTextFont:[UIFont systemFontOfSize:MIDDLE_FONT_SIZE]
                                                  textFont:[UIFont systemFontOfSize:MIDDLE_FONT_SIZE]
                                           changeTextColor:[CommUtls colorWithHexString:APP_MainColor]
                                                 textColor:[CommUtls colorWithHexString:@"#333333"]];
    NSString *btnTitle = @"";
    if (viewModel.goods_type == GoodsDetailType_Store) {
        btnTitle = @"立即下单";
    }else{
        btnTitle = [NSString stringWithFormat:@"去结算(%ld)",(long)viewModel.productTotalCount];
    }
    [self.payButton setTitle:btnTitle forState:UIControlStateNormal];
}

@end
