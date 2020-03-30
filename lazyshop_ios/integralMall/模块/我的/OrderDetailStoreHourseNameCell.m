//
//  OrderDetailStoreHourseNameCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/13.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailStoreHourseNameCell.h"

#import "OrderDetailStoreHouseNameCellViewModel.h"

@interface OrderDetailStoreHourseNameCell()

@property (nonatomic,strong)UILabel *houseNameLabel;

@end

@implementation OrderDetailStoreHourseNameCell

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
    
    self.houseNameLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                  textAlignment:0
                                                      textColor:@"#333333"
                                                   adjustsWidth:NO
                                                   cornerRadius:0
                                                           text:nil];
    [self.houseNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

#pragma mark - reload
- (void)bindViewModel:(OrderDetailStoreHouseNameCellViewModel *)vm
{
    self.houseNameLabel.text = vm.storehouse_name;
}

@end
