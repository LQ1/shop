//
//  GoodsDetailLeftTitleBaseCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/15.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailLeftTitleBaseCell.h"

@interface GoodsDetailLeftTitleBaseCell()

@property (nonatomic,strong)UILabel *leftTitleLabel;

@end

@implementation GoodsDetailLeftTitleBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 左标题
        self.leftTitleLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                       textAlignment:NSTextAlignmentCenter
                                                           textColor:@"#999999"
                                                        adjustsWidth:NO
                                                        cornerRadius:0
                                                                text:0];
        [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(55);
            make.centerY.mas_equalTo(self.contentView);
        }];
        // 底部线
        [self.contentView addBottomLine];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
