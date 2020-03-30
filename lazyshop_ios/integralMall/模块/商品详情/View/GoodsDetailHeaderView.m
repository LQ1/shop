//
//  GoodsDetailHeaderView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/18.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailHeaderView.h"

#import "GoodsDetailImageScrollView.h"
#import "GoodsDetailAudioVideoView.h"
#import "GoodsDetailRoundIndexView.h"
#import "LYCountDownView.h"

#import "GoodsDetailViewModel.h"

@interface GoodsDetailHeaderView()

@property (nonatomic,strong)GoodsDetailImageScrollView *productImageView;
@property (nonatomic,strong)GoodsDetailAudioVideoView *audioDescView;
@property (nonatomic,strong)GoodsDetailAudioVideoView *videoDescView;
@property (nonatomic,strong)UILabel *productNameLabel;
@property (nonatomic,strong)UILabel *productPriceLabel;
@property (nonatomic,strong)UILabel *productOrignalPriceLabel;
@property (nonatomic,strong)UILabel *countDownTipLabel;
@property (nonatomic,strong)LYCountDownView *countDownView;

@property (nonatomic,strong)GoodsDetailViewModel *viewModel;

@end

@implementation GoodsDetailHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // 容器
    UIView *topContentView = [UIView new];
    topContentView.backgroundColor = [CommUtls colorWithHexString:@"#eeeeee"];
    [self addSubview:topContentView];
    [topContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(KScreenWidth);
    }];
    // 图片
    self.productImageView = [GoodsDetailImageScrollView new];
    [topContentView addSubview:self.productImageView];
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    // 音频描述
    self.audioDescView = [[GoodsDetailAudioVideoView alloc] initWithAudio:YES];
    [topContentView addSubview:self.audioDescView];
    [self.audioDescView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(GoodsDetailAudioVideoViewWidth);
        make.height.mas_equalTo(GoodsDetailAudioVideoViewHeight);
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
    }];
    @weakify(self);
    [self.audioDescView.clickSignal subscribeNext:^(id x) {
        @strongify(self);
        // 播放音频
        [self playAudio];
    }];
    // 视频描述
    self.videoDescView = [[GoodsDetailAudioVideoView alloc] initWithAudio:NO];
    [topContentView addSubview:self.videoDescView];
    [self.videoDescView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(GoodsDetailAudioVideoViewWidth);
        make.height.mas_equalTo(GoodsDetailAudioVideoViewHeight);
        make.bottom.mas_equalTo(-15);
        make.left.mas_equalTo(self.audioDescView.right).offset(15);
    }];
    [self.videoDescView.clickSignal subscribeNext:^(id x) {
        @strongify(self);
        // 播放视频
        [self playVideo];
    }];
        
    // 商品名称
    self.productNameLabel = [self addLabelWithFontSize:LARGE_FONT_SIZE
                                         textAlignment:0
                                             textColor:@"#000000"
                                          adjustsWidth:NO
                                          cornerRadius:0
                                                  text:0];
    self.productNameLabel.font = [UIFont boldSystemFontOfSize:LARGE_FONT_SIZE];
    self.productNameLabel.numberOfLines = 0;
    [self.productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topContentView.bottom).offset(12);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    // 价格
    self.productPriceLabel = [self addLabelWithFontSize:LARGE_FONT_SIZE
                                          textAlignment:NSTextAlignmentCenter
                                              textColor:@"#ff1600"
                                           adjustsWidth:YES
                                           cornerRadius:0
                                                   text:nil];
    self.productPriceLabel.font = [UIFont boldSystemFontOfSize:LARGE_FONT_SIZE];
    [self.productPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.productNameLabel);
        make.top.mas_equalTo(self.productNameLabel.bottom).offset(17.6);
        make.bottom.mas_equalTo(-12.5);
    }];
    
//    // 原价
//    self.productOrignalPriceLabel = [self addLabelWithFontSize:MIN_FONT_SIZE
//                                                 textAlignment:NSTextAlignmentCenter
//                                                     textColor:@"#b6b6b6"
//                                                  adjustsWidth:YES
//                                                  cornerRadius:0
//                                                          text:nil];
//    [self.productOrignalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.productPriceLabel.right).offset(10);
//        make.centerY.mas_equalTo(self.productPriceLabel);
//    }];
    
    // 倒计时
    self.countDownView = [[LYCountDownView alloc] initWithItemBackColorString:@"#e43b3d"
                                                            textColorString:@"#ffffff"
                                                             dotColorString:@"#000000"
                                                                   dotWidth:10.0];
    [self addSubview:self.countDownView];
    [self.countDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([self.countDownView totalWidth]);
        make.height.mas_equalTo(CountDownViewHeight);
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.productPriceLabel);
    }];
    self.countDownView.hidden = YES;
    // 距离结束还剩
    self.countDownTipLabel = [self addLabelWithFontSize:MIDDLE_FONT_SIZE
                                          textAlignment:NSTextAlignmentRight
                                              textColor:@"#fe1602"
                                           adjustsWidth:NO
                                           cornerRadius:0
                                                   text:@"距离结束还剩："];
    self.countDownTipLabel.hidden = YES;
    [self.countDownTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.countDownView.left);
        make.centerY.mas_equalTo(self.countDownView);
    }];
}
// 播放音频
- (void)playAudio
{
    [self.viewModel playAudio];
}
// 播放视频
- (void)playVideo
{
    [self.viewModel playVideo];
}

