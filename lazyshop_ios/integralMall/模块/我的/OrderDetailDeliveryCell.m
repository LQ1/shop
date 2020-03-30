//
//  OrderDetailDeliveryCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/8.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailDeliveryCell.h"

#import "OrderDetailDeliveryCellViewModel.h"

#import "DeliveryViewModel.h"

@interface OrderDetailDeliveryCell()

@property (nonatomic,strong)UILabel *deliveryNoLabel;
@property (nonatomic,strong)UILabel *deliveryNameLabel;
@property (nonatomic,strong)OrderDetailDeliveryCellViewModel *viewModel;

@end

@implementation OrderDetailDeliveryCell

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
    // 运单号
    UILabel *deliveryNoTipLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                         textAlignment:0
                                                             textColor:@"#999999"
                                                          adjustsWidth:NO
                                                          cornerRadius:0
                                                                  text:@"运单号:"];
    [deliveryNoTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(12);
        make.width.mas_equalTo(SMALL_FONT_SIZE*5);
    }];
    self.deliveryNoLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                  textAlignment:0
                                                      textColor:@"#999999"
                                                   adjustsWidth:NO
                                                   cornerRadius:0
                                                           text:nil];
    [self.deliveryNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(deliveryNoTipLabel.right);
        make.centerY.mas_equalTo(deliveryNoTipLabel);
    }];
    
    // 快递方式
    UILabel *deliveryNameTipLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                           textAlignment:0
                                                               textColor:@"#999999"
                                                            adjustsWidth:NO
                                                            cornerRadius:0
                                                                    text:@"快递方式:"];
    [deliveryNameTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(deliveryNoTipLabel);
        make.top.mas_equalTo(deliveryNoTipLabel.bottom).offset(7.);
        make.width.mas_equalTo(SMALL_FONT_SIZE*5);
    }];
    
    self.deliveryNameLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                    textAlignment:0
                                                        textColor:@"#999999"
                                                     adjustsWidth:NO
                                                     cornerRadius:0
                                                             text:nil];
    [self.deliveryNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.deliveryNoLabel);
        make.centerY.mas_equalTo(deliveryNameTipLabel);
    }];
    
    UIButton *clickBtn = [UIButton new];
    [self.contentView addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    @weakify(self);
    clickBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self gotoDeliveryTrack];
        return [RACSignal empty];
    }];
}

// 订单追踪
- (void)gotoDeliveryTrack
{
    DeliveryViewModel *vm = [[DeliveryViewModel alloc] initWithDeliver_id:self.viewModel.delivery_id
                                                              delivery_no:self.viewModel.delivery_no];
    [self.baseClickSignal sendNext:vm];
}

#pragma mark -bind
- (void)bindViewModel:(OrderDetailDeliveryCellViewModel *)vm
{
    self.viewModel = vm;
    self.deliveryNoLabel.text = vm.delivery_no;
    self.deliveryNameLabel.text = vm.delivery_name;
}

@end
