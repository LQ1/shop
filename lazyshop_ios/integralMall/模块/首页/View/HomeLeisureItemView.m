//
//  HomeLeisureItemView.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/16.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "HomeLeisureItemView.h"

#import "HomeLeisureItemModel.h"

#import "ProductListViewController.h"
#import "ProductListViewModel.h"

@interface HomeLeisureItemView ()

@property (nonatomic, assign) BOOL verb;
@property (nonatomic, assign) NSInteger titleFont;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) HomeLeisureItemModel *model;

@end

@implementation HomeLeisureItemView

- (instancetype)initWithTitleStyle:(BOOL)verb
                         titleFont:(NSInteger)titleFont
{
    self = [super init];
    if (self) {
        self.verb = verb;
        self.titleFont = titleFont;
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // imageView
    self.imgView = [self addImageViewWithImageName:nil
                                      cornerRadius:3.];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    // titleLabel
    self.titleLabel = [self addLabelWithFontSize:self.titleFont
                                   textAlignment:NSTextAlignmentCenter
                                       textColor:@"#ffffff"
                                    adjustsWidth:NO
                                    cornerRadius:3.
                                            text:nil];
    self.titleLabel.backgroundColor = [CommUtls colorWithHexString:APP_MainColor];
    self.titleLabel.alpha = .5;
    if (self.verb) {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(22.5);
            make.height.mas_equalTo(100);
            make.right.mas_equalTo(-22.5);
            make.centerY.mas_equalTo(self);
        }];
    }else{
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(22.5);
            make.center.mas_equalTo(self);
        }];
    }
    // click
    UIButton *clickBtn = [UIButton new];
    [self addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    @weakify(self);
    clickBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        // 跳转商品列表
        ProductListViewController *vc = [ProductListViewController new];
        NSString *cartType = [NSString stringWithFormat:@"%ld",(long)self.model.goods_cat_type];
        NSString *catID = [NSString stringWithFormat:@"%ld",(long)self.model.goods_cat_id];
        vc.viewModel = [[ProductListViewModel alloc] initWithCartType:cartType
                                                         goods_cat_id:catID
                                                          goods_title:nil];
        vc.hidesBottomBarWhenPushed = YES;
        [[PublicEventManager fetchPushNavigationController:nil] pushViewController:vc
                                                                          animated:YES];
        return [RACSignal empty];
    }];
}

#pragma mark -reload
- (void)reloadWithModel:(HomeLeisureItemModel *)model
{
    self.model = model;
    [self.imgView ly_showMinImg:model.icon];
    if (self.verb) {
        self.titleLabel.text = [self VerticalString:model.goods_cat_name];
        self.titleLabel.numberOfLines = self.titleLabel.text.length;
    }else{
        self.titleLabel.text = model.goods_cat_name;
    }
}
// 竖直文字
- (NSString *)VerticalString:(NSString *)oldString
{
    NSMutableString * str = [[NSMutableString alloc] initWithString:oldString];
    NSInteger count = str.length;
    for (int i = 1; i < count; i ++) {
        [str insertString:@"\n" atIndex:i*2 - 1];
    }
    return str;
}


@end
