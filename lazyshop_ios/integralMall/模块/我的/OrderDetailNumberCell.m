//
//  ComfirmDetailNumberCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/24.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailNumberCell.h"

#import "LYTextColorButton.h"
#import "OrderDetailNumberCellViewModel.h"

@interface OrderDetailNumberCell()

@property (nonatomic,strong)UILabel *orderNumLabel;
@property (nonatomic,strong)UILabel *createTimeLabel;
@property (nonatomic,strong)OrderDetailNumberCellViewModel *viewModel;

@end

@implementation OrderDetailNumberCell

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
    // 订单编号
    UILabel *orderNumTipLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                         textAlignment:0
                                                             textColor:@"#999999"
                                                          adjustsWidth:NO
                                                          cornerRadius:0
                                                                  text:@"订单编号:"];
    [orderNumTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(12);
        make.width.mas_equalTo(SMALL_FONT_SIZE*5);
    }];
    self.orderNumLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                  textAlignment:0
                                                      textColor:@"#999999"
                                                   adjustsWidth:NO
                                                   cornerRadius:0
                                                           text:nil];
    [self.orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(orderNumTipLabel.right);
        make.centerY.mas_equalTo(orderNumTipLabel);
    }];
    
    // 创建时间
    UILabel *createTimeTipLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                         textAlignment:0
                                                             textColor:@"#999999"
                                                          adjustsWidth:NO
                                                          cornerRadius:0
                                                                  text:@"创建时间:"];
    [createTimeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(orderNumTipLabel);
        make.top.mas_equalTo(orderNumTipLabel.bottom).offset(7.);
        make.width.mas_equalTo(SMALL_FONT_SIZE*5);
    }];

    self.createTimeLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                    textAlignment:0
                                                        textColor:@"#999999"
                                                     adjustsWidth:NO
                                                     cornerRadius:0
                                                             text:nil];
    [self.createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.orderNumLabel);
        make.centerY.mas_equalTo(createTimeTipLabel);
    }];
    // 复制按钮
    LYTextColorButton *copyBtn = [[LYTextColorButton alloc] initWithTitle:@"复制"
                                                           buttonFontSize:MIDDLE_FONT_SIZE
                                                             cornerRadius:3];
    copyBtn.layer.borderColor = [CommUtls colorWithHexString:@"#959595"].CGColor;
    [copyBtn setTitleColor:[CommUtls colorWithHexString:@"#959595"]
                  forState:UIControlStateNormal];
    [self.contentView addSubview:copyBtn];
    [copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(self.orderNumLabel);
    }];
    @weakify(self);
    copyBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self orderNumberCopy];
        return [RACSignal empty];
    }];
}

- (void)orderNumberCopy
{
    if (self.viewModel.order_no.length) {
        self.orderNumLabel.backgroundColor = [UIColor blueColor];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.viewModel.order_no;
        @weakify(self);
        [[[RACSignal interval:.3 onScheduler:[RACScheduler currentScheduler]] take:1] subscribeNext:^(id x) {
            @strongify(self);
            self.orderNumLabel.backgroundColor = [UIColor clearColor];
        }];
    }
}

#pragma mark -bind
- (void)bindViewModel:(OrderDetailNumberCellViewModel *)vm
{
    self.viewModel = vm;
    self.orderNumLabel.text = vm.order_no;
    self.createTimeLabel.text = vm.created_at;
}

@end
