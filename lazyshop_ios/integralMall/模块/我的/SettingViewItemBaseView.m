//
//  SettingViewItemBaseView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/4.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SettingViewItemBaseView.h"

@implementation SettingViewItemBaseView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _clickSignal = [[RACSubject subject] setNameWithFormat:@"%@ clickSignal", self.class];
        
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel = [self addLabelWithFontSize:MIDDLE_FONT_SIZE
                                       textAlignment:0
                                           textColor:@"#000000"
                                        adjustsWidth:NO
                                        cornerRadius:0
                                                text:nil];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self);
        }];
        UIImage *rightArrowImage = [UIImage imageNamed:@"编辑收货地址箭头"];
        self.rightArrowView = [[UIImageView alloc] initWithImage:rightArrowImage];
        [self addSubview:self.rightArrowView];
        [self.rightArrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self);
            make.width.mas_equalTo(rightArrowImage.size.width);
            make.height.mas_equalTo(rightArrowImage.size.height);
        }];

        UIButton *clickBtn = [UIButton new];
        [self addSubview:clickBtn];
        [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        @weakify(self);
        clickBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            [self.clickSignal sendNext:nil];
            return [RACSignal empty];
        }];
    }
    return self;
}

@end
