//
//  ShoppingCartEmptyCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/29.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShoppingCartEmptyCell.h"

#import "LYMainColorButton.h"

@implementation ShoppingCartEmptyCell

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
    self.contentView.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    
    UIImageView *tipView = [self.contentView addImageViewWithImageName:@"购物车空"
                                                          cornerRadius:0];
    [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(90);
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(45);
    }];
    
    UILabel *tipLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                 textAlignment:NSTextAlignmentCenter
                                                     textColor:@"#999999"
                                                  adjustsWidth:NO
                                                  cornerRadius:0
                                                          text:@"购物车空空如也"];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tipView.bottom).offset(13);
        make.centerX.mas_equalTo(tipView);
    }];
    
    LYMainColorButton *btn = [[LYMainColorButton alloc] initWithTitle:@"随便逛逛"
                                                       buttonFontSize:LARGE_FONT_SIZE
                                                         cornerRadius:5];
    [self.contentView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(33);
        make.centerX.mas_equalTo(tipLabel);
        make.top.mas_equalTo(tipLabel.bottom).offset(32.5);
    }];
    @weakify(self);
    btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.baseClickSignal sendNext:nil];
        return [RACSignal empty];
    }];
}

- (void)bindViewModel:(id)vm
{
    
}

@end
