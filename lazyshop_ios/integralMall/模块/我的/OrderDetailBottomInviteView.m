//
//  OrderDetailBottomInviteView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "OrderDetailBottomInviteView.h"

#import "LYMainColorButton.h"

@interface OrderDetailBottomInviteView()

@property (nonatomic,assign)NSInteger seconds;
@property (nonatomic,strong)LYMainColorButton *inviteBtn;

@end

@implementation OrderDetailBottomInviteView

- (instancetype)initCountDownSeconds:(NSInteger)seconds
{
    self = [super init];
    if (self) {
        _clickSignal = [[RACSubject subject] setNameWithFormat:@"%@ clickSignal", self.class];
        self.seconds = seconds;
        [self addViews];
        if (seconds>0) {
            [self startTimer];
        }
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.backgroundColor = [CommUtls colorWithHexString:@"#ffffff"];
    
    self.inviteBtn = [[LYMainColorButton alloc] initWithTitle:nil
                                               buttonFontSize:MIDDLE_FONT_SIZE
                                                 cornerRadius:3];
    [self addSubview:self.inviteBtn];
    [self.inviteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(30);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(133);
    }];
    
    [self.inviteBtn setTitle:[self fetchCountDownTitle] forState:UIControlStateNormal];
    
    @weakify(self);
    self.inviteBtn.rac_command = [[RACCommand alloc] initWithEnabled:[RACObserve(self, seconds) map:^id(id value) {
        return @([value integerValue]>0);
    }] signalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.clickSignal sendNext:nil];
        return [RACSignal empty];
    }];
    
    [self addTopLine];
}

#pragma mark -开启定时器
- (void)startTimer
{
    @weakify(self);
    [[[RACSignal interval:1. onScheduler:[RACScheduler currentScheduler]] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self);
        self.seconds--;
        [self.inviteBtn setTitle:[self fetchCountDownTitle] forState:UIControlStateNormal];
    }];
}
// 按钮标题
- (NSString *)fetchCountDownTitle
{
    if (self.seconds>0) {
        return [NSString stringWithFormat:@"邀请好友 %@",[CommUtls timeToHMS:self.seconds]];
    }else{
        return @"邀请好友";
    }
}


@end
