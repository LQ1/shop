//
//  ProductListView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ProductListView.h"

#import "ProductListViewModel.h"
#import "ProductListHeaderView.h"
#import "ProductGridListView.h"
#import "ProductHoriListView.h"

@interface ProductListView()

@property (nonatomic,strong)ProductListHeaderView *headerView;
@property (nonatomic,strong)ProductGridListView *gridListView;
@property (nonatomic,strong)ProductHoriListView *horiListView;
@property (nonatomic,strong)ProductListViewModel *viewModel;

@end

@implementation ProductListView

- (instancetype)initWithViewModel:(ProductListViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        [self addViews];
    }
    return self;
}

#pragma mark -设置列表显示和隐藏
- (void)setListHidden:(BOOL)hidden
{
    self.gridListView.hidden = hidden;
    self.horiListView.hidden = hidden;
}

#pragma mark -主界面
- (void)addViews
{
    self.backgroundColor = [CommUtls colorWithHexString:@"#eaeaea"];
    // 头视图
    ProductListHeaderView *headerView = [ProductListHeaderView new];
    self.headerView = headerView;
    [self addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(ProductListHeaderViewHeight);
    }];
    
    @weakify(self);
    [headerView.clickSignal subscribeNext:^(id x) {
        @strongify(self);
        [self headerClickWith:x];
    }];
    // 列表
    self.gridListView = [ProductGridListView new];
    [self addSubview:self.gridListView];
    [self.gridListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    self.horiListView = [ProductHoriListView new];
    [self addSubview:self.horiListView];
    [self.horiListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];

    [self.headerView reloadDataWithViewModel:self.viewModel];
}

- (void)headerClickWith:(id)x
{
    switch ([x integerValue]) {
        case ProductListHeaderViewClickType_OrderByDefault:
        {
            [self.viewModel orderByDefault];
        }
            break;
        case ProductListHeaderViewClickType_OrderBySales:
        {
            [self.viewModel orderBySale];
        }
            break;
        case ProductListHeaderViewClickType_OrderByPrice:
        {
            [self.viewModel orderByPrice:NO];
        }
            break;
        case ProductListHeaderViewClickType_OrderByPriceDesc:
        {
            [self.viewModel orderByPrice:YES];
        }
            break;
        case ProductListHeaderViewClickType_Sift:
        {
            // 筛选
            [self.viewModel startToSift];
        }
            break;
            
        default:
            break;
    }
}

- (void)reloadDataWithViewModel:(ProductListViewModel *)viewModel
{
    self.viewModel = viewModel;
    if (viewModel.isHoriListStyle) {
        self.horiListView.hidden = NO;
        self.gridListView.hidden = YES;
        [self.horiListView reloadDataWithViewModel:viewModel];
    }else{
        self.horiListView.hidden = YES;
        self.gridListView.hidden = NO;
        [self.gridListView reloadDataWithViewModel:viewModel];
    }
}

@end
