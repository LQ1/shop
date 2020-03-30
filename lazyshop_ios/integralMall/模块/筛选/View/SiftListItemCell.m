//
//  SiftListItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/21.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SiftListItemCell.h"

#import "SiftListItemViewModel.h"

@interface SiftListItemCell()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIImageView *selectedTipView;

@end

@implementation SiftListItemCell

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
    // 背景
    self.contentView.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    // 文字
    self.titleLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                               textAlignment:0
                                                   textColor:nil
                                                adjustsWidth:NO
                                                cornerRadius:0
                                                        text:nil];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    // 选中标志
    self.selectedTipView  = [self.contentView addImageViewWithImageName:@"筛选对勾"
                                                           cornerRadius:0];
    [self.selectedTipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.contentView addBottomLineWithColorString:@"#eaeaea"];
}

- (void)bindViewModel:(SiftListItemViewModel *)vm
{
    self.titleLabel.text = vm.categorySecondName;
    if (vm.selected) {
        self.titleLabel.textColor = [CommUtls colorWithHexString:@"#e4393c"];
        self.selectedTipView.hidden = NO;
    }else{
        self.titleLabel.textColor = [CommUtls colorWithHexString:@"#000000"];
        self.selectedTipView.hidden = YES;
    }
}

@end
