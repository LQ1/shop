//
//  MineOrderCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MineOrderCell.h"

#import "LYUpImgDownTxtView.h"

@interface MineOrderCell()

@property (nonatomic,strong)LYUpImgDownTxtView *waitToPayView;
@property (nonatomic,strong)LYUpImgDownTxtView *waitToSendView;
@property (nonatomic,strong)LYUpImgDownTxtView *waitToRecommendView;
@property (nonatomic,strong)LYUpImgDownTxtView *waitToRefoundView;

@end

@implementation MineOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _clickSignal = [[RACSubject subject] setNameWithFormat:@"%@ clickSignal", self.class];
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.contentView.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    
    UIView *backContentView = [UIView new];
    backContentView.backgroundColor = [UIColor whiteColor];
    backContentView.layer.cornerRadius = 5;
    backContentView.layer.masksToBounds = YES;
    [self.contentView addSubview:backContentView];
    [backContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.bottom.mas_equalTo(0);
    }];
    
    UIView *upContentView = [UIView new];
    [backContentView addSubview:upContentView];
    [upContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(33);
    }];
    [upContentView addBottomLine];
    
    UIView *downContentView = [UIView new];
    [backContentView addSubview:downContentView];
    [downContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(upContentView.bottom);
    }];
    
    // 我的订单
    UILabel *myOrderTipLabel = [self addLabelWithFontSize:MIDDLE_FONT_SIZE
                                            textAlignment:0
                                                textColor:@"#000000"
                                             adjustsWidth:NO
                                             cornerRadius:0
                                                     text:@"我的订单"];
    [upContentView addSubview:myOrderTipLabel];
    [myOrderTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12.5);
        make.centerY.mas_equalTo(upContentView);
    }];
    // 查看全部
    UIImage *rightArrowImage = [UIImage imageNamed:@"编辑收货地址箭头"];
    UIImageView * rightArrowView= [[UIImageView alloc] initWithImage:rightArrowImage];
    [upContentView addSubview:rightArrowView];
    [rightArrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12.5);
        make.centerY.mas_equalTo(upContentView);
        make.width.mas_equalTo(rightArrowImage.size.width);
        make.height.mas_equalTo(rightArrowImage.size.height);
    }];
    UILabel *lookAllTipLabel = [self addLabelWithFontSize:SMALL_FONT_SIZE
                                            textAlignment:NSTextAlignmentRight
                                                textColor:@"#999999"
                                             adjustsWidth:NO
                                             cornerRadius:0
                                                     text:@"查看全部"];
    [upContentView addSubview:lookAllTipLabel];
    [lookAllTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(rightArrowView.left).offset(-7.5);
        make.centerY.mas_equalTo(upContentView);
    }];
    
    UIButton *clickBtn = [UIButton new];
    [upContentView addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    @weakify(self);
    clickBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.clickSignal sendNext:@(MineOrderCellClickType_LookAll)];
        return [RACSignal empty];
    }];
    
    CGFloat itemWidth = 60.0f;
    NSInteger itemCount = 4;
    CGFloat midGap = (KScreenWidth - 15*2 - 18*2 - itemWidth*itemCount)/(itemCount-1);
    // 待收货
    LYUpImgDownTxtView *waitToSendView = [[LYUpImgDownTxtView alloc] initWithImageName:@"待发货图标"
                                                                                 title:@"待收货"
                                                                            titleColor:@"#333333"
        clickBlock:^{
            @strongify(self);
            [self.clickSignal sendNext:@(MineOrderCellClickType_WaitToSend)];
        }];
    self.waitToSendView = waitToSendView;
    [downContentView addSubview:waitToSendView];
    [waitToSendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(itemWidth);
        make.bottom.mas_equalTo(-17.5);
        make.right.mas_equalTo(downContentView.centerX).offset(-midGap/2.);
    }];
    // 待评价
    LYUpImgDownTxtView *waitToRecommendView = [[LYUpImgDownTxtView alloc] initWithImageName:@"待评价图标"
                                                                                 title:@"待评价"
                                                                            titleColor:@"#333333"
                                                                            clickBlock:^{
                                                                                @strongify(self);
                                                                                [self.clickSignal sendNext:@(MineOrderCellClickType_WaitToRecommend)];
                                                                            }];
    self.waitToRecommendView = waitToRecommendView;
    [downContentView addSubview:waitToRecommendView];
    [waitToRecommendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.bottom.mas_equalTo(self.waitToSendView);
        make.left.mas_equalTo(downContentView.centerX).offset(midGap/2.);
    }];
    // 待支付
    LYUpImgDownTxtView *waitToPayView = [[LYUpImgDownTxtView alloc] initWithImageName:@"待支付-图标"
                                                                                      title:@"待支付"
                                                                                 titleColor:@"#333333"
                                                                                 clickBlock:^{
                                                                                     @strongify(self);
                                                                                     [self.clickSignal sendNext:@(MineOrderCellClickType_WaitToPay)];
                                                                                 }];
    self.waitToPayView = waitToPayView;
    [downContentView addSubview:waitToPayView];
    [waitToPayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.bottom.mas_equalTo(self.waitToSendView);
        make.right.mas_equalTo(self.waitToSendView.left).offset(-midGap);
    }];
    // 退款/维权
    LYUpImgDownTxtView *waitToRefoundView = [[LYUpImgDownTxtView alloc] initWithImageName:@"退款--维权图标@2x"
                                                                                title:@"退款/维权"
                                                                           titleColor:@"#333333"
                                                                           clickBlock:^{
                                                                               @strongify(self);
                                                                               [self.clickSignal sendNext:@(MineOrderCellClickType_Refound)];
                                                                           }];
    self.waitToRefoundView = waitToRefoundView;
    [downContentView addSubview:waitToRefoundView];
    [waitToRefoundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.bottom.mas_equalTo(self.waitToSendView);
        make.left.mas_equalTo(self.waitToRecommendView.right).offset(midGap);
    }];
}

#pragma mark -reload
- (void)reload
{
    [self.waitToPayView setRoundNumber:SignInUser.waitToPayOrdersNumber];
    [self.waitToSendView setRoundNumber:SignInUser.waitToSendOrdersNumber];
    [self.waitToRecommendView setRoundNumber:SignInUser.waitToRecommendOrdersNumber];
    [self.waitToRefoundView setRoundNumber:SignInUser.waitToRefoundOrdersNumber];
}

@end
