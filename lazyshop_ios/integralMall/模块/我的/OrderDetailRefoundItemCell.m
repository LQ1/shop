//
//  OrderDetailRoundItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/1.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailRefoundItemCell.h"

#import "LYTextColorButton.h"
#import "OrderDetailRefoundItemCellViewModel.h"

@interface OrderDetailRefoundItemCell()

@property (nonatomic,strong)OrderDetailRefoundItemCellViewModel *viewModel;

@end

@implementation OrderDetailRefoundItemCell

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
    LYTextColorButton *refoundBtn = [[LYTextColorButton alloc] initWithTitle:@"申请售后"
                                                              buttonFontSize:MIDDLE_FONT_SIZE
                                                                cornerRadius:3];
    [self.contentView addSubview:refoundBtn];
    [refoundBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(68);
        make.height.mas_equalTo(30);
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(-15);
    }];
    @weakify(self);
    refoundBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self applyRefoundClick];
        return [RACSignal empty];
    }];
}
// 申请退款
- (void)applyRefoundClick
{
    [self.baseClickSignal sendNext:self.viewModel.order_detail_id];
}

#pragma mark -bind
- (void)bindViewModel:(OrderDetailRefoundItemCellViewModel *)vm
{
    self.viewModel = vm;
}

@end
