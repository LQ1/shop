//
//  StoreListItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/9.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "StoreListItemCell.h"

#import "StoreListItemViewModel.h"

@interface StoreListItemCell()

@property (nonatomic,strong)UIImageView *storeImageView;
@property (nonatomic,strong)UILabel *storeNameLabel;
@property (nonatomic,strong)UILabel *storeCategoryNameLabel;

@end

@implementation StoreListItemCell

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
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.storeImageView = [self.contentView addImageViewWithImageName:nil
                                                         cornerRadius:0];
    [self.storeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.height.mas_equalTo(80);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    self.storeNameLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                   textAlignment:0
                                                       textColor:@"#000000"
                                                    adjustsWidth:NO
                                                    cornerRadius:0
                                                            text:nil];
    [self.storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.storeImageView.right).offset(10);
        make.top.mas_equalTo(self.storeImageView.top).offset(15);
    }];
    
    self.storeCategoryNameLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                           textAlignment:0
                                                               textColor:@"#999999"
                                                            adjustsWidth:NO
                                                            cornerRadius:0
                                                                    text:nil];
    [self.storeCategoryNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.storeNameLabel);
        make.top.mas_equalTo(self.storeNameLabel.bottom).offset(20);
    }];
}

- (void)bindViewModel:(StoreListItemViewModel *)vm
{
    [self.storeImageView ly_showMidImg:vm.storeImgUrl];
    self.storeNameLabel.text = vm.storeName;
    self.storeCategoryNameLabel.text = vm.storeCategoryName;
    self.rightArrowView.hidden = vm.hideRightArrow;
}

@end
