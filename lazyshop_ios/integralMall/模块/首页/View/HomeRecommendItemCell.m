//
//  HomeRecommendItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/18.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "HomeRecommendItemCell.h"

#import "HomeCycleItemModel.h"

#define HomeRecommendItemCellImgHeight ((KScreenWidth-15*2)*342./692.)
#define HomeRecommendItemCellBottomGap 20.

@interface HomeRecommendItemCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) HomeCycleItemModel *model;

@end

@implementation HomeRecommendItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.imgView = [self.contentView addImageViewWithImageName:nil
                                                  cornerRadius:0];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(HomeRecommendItemCellImgHeight);
    }];
    
    UIButton *clickBtn = [UIButton new];
    [self.contentView addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    @weakify(self);
    clickBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self gotoPageWithLinkModel];
        return [RACSignal empty];
    }];
}

// 跳转
- (void)gotoPageWithLinkModel
{
    if ([self.model.link_type integerValue] == 0) {
        // 跳转网址
        [PublicEventManager gotoWebDisplayViewControllerWithUrl:self.model.link.options.wz
                                           navigationController:nil];
    }else{
        // 跳转原生模块
        [PublicEventManager gotoNativeModuleWithLinkModel:self.model.link
                                     navigationController:nil];
    }

}

#pragma mark -reload
- (void)bindViewModel:(HomeCycleItemModel *)model
{
    self.model = model;
    [self.imgView ly_showMinImg:model.image];
}

#pragma mark -cellHeight
+ (CGFloat)cellHeight
{
    return HomeRecommendItemCellImgHeight+HomeRecommendItemCellBottomGap;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
