//
//  PersonalMessageHeadImgCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "PersonalMessageHeadImgCell.h"

#import "PersonalMessageHeadImgCellViewModel.h"

@interface PersonalMessageHeadImgCell()

@property (nonatomic,strong)UIImageView *headImageView;

@end

@implementation PersonalMessageHeadImgCell

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
    CGFloat imageWidth = 55.0f;
    self.headImageView = [self.contentView addImageViewWithImageName:nil
                                                        cornerRadius:imageWidth/2.];
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(imageWidth);
        make.right.mas_equalTo(self.rightArrowView.left).offset(-12.5);
        make.centerY.mas_equalTo(self.rightArrowView);
    }];
}

#pragma mark -bindvm
- (void)bindViewModel:(PersonalMessageHeadImgCellViewModel *)vm
{
    self.leftTitleLabel.text = vm.title;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:vm.imgUrl]
                          placeholderImage:[UIImage imageNamed:@"未登录默认头像"]];
}

@end
