//
//  MineBaseRowCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MineBaseRowCell.h"

#import "UIView+FillCorner.h"

@implementation MineBaseRowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
        
        self.backContentView = [UIView new];
        self.backContentView.backgroundColor = [UIColor whiteColor];
        self.backContentView.layer.cornerRadius = 5;
        self.backContentView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.backContentView];
        [self.backContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.bottom.mas_equalTo(0);
        }];
        
        self.rowImageView = [self.backContentView addImageViewWithImageName:nil
                                                            cornerRadius:0];
        [self.rowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.backContentView);
            make.centerX.mas_equalTo(self.backContentView.left).offset(20);
        }];
        
        self.rowTitleLabel = [self.backContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                      textAlignment:0
                                                          textColor:@"#000000"
                                                       adjustsWidth:NO
                                                       cornerRadius:0
                                                               text:nil];
        [self.rowTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(33);
            make.centerY.mas_equalTo(self.rowImageView);
        }];
        
        UIImage *rightArrowImage = [UIImage imageNamed:@"我的箭头红色"];
        UIImageView * rightArrowView= [[UIImageView alloc] initWithImage:rightArrowImage];
        [self.backContentView addSubview:rightArrowView];
        [rightArrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-12.5);
            make.centerY.mas_equalTo(self.backContentView);
            make.width.mas_equalTo(rightArrowImage.size.width);
            make.height.mas_equalTo(rightArrowImage.size.height);
        }];

    }
    return self;
}

#pragma mark -补圆角
- (void)fillTopCorner
{
    [self.backContentView lyFillTopCornerWithWidth:5
                                   colorString:@"#ffffff"];
}

- (void)fillBottomCorner
{
    [self.backContentView lyFillBottomCornerWithWidth:5
                                      colorString:@"#ffffff"];
}

@end
