//
//  GoodsDetailAudioVideoView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/18.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailAudioVideoView.h"

@interface GoodsDetailAudioVideoView()

@property (nonatomic,assign)BOOL audio;
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *titleLabel;

@end

@implementation GoodsDetailAudioVideoView

- (instancetype)initWithAudio:(BOOL)audio
{
    self = [super init];
    if (self) {
        _clickSignal = [[RACSubject subject] setNameWithFormat:@"%@ clickSignal", self.class];
        self.audio = audio;
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // 图
    self.imageView = [self addImageViewWithImageName:self.audio?@"详情页音频播放":@"详情页视频播放" cornerRadius:0];
    [self.imageView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    // 文
    self.titleLabel = [self addLabelWithFontSize:MIDDLE_FONT_SIZE
                                   textAlignment:NSTextAlignmentCenter
                                       textColor:@"#fffffff"
                                    adjustsWidth:YES
                                    cornerRadius:0
                                            text:0];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(40);
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

#pragma mark -设置文本
- (void)setText:(NSString *)text
{
    self.titleLabel.text = text;
}

@end
