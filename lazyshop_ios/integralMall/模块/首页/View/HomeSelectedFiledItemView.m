//
//  HomeSelectedFiledItemView.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/16.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "HomeSelectedFiledItemView.h"

// 商品列表
#import "ProductListViewController.h"
#import "ProductListViewModel.h"
// 商品详情
#import "GoodsDetailViewController.h"
#import "GoodsDetailViewModel.h"

@interface HomeSelectedFiledItemView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIButton *moreButton;

@property (nonatomic, assign) BOOL more;

@property (nonatomic, copy) NSString *moreDesc;
@property (nonatomic, assign) NSInteger catID;
@property (nonatomic, copy) NSString *goodsCatType;

@property (nonatomic, assign) NSInteger goodsID;
@property (nonatomic, copy) NSString *goodsThumb;

@end

@implementation HomeSelectedFiledItemView

- (instancetype)initWithMore:(BOOL)more{
    self = [super init];
    if (self) {
        self.more = more;
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.backgroundColor = [UIColor whiteColor];
    if (!self.more) {
        // 阴影
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(2.5,2.5);
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowRadius = 2.5;
        // 图
        self.imageView = [self addImageViewWithImageName:nil
                                            cornerRadius:3.];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        // 点击事件
        UIButton *clickBtn = [UIButton new];
        [self addSubview:clickBtn];
        [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        @weakify(self);
        clickBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            // 跳转商品详情
            @strongify(self);
            [self gotoGoodsDetail];
            return [RACSignal empty];
        }];
    }else{
        // 品牌推荐
        self.tipLabel = [self addLabelWithFontSize:MIDDLE_FONT_SIZE
                                     textAlignment:NSTextAlignmentCenter
                                         textColor:@"#000000"
                                      adjustsWidth:NO
                                      cornerRadius:0
                                              text:@"品牌推荐"];
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(33);
            make.centerX.mas_equalTo(self);
        }];
        self.tipLabel.font = [UIFont boldSystemFontOfSize:MIDDLE_FONT_SIZE];
        // 品牌描述
        self.descLabel = [self addLabelWithFontSize:SMALL_FONT_SIZE
                                      textAlignment:NSTextAlignmentCenter
                                          textColor:@"#9c9c9c"
                                       adjustsWidth:NO
                                       cornerRadius:0
                                               text:nil];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.tipLabel.bottom).offset(13);
            make.centerX.mas_equalTo(self.tipLabel);
        }];
        // more
        self.moreButton = [UIButton new];
        [self.moreButton setBackgroundColor:[CommUtls colorWithHexString:APP_MainColor]];
        self.moreButton.titleLabel.font = [UIFont systemFontOfSize:SMALL_FONT_SIZE];
        self.moreButton.titleLabel.textColor = [CommUtls colorWithHexString:@"#ffffff"];
        [self.moreButton setTitle:@"MORE" forState:UIControlStateNormal];
        self.moreButton.layer.cornerRadius = 14;
        self.moreButton.layer.masksToBounds = YES;
        [self addSubview:self.moreButton];
        [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(28);
            make.top.mas_equalTo(self.descLabel.bottom).offset(18);
            make.centerX.mas_equalTo(self.descLabel);
        }];
        @weakify(self);
        self.moreButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            // 跳转商品列表
            [self gotoProductList];
            return [RACSignal empty];
        }];
    }
}
// 跳转商品详情
- (void)gotoGoodsDetail
{
    UINavigationController *nav = [PublicEventManager fetchPushNavigationController:nil];
    GoodsDetailViewController *vc = [GoodsDetailViewController new];
    NSString *goodsID = [NSString stringWithFormat:@"%ld",(long)self.goodsID];
    vc.viewModel = [[GoodsDetailViewModel alloc] initWithProductID:goodsID
                                                   goodsDetailType:GoodsDetailType_Normal
                                                 activity_flash_id:nil
                                               activity_bargain_id:nil
                                                 activity_group_id:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:vc animated:YES];
}
// 跳转商品列表
- (void)gotoProductList
{
    UINavigationController *nav = [PublicEventManager fetchPushNavigationController:nil];
    ProductListViewController *vc = [ProductListViewController new];
    NSString *goodsCatID = [NSString stringWithFormat:@"%ld",(long)self.catID];
    vc.viewModel = [[ProductListViewModel alloc] initWithCartType:self.goodsCatType
                                                     goods_cat_id:goodsCatID
                                                      goods_title:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:vc
                   animated:YES];
}

#pragma mark -reload
//
- (void)reloadWithMoreDesc:(NSString *)moreDesc
                 moreCatID:(NSInteger)catID
                   catType:(NSString *)catType
{
    self.moreDesc = moreDesc;
    self.catID = catID;
    self.goodsCatType = catType;

    self.descLabel.text = self.moreDesc;
}
//
- (void)reloadWithGoodsID:(NSInteger)goodsID
               goodsThumb:(NSString *)goodsThumb
{
    self.goodsID = goodsID;
    self.goodsThumb = goodsThumb;
    [self.imageView ly_showMinImg:self.goodsThumb];
}

@end
