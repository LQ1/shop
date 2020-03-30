//
//  MessageItemBaseCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MessageItemBaseCell.h"

#import "MessageItemBaseViewModel.h"

@implementation MessageItemBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [self.contentView addLabelWithFontSize:LARGE_FONT_SIZE
                                                   textAlignment:0
                                                       textColor:@"#333333"
                                                    adjustsWidth:NO
                                                    cornerRadius:0
                                                            text:nil];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(15);
            make.right.mas_equalTo(-15);
        }];
    }
    return self;
}

- (void)bindViewModel:(MessageItemBaseViewModel *)vm
{
    self.titleLabel.text = vm.title;
}

@end
