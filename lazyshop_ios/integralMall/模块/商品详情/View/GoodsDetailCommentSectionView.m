//
//  GoodsDetailCommentSectionView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailCommentSectionView.h"

#import "GoodsDetailCommentViewModel.h"

@interface GoodsDetailCommentSectionView()

@property (nonatomic,strong)UILabel *commentCountLabel;
@property (nonatomic,strong)UILabel *rightTipLabel;
@property (nonatomic,strong)UIImageView *rightArrowView;
@property (nonatomic,strong)GoodsDetailCommentViewModel *viewModel;

@end

@implementation GoodsDetailCommentSectionView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        _clickSignal = [[RACSubject subject] setNameWithFormat:@"%@ clickSignal", self.class];
        [self addViews];
    }
    return self;
}

- (void)addViews
{
    // 灰色块
    UIView *topGapView = [UIView new];
    topGapView.backgroundColor = [CommUtls colorWithHexString:@"#eeeeee"];
    [self.contentView addSubview:topGapView];
    [topGapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    // 主内容
    UIView *mainContentView = [UIView new];
    mainContentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:mainContentView];
    [mainContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topGapView.bottom);
        make.right.left.bottom.mas_equalTo(0);
    }];
    // 评价
    UILabel *leftTipLabel = [mainContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                     textAlignment:NSTextAlignmentCenter
                                                         textColor:@"#999999"
                                                      adjustsWidth:NO
                                                      cornerRadius:0
                                                              text:@"评价"];
    [leftTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(55);
    }];
    
    // 数量
    self.commentCountLabel = [mainContentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                      textAlignment:0
                                                          textColor:@"#999999"
                                                       adjustsWidth:NO
                                                       cornerRadius:0
                                                               text:0];
    [self.commentCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftTipLabel.right);
        make.centerY.mas_equalTo(leftTipLabel);
    }];
    
    // 右侧箭头
    UIImageView *rightArrowView = [mainContentView addImageViewWithImageName:@"编辑收货地址箭头"
                                                                 cornerRadius:0];
    self.rightArrowView = rightArrowView;
    [rightArrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(leftTipLabel);
    }];
    
    // 全部评价
    UILabel *rightTipLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                      textAlignment:NSTextAlignmentRight
                                                          textColor:@"#333333"
                                                       adjustsWidth:NO
                                                       cornerRadius:0
                                                               text:@"全部评价"];
    self.rightTipLabel = rightTipLabel;
    [rightTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(rightArrowView.left).offset(-10);
        make.centerY.mas_equalTo(rightArrowView);
    }];
    // 底线
    [self.contentView addBottomLine];
    
    // 点击事件
    UIButton *clickBtn = [UIButton new];
    [self.contentView addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    @weakify(self);
    clickBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self click];
        return [RACSignal empty];
    }];
}

- (void)click
{
    if (self.viewModel.childViewModels.count) {
        [self.clickSignal sendNext:nil];
    }
}

- (void)bindViewModel:(GoodsDetailCommentViewModel *)vm
{
    self.viewModel = vm;
    if (vm.childViewModels.count) {
        // 评价数量
        self.commentCountLabel.text = [NSString stringWithFormat:@"(%ld)",(long)vm.commentCount];
        // 右侧箭头
        self.rightArrowView.hidden = NO;
        // 右侧文字
        self.rightTipLabel.text = @"全部评价";
        self.rightTipLabel.textColor = [CommUtls colorWithHexString:@"#333333"];
        [self.rightTipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.rightArrowView.left).offset(-10);
            make.centerY.mas_equalTo(self.rightArrowView);
        }];
    }else{
        // 评价数量
        self.commentCountLabel.text = nil;
        // 右侧箭头
        self.rightArrowView.hidden = YES;
        // 右侧文字
        self.rightTipLabel.text = @"暂无评价";
        self.rightTipLabel.textColor = [CommUtls colorWithHexString:@"#999999"];
        [self.rightTipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self.rightArrowView);
        }];
    }
}

@end