#pragma mark -获取高度
+ (CGFloat)fetchHeightWithViewModel:(GoodsDetailViewModel *)viewModel
{
    return KScreenWidth+55+[CommUtls getContentSize:viewModel.productName
                                               font:[UIFont boldSystemFontOfSize:LARGE_FONT_SIZE]
                                               size:CGSizeMake(KScreenWidth-30, CGFLOAT_MAX)].height;
}

#pragma mark -数据刷新
- (void)reloadDataWithViewModel:(GoodsDetailViewModel *)viewModel
{
    self.viewModel = viewModel;
    // 图
    [self.productImageView resetViewsWithImageUrls:self.viewModel.productImageUrls];
    // 音视频描述
    if (viewModel.detailType == GoodsDetailType_Store) {
        self.videoDescView.hidden = YES;
        self.audioDescView.hidden = YES;
    }else{
        // 音频是否显示
        if (self.viewModel.productAudioDescUrl.length) {
            self.audioDescView.hidden = NO;
            [self.audioDescView setText:[CommUtls timeToMarkMS:self.viewModel.audio_time]];
        }else{
            self.audioDescView.hidden = YES;
        }
        // 视频是否显示
        if (self.viewModel.productVideoDescUrl.length) {
            self.videoDescView.hidden = NO;
            [self.videoDescView setText:[CommUtls timeToMarkMS:self.viewModel.video_time]];
            // 根据音频是否显示刷新布局
            if (self.audioDescView.hidden) {
                [self.videoDescView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(GoodsDetailAudioVideoViewWidth);
                    make.height.mas_equalTo(GoodsDetailAudioVideoViewHeight);
                    make.bottom.mas_equalTo(-15);
                    make.left.mas_equalTo(15);
                }];
            }else{
                [self.videoDescView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(GoodsDetailAudioVideoViewWidth);
                    make.height.mas_equalTo(GoodsDetailAudioVideoViewHeight);
                    make.bottom.mas_equalTo(-15);
                    make.left.mas_equalTo(self.audioDescView.right).offset(15);
                }];
            }
        }else{
            self.videoDescView.hidden = YES;
        }
    }
    // 商品名称
    self.productNameLabel.text = self.viewModel.productName;
    // 价格
    if (viewModel.detailType == GoodsDetailType_Store) {
        self.productPriceLabel.text = [NSString stringWithFormat:@"%@积分",self.viewModel.score];
    }else{
        self.productPriceLabel.text = [NSString stringWithFormat:@"¥ %.2f",self.viewModel.productPrice];
    }
//    // 原价
//    self.productOrignalPriceLabel.text = [NSString stringWithFormat:@"¥ %.1f",self.viewModel.productOrignalPrice];
//    // 原价 富文本
//    NSMutableAttributedString *orignalPriceString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%.1f",self.viewModel.productOrignalPrice]];
//    [orignalPriceString addAttribute:NSStrikethroughStyleAttributeName
//                               value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
//                               range:NSMakeRange(0, orignalPriceString.length)];
//    [orignalPriceString addAttribute:NSForegroundColorAttributeName
//                               value:[CommUtls colorWithHexString:@"#999999"]
//                               range:NSMakeRange(0, orignalPriceString.length)];
//    [orignalPriceString addAttribute:NSFontAttributeName
//                               value:[UIFont systemFontOfSize:MIN_FONT_SIZE]
//                               range:NSMakeRange(0, orignalPriceString.length)];
//    self.productOrignalPriceLabel.attributedText = orignalPriceString;
    @weakify(self);
    // 秒杀剩余时间
    if (self.viewModel.detailType == GoodsDetailType_SecKill) {
        [[[RACObserve(self.viewModel, activityRemainingTime) takeUntil:self.rac_willDeallocSignal] distinctUntilChanged] subscribeNext:^(id x) {
            @strongify(self);
            self.countDownTipLabel.hidden = NO;
            self.countDownView.hidden = NO;
            [self.countDownView setRemainingTime:self.viewModel.activityRemainingTime];
        }];
    }
}

@end
