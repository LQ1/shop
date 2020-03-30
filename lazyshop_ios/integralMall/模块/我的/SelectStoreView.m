//
//  SelectStoreView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SelectStoreView.h"

#import "SelectStoreItemCell.h"
#import "SelectStoreViewModel.h"

static NSString *cellReuseID = @"SelectStoreItemCell";

@interface SelectStoreView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *mainTable;
@property (nonatomic,strong)SelectStoreViewModel *viewModel;

@end

@implementation SelectStoreView

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
    // 头部提示
    UIView *topView = [UIView new];
    topView.backgroundColor = [CommUtls colorWithHexString:@"#ababab"];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    UIImageView *tipView = [topView addImageViewWithImageName:@"关联店铺注意-"
                                              cornerRadius:0];
    [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(18);
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(topView);
    }];
    UILabel *tipLabel = [topView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                        textAlignment:0
                                            textColor:@"#ffffff"
                                         adjustsWidth:NO
                                         cornerRadius:0
                                                 text:@"选择使用店铺后将不可更改,后续几期返利都将只能在此店铺使用,请谨慎选择"];
    tipLabel.numberOfLines = 2;
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tipView.right).offset(10);
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(tipView);
    }];
    
    // 列表
    UITableView *mainTable = [UITableView new];
    self.mainTable = mainTable;
    mainTable.dataSource = self;
    mainTable.delegate = self;
    mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTable.backgroundColor = [UIColor clearColor];
    [self addSubview:mainTable];
    [mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    [mainTable registerClass:[SelectStoreItemCell class] forCellReuseIdentifier:cellReuseID];
}

#pragma mark -reload
- (void)reloadDataWithViewModel:(SelectStoreViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.mainTable reloadData];
}

#pragma mark -tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.viewModel numberOfSections];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SelectStoreItemCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectStoreItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    [cell bindViewModel:[self.viewModel cellViewModelForRowAtIndexPath:indexPath]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel didSelectRowAtIndexPath:indexPath];
    [self.mainTable reloadData];
}

@end
