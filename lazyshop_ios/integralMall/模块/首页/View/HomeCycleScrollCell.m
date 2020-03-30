//
//  HomeCycleScrollCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/7/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "HomeCycleScrollCell.h"

#import "YCCycleScrollView.h"
#import "HomeCycleScrollCellViewModel.h"

@interface HomeCycleScrollCell ()

@property (nonatomic,strong)YCCycleScrollView *mainView;

@end

@implementation HomeCycleScrollCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    YCCycleScrollView *mainScorllView = [[YCCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, HomeViewHeaderWidth,HomeViewHeaderHeight)];
    
    self.mainView = mainScorllView;
    self.mainView.mainScrollView.scrollsToTop = NO;
    
    [self addSubview:mainScorllView];
    
    mainScorllView.isShowLoc = YES;
    mainScorllView.isAuto = YES;
}

#pragma mark -界面刷新
- (void)bindViewModel:(HomeCycleScrollCellViewModel *)viewModel
{
    [self.mainView removeFromSuperview];
    
    YCCycleScrollView *mainScorllView = [[YCCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, HomeViewHeaderWidth,HomeViewHeaderHeight)];
    self.mainView = mainScorllView;
    self.mainView.mainScrollView.scrollsToTop = NO;
    
    @weakify(self);
    [self.mainView clickView:^(NSInteger page) {
        if ([viewModel linkTypeAtIndex:page] == 0) {
            // 跳转网址
            [PublicEventManager gotoWebDisplayViewControllerWithUrl:[viewModel linkUrlAtIndex:page] navigationController:nil];
        }else{
            // 跳转原生模块
            [PublicEventManager gotoNativeModuleWithLinkModel:[viewModel linkModelAtIndex:page] navigationController:nil];
        }
    }];
    [self.mainView fetchShowView:^UIView *(NSInteger page) {
        @strongify(self);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
        [imageView ly_showMaxImg:[viewModel imgUrlAtIndex:page]];
        return imageView;
    }];
    [self addSubview:mainScorllView];
    
    self.mainView.totalNumber = [viewModel itemsCount];
    self.mainView.isShowLoc = YES;
    self.mainView.isAuto = YES;
    self.mainView.curPage = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
