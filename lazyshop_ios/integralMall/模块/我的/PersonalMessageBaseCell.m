//
//  PersonalMessageBaseCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "PersonalMessageBaseCell.h"

@implementation PersonalMessageBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        // 左标题
        self.leftTitleLabel = [self.contentView addLabelWithFontSize:LARGE_FONT_SIZE
                                                       textAlignment:0
                                                           textColor:@"#000000"
                                                        adjustsWidth:NO
                                                        cornerRadius:0
                                                                text:nil];
        [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        [self.contentView addBottomLine];
    }
    return self;
}

@end
