//
//  ProductRowBaseCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/23.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ProductRowBaseCell.h"

#import "ProductRowBaseCellViewModel.h"

@implementation ProductRowBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _clickSignal = [[RACSubject subject] setNameWithFormat:@"%@ clickSignal", self.class];

        self.productImageView = [self.contentView addImageViewWithImageName:nil
                                                               cornerRadius:0];
        [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(80);
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        // 可配置文案
        self.sloganLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                    textAlignment:NSTextAlignmentCenter
                                                        textColor:APP_MainColor
                                                     adjustsWidth:YES
                                                     cornerRadius:3
                                                             text:nil];
        self.sloganLabel.layer.borderColor = [CommUtls colorWithHexString:APP_MainColor].CGColor;
        self.sloganLabel.layer.borderWidth = 1;
        self.sloganLabel.adjustsFontSizeToFitWidth = YES;
        [self.sloganLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(17);
            make.width.mas_equalTo(42);
            make.left.mas_equalTo(self.productImageView.right).offset(10);
            make.bottom.mas_equalTo(self.productImageView.bottom);
        }];

        
        self.productPriceLabel = [self.contentView addLabelWithFontSize:LARGE_FONT_SIZE
                                                          textAlignment:0
                                                              textColor:@"#ff1600"
                                                           adjustsWidth:YES
                                                           cornerRadius:0
                                                                   text:nil];
        self.productPriceLabel.font = [UIFont boldSystemFontOfSize:LARGE_FONT_SIZE];
        [self.productPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.sloganLabel);
            make.bottom.mas_equalTo(self.sloganLabel.top).offset(-5);
            make.width.mas_equalTo(55);
        }];
        
        self.productNameLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                         textAlignment:0
                                                             textColor:@"#000000"
                                                          adjustsWidth:NO
                                                          cornerRadius:0
                                                                  text:nil];
        self.productNameLabel.numberOfLines = 2;
        [self.productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productImageView.right).offset(10);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self.productImageView.top);
        }];
        
        // 立即抢购
        self.panicBuyButton = [UIButton new];
        self.panicBuyButton.layer.cornerRadius = 3;
        self.panicBuyButton.layer.masksToBounds = YES;
        self.panicBuyButton.titleLabel.font = [UIFont systemFontOfSize:SMALL_FONT_SIZE];
        self.panicBuyButton.backgroundColor = [CommUtls colorWithHexString:APP_MainColor];
        [self.contentView addSubview:self.panicBuyButton];
        [self.panicBuyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20);
            make.bottom.right.mas_equalTo(-15);
        }];
        @weakify(self);
        self.panicBuyButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            [self.clickSignal sendNext:nil];
            return [RACSignal empty];
        }];
        
        [self.contentView addBottomLine];
    }
    return self;
}

- (void)bindViewModel:(ProductRowBaseCellViewModel *)vm
{
    [self.productImageView ly_showMidImg:vm.productImageUrl];
    self.productNameLabel.text = vm.productName;
    self.productPriceLabel.text = [NSString stringWithFormat:@"¥ %@",vm.productPrice];
    if (vm.slogan.length&&[LYAppCheckManager shareInstance].isAppAgree) {
        self.sloganLabel.hidden = NO;
        self.sloganLabel.text = [NSString stringWithFormat:@" %@ ",vm.slogan];
    }else{
        self.sloganLabel.hidden = YES;
    }
}

@end
