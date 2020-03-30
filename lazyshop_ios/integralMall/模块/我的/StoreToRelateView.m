//
//  StoreToRelateView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/9.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "StoreToRelateView.h"

#import "StoreListItemCell.h"
#import "LYMainColorButton.h"
#import "StoreToRelateViewModel.h"

@interface StoreToRelateView()

@property (nonatomic,strong)StoreListItemCell *headerCell;
@property (nonatomic,strong)LYMainColorButton *relateButton;
@property (nonatomic,strong)StoreToRelateViewModel *viewModel;

@end

@implementation StoreToRelateView

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
    self.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    
    self.headerCell = [[StoreListItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [self addSubview:self.headerCell.contentView];
    [self.headerCell.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(5);
        make.height.mas_equalTo(StoreListItemCellHeight);
    }];
    
    
    self.relateButton = [[LYMainColorButton alloc] initWithTitle:@"关联店铺"
                                                  buttonFontSize:MIDDLE_FONT_SIZE
                                                    cornerRadius:3];
    [self addSubview:self.relateButton];
    [self.relateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerCell.contentView.bottom).offset(25);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(45);
    }];
    @weakify(self);
    self.relateButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self relate];
        return [RACSignal empty];
    }];
}
// 关联
- (void)relate
{
    [self.viewModel relate];
}

#pragma mark -刷新界面
- (void)reloadDataWithViewModel:(StoreToRelateViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.headerCell bindViewModel:viewModel.itemViewModel];
}

@end
