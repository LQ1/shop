//
//  GoodsDetailPramsChooseCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/15.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailPramsChooseCell.h"

#import "GoodsDetailPramsDetailViewModel.h"

@interface GoodsDetailPramsChooseCell()

@property (nonatomic,strong)UILabel *pramsDescLabel;

@end

@implementation GoodsDetailPramsChooseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addViews];
    }
    return self;
}

- (void)addViews
{
    self.pramsDescLabel = [self addLabelWithFontSize:MIDDLE_FONT_SIZE
                                       textAlignment:0
                                           textColor:@"#333333"
                                        adjustsWidth:NO
                                        cornerRadius:0
                                                text:nil];
    [self.pramsDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftTitleLabel.right);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

- (void)bindViewModel:(GoodsDetailPramsDetailViewModel *)vm
{
    self.rightMoreBtn.hidden = vm.isActivity;

    self.leftTitleLabel.text = @"已选";
    self.pramsDescLabel.text = [vm disPlayTitle];
}

@end
