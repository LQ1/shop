//
//  SecKillListItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/23.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SecKillListItemCell.h"

#import "SecKillListItemCellViewModel.h"

@interface SecKillListItemCell()

@property (nonatomic,strong ) UILabel *remainNumbersLabel;
@property (nonatomic,strong ) UILabel *noRemainTipLabel;

@end

@implementation SecKillListItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViews];
    }
    return self;
}

- (void)addViews
{
    [self.panicBuyButton setTitle:@"立即抢购" forState:UIControlStateNormal];
    // 剩余多少件
    self.remainNumbersLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                       textAlignment:NSTextAlignmentRight
                                                           textColor:@"#333333"
                                                        adjustsWidth:NO
                                                        cornerRadius:0
                                                                text:nil];
    [self.remainNumbersLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.panicBuyButton.left).offset(-15);
        make.centerY.mas_equalTo(self.panicBuyButton);
    }];
    
    // 已抢完标志
    self.noRemainTipLabel = [self.productImageView addLabelWithFontSize:SMALL_FONT_SIZE
                                                          textAlignment:NSTextAlignmentCenter textColor:@"#ffffff"
                                                           adjustsWidth:NO
                                                           cornerRadius:0
                                                                   text:@"已抢完"];
    self.noRemainTipLabel.backgroundColor = [CommUtls colorWithHexString:@"#595959"];
    [self.noRemainTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(25);
    }];
}

- (void)bindViewModel:(SecKillListItemCellViewModel *)vm
{
    // 基础属性
    [super bindViewModel:vm];
    
    if (vm.isEnd) {
        // 已结束
        self.panicBuyButton.enabled = NO;
        self.panicBuyButton.backgroundColor = [CommUtls colorWithHexString:@"#9a9a9a"];
        [self.panicBuyButton setTitle:@"已结束" forState:UIControlStateNormal];
        self.noRemainTipLabel.hidden = YES;
    }else{
        // 立即抢购按钮
        if (vm.remainNumber>0) {
            self.panicBuyButton.enabled = YES;
            self.panicBuyButton.backgroundColor = [CommUtls colorWithHexString:APP_MainColor];
            self.noRemainTipLabel.hidden = YES;
        }else{
            self.panicBuyButton.enabled = NO;
            self.panicBuyButton.backgroundColor = [CommUtls colorWithHexString:@"#9a9a9a"];
            self.noRemainTipLabel.hidden = NO;
        }
        [self.panicBuyButton setTitle:@"立即抢购" forState:UIControlStateNormal];
    }
    
    // 还剩多少件
    NSString *numberString = [NSString stringWithFormat:@"%ld",(long)vm.remainNumber];
    NSString *contentString = [NSString stringWithFormat:@"还剩余%@件",numberString];
    self.remainNumbersLabel.attributedText = [CommUtls changeText:numberString
                                                          content:contentString
                                                   changeTextFont:[UIFont systemFontOfSize:SMALL_FONT_SIZE]
                                                         textFont:[UIFont systemFontOfSize:SMALL_FONT_SIZE]
                                                  changeTextColor:[CommUtls colorWithHexString:APP_MainColor]
                                                        textColor:[CommUtls colorWithHexString:@"#333333"]];
}

@end
