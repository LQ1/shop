//
//  ConfirmOrderListIntegralCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/27.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ConfirmOrderListIntegralCell.h"

#import "ConfirmOrderListIntegralCellViewModel.h"

@interface ConfirmOrderListIntegralCell()

@property (nonatomic,strong)ConfirmOrderListIntegralCellViewModel *viewModel;

@property (nonatomic,strong)UILabel *supportIntegralLabel;
@property (nonatomic,strong)UILabel *unSupportIntegralLabel;
@property (nonatomic,strong)UILabel *subMoneyLabel;

@end

@implementation ConfirmOrderListIntegralCell

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
    // 使用懒店积分 (10积分=1元)
    self.supportIntegralLabel = [UILabel new];
    NSString *changeString = @"(10积分=1元)";
    NSString *prefixStting = @"使用懒店积分 ";
    NSString *contentString = [prefixStting stringByAppendingString:changeString];
    self.supportIntegralLabel.attributedText = [CommUtls changeText:changeString
                                                            content:contentString
                                                     changeTextFont:[UIFont systemFontOfSize:SMALL_FONT_SIZE]
                                                           textFont:[UIFont systemFontOfSize:MIDDLE_FONT_SIZE]
                                                    changeTextColor:[CommUtls colorWithHexString:@"#000000"]
                                                          textColor:[CommUtls colorWithHexString:@"#333333"]];
    [self.contentView addSubview:self.supportIntegralLabel];
    [self.supportIntegralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    // 不支持使用懒店积分
    self.unSupportIntegralLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                           textAlignment:0
                                                               textColor:@"#333333"
                                                            adjustsWidth:NO
                                                            cornerRadius:0
                                                                    text:@"不支持使用懒店积分"];
    [self.unSupportIntegralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    // -
    self.subMoneyLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                  textAlignment:NSTextAlignmentRight
                                                      textColor:APP_MainColor
                                                   adjustsWidth:NO
                                                   cornerRadius:0
                                                           text:nil];
    [self.subMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.rightArrowView.left).offset(-7.5);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.contentView addBottomLine];
    
    // 点击事件
    UIButton *clickBtn = [UIButton new];
    [self.contentView addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    @weakify(self);
    clickBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self useScore];
        return [RACSignal empty];
    }];
}

// 使用积分
- (void)useScore
{
    if (self.viewModel.supportIntegral) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        
        NSString *maxTip = [NSString stringWithFormat:@"最多支持使用%@积分",self.viewModel.useScore];

        UITextField *txtName = [alert textFieldAtIndex:0];
        txtName.placeholder = maxTip;
        txtName.keyboardType = UIKeyboardTypeNumberPad;
        
        [alert show];
        @weakify(self);
        [alert.rac_buttonClickedSignal subscribeNext:^(id x) {
            @strongify(self);
            if ([txtName.text integerValue]>[self.viewModel.useScore integerValue]) {
                [DLLoading DLToolTipInWindowAlertAfter:maxTip];
            }else{
                self.viewModel.userInputScore = txtName.text;
                [self bindViewModel:self.viewModel];
            }
        }];
    }
}

#pragma mark -reload
- (void)bindViewModel:(ConfirmOrderListIntegralCellViewModel *)vm
{
    self.viewModel = vm;
    
    if (vm.supportIntegral) {
        self.unSupportIntegralLabel.hidden = YES;
        self.supportIntegralLabel.hidden = NO;
        self.subMoneyLabel.hidden = NO;
        self.rightArrowView.hidden = NO;
        if ([vm.userInputScore integerValue]>0) {
            self.subMoneyLabel.hidden = NO;
            self.subMoneyLabel.text = [NSString stringWithFormat:@"-¥ %.2f",[vm.userInputScore integerValue]/10.0];
        }else{
            self.subMoneyLabel.hidden = YES;
        }
    }else{
        self.unSupportIntegralLabel.hidden = NO;
        self.supportIntegralLabel.hidden = YES;
        self.subMoneyLabel.hidden = YES;
        self.rightArrowView.hidden = YES;
    }
}
@end
