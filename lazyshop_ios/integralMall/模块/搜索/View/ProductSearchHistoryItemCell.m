//
//  ProductSearchHistoryItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/22.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ProductSearchHistoryItemCell.h"

#import "ProductSearchHistoryModel.h"

@interface ProductSearchHistoryItemCell()

@property (nonatomic,strong)UILabel *titleLabel;

@end

@implementation ProductSearchHistoryItemCell

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
    self.titleLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                               textAlignment:0
                                                   textColor:@"#666666"
                                                adjustsWidth:NO
                                                cornerRadius:0
                                                        text:nil];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(-15);
    }];
    
    [self.contentView addBottomLine];
}

- (void)bindViewModel:(ProductSearchHistoryModel *)vm
{
    self.titleLabel.text = vm.searchKeyword;
}

@end
