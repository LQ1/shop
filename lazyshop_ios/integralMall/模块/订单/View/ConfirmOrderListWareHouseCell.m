//
//  ConfirmOrderListWareHouseCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/3.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "ConfirmOrderListWareHouseCell.h"

#import "ConfirmOrderListWareHouseCellViewModel.h"

@interface ConfirmOrderListWareHouseCell()

@property (nonatomic,strong)UILabel *wareHouseNameLabel;

@end

@implementation ConfirmOrderListWareHouseCell

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
    // 选择取货仓
    UILabel *tipLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                 textAlignment:0
                                                     textColor:@"#333333"
                                                  adjustsWidth:NO
                                                  cornerRadius:0
                                                          text:@"选择配送方式"];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    self.wareHouseNameLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                       textAlignment:NSTextAlignmentRight
                                                           textColor:@"#666666"
                                                        adjustsWidth:NO
                                                        cornerRadius:0
                                                                text:nil];
    [self.wareHouseNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.rightArrowView.left).offset(-10);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.contentView addBottomLine];
}

#pragma mark -reload
- (void)bindViewModel:(ConfirmOrderListWareHouseCellViewModel *)vm
{
    self.wareHouseNameLabel.text = vm.wareHouseName;
}


@end
