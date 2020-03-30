//
//  GoodsDetailIntroTagsView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/4.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailIntroTagsView.h"

#import "GoodsDetailIntroTagCellViewModel.h"
#import "GoodsDetailIntroTagCell.h"

static NSString *cellReuseID = @"GoodsDetailIntroTagCell";

@interface GoodsDetailIntroTagsView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSArray *tags;

@end

@implementation GoodsDetailIntroTagsView

- (instancetype)initWithTags:(NSArray *)tags
{
    self = [super init];
    if (self) {
        self.tags = tags;
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.backgroundColor = [CommUtls colorWithHexString:@"#eeeeee"];
    // 列表
    UITableView *mainTable = [UITableView new];
    mainTable.dataSource = self;
    mainTable.delegate = self;
    mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTable.backgroundColor = [UIColor clearColor];
    [self addSubview:mainTable];
    [mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [mainTable registerClass:[GoodsDetailIntroTagCell class] forCellReuseIdentifier:cellReuseID];
    [mainTable reloadData];
}

#pragma mark -delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tags.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [UIView new];
    header.backgroundColor = [UIColor clearColor];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [UIView new];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailIntroTagCellViewModel *itemVM = [self.tags objectAtIndex:indexPath.section];
    return itemVM.UIHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailIntroTagCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    GoodsDetailIntroTagCellViewModel *itemVM = [self.tags objectAtIndex:indexPath.section];
    [cell bindViewModel:itemVM];
    return cell;
}

@end
