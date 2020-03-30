//
//  SelectStoreItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SelectStoreItemCell.h"

#import "SelectStoreItemViewModel.h"
#import "LYCheckBoxButton.h"

@interface SelectStoreItemCell()

@property (nonatomic,strong)UIImageView *storeImageView;
@property (nonatomic,strong)UILabel *storeNameLabel;
@property (nonatomic,strong)UILabel *storeCategoryNameLabel;

@property (nonatomic,strong)LYCheckBoxButton *boxBtn;

@end


@implementation SelectStoreItemCell

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
    
    self.boxBtn = [LYCheckBoxButton new];
    self.boxBtn.userInteractionEnabled = NO;
    [self.contentView addSubview:self.boxBtn];
    [self.boxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.width.height.mas_equalTo(LYCheckBoxButtonWidth);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

- (void)bindViewModel:(SelectStoreItemViewModel *)vm
{
    [self.storeImageView ly_showMidImg:vm.storeImgUrl];
    self.storeNameLabel.text = vm.storeName;
    self.storeCategoryNameLabel.text = vm.storeCategoryName;
    self.boxBtn.checked = vm.selected;
}

@end
