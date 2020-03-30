//
//  LYHeaderSwitchItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/6.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYHeaderSwitchItemCell.h"

#import "LYHeaderSwitchItemViewModel.h"

@implementation LYHeaderSwitchItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.bottomBarView = [UIView new];
        self.bottomBarView.backgroundColor = [CommUtls colorWithHexString:APP_MainColor];
        [self.contentView addSubview:self.bottomBarView];
        [self.bottomBarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(self.contentView.width).multipliedBy(0.67);
            make.height.mas_equalTo(2);
            make.centerX.mas_equalTo(self.contentView);
        }];
        
        self.titleLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                   textAlignment:NSTextAlignmentCenter
                                                       textColor:nil
                                                    adjustsWidth:YES
                                                    cornerRadius:0
                                                            text:nil];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)bindViewModel:(LYHeaderSwitchItemViewModel *)vm
{
    self.bottomBarView.hidden = !vm.selected;
    self.titleLabel.text = vm.title;
    if (vm.selected) {
        self.titleLabel.textColor = [CommUtls colorWithHexString:APP_MainColor];
    }else{
        self.titleLabel.textColor = [CommUtls colorWithHexString:@"#333333"];
    }
}

@end
