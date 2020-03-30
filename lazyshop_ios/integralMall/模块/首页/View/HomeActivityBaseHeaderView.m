//
//  HomeActivityBaseHeaderView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/16.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeActivityBaseHeaderView.h"

#import "LYTextColorButton.h"

@interface HomeActivityBaseHeaderView ()

@property (nonatomic, strong) UILabel *grayTipLabel;

@end

@implementation HomeActivityBaseHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _clickSignal = [[RACSubject subject] setNameWithFormat:@"%@ clickSignal", self.class];
        // 懒店秒杀
        UILabel *leftTipLabel = [self addLabelWithFontSize:MIDDLE_FONT_SIZE
                                             textAlignment:0
                                                 textColor:APP_MainColor
                                              adjustsWidth:NO
                                              cornerRadius:0
                                                      text:nil];
        leftTipLabel.font = [UIFont boldSystemFontOfSize:MIDDLE_FONT_SIZE];
        self.leftTipLabel = leftTipLabel;
        [leftTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(13);
            make.left.mas_equalTo(15);
        }];
        // 精选爆款随便选
        UILabel *grayTipLabel = [self addLabelWithFontSize:SMALL_FONT_SIZE
                                             textAlignment:0
                                                 textColor:@"#b6b6b6"
                                              adjustsWidth:NO
                                              cornerRadius:0
                                                      text:@"精选爆款随便选"];
        self.grayTipLabel = grayTipLabel;
        [grayTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.leftTipLabel);
            make.top.mas_equalTo(self.leftTipLabel.bottom).offset(7);
        }];

        // 查看更多
        LYTextColorButton *moreBtn = [[LYTextColorButton alloc] initWithTitle:@"查看更多"
                                                               buttonFontSize:SMALL_FONT_SIZE
                                                                 cornerRadius:11];
        [self addSubview:moreBtn];
        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(22);
            make.left.mas_equalTo(KScreenWidth-15*2-15-70);
            make.centerY.mas_equalTo(self.leftTipLabel);
        }];
        @weakify(self);
        moreBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            [self.clickSignal sendNext:nil];
            return [RACSignal empty];
        }];
    }
    return self;
}

#pragma mark -刷新标题
- (void)resetTitle:(NSString *)title
{
    self.grayTipLabel.text = title;
}

@end
