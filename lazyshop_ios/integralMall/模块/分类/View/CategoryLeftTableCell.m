//
//  CategoryLeftTableCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/7.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CategoryLeftTableCell.h"

#import "CategoryFirstItemViewModel.h"

@interface CategoryLeftTableCell()

@property (nonatomic,strong)UILabel *titleLabel;

@end

@implementation CategoryLeftTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addViews];
    }
    return self;
}

- (void)addViews
{
    // 标题
    self.titleLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                               textAlignment:NSTextAlignmentCenter
                                                   textColor:nil
                                                adjustsWidth:YES
                                                cornerRadius:0
                                                        text:nil];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.contentView addBottomLine];
}

#pragma mark -刷新数据
- (void)reloadDataWithViewModel:(CategoryFirstItemViewModel *)viewModel
{
    @weakify(self);
    [[RACObserve(viewModel, selected) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            self.contentView.backgroundColor = [CommUtls colorWithHexString:@"#F5F5F5"];
            self.titleLabel.textColor = [CommUtls colorWithHexString:APP_MainColor];
        }else{
            self.contentView.backgroundColor = [UIColor whiteColor];
            self.titleLabel.textColor = [CommUtls colorWithHexString:App_TxtBColor];
        }
    }];
    
    self.titleLabel.text = viewModel.firstCategoryName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
