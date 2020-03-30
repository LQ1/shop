//
//  GoodsDetailIntroParmsView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/4.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailIntroParmsView.h"

#import "GoodsDetailIntroParmsCellViewModel.h"
#import "GoodsDetailIntroParmsCell.h"

static NSString *cellReuseID = @"GoodsDetailIntroParmsCell";

@interface GoodsDetailIntroParmsView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSArray *params;

@end

@implementation GoodsDetailIntroParmsView

- (instancetype)initWithPrams:(NSArray *)parms
{
    self = [super init];
    if (self) {
        self.params = parms;
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.backgroundColor = [UIColor whiteColor];
    // 列表
    UITableView *mainTable = [UITableView new];
    mainTable.dataSource = self;
    mainTable.delegate = self;
    mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTable.backgroundColor = [UIColor clearColor];
    [self addSubview:mainTable];
    [mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
    }];
    [mainTable registerClass:[GoodsDetailIntroParmsCell class] forCellReuseIdentifier:cellReuseID];
    [mainTable reloadData];
}

#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.params.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailIntroParmsCellViewModel *itemVM = [self.params objectAtIndex:indexPath.row];
    return itemVM.UIHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailIntroParmsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    GoodsDetailIntroParmsCellViewModel *itemVM = [self.params objectAtIndex:indexPath.row];
    [cell bindViewModel:itemVM];
    return cell;
}

@end
