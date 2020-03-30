//
//  CashWithdrawViewController.m
//  integralMall
//
//  Created by liu on 2018/10/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "CashWithdrawViewController.h"
#import "CashWithDrawCell.h"

@interface CashWithdrawViewController ()

@end

@implementation CashWithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.propertyTag == 1) {
        self.navigationBarView.titleLabel.text = @"提现记录";
    }else{
        self.navigationBarView.titleLabel.text = @"佣金记录";
        self.lblTitle.text = @"佣金记录";
    }
    
    [self initControl];
}


- (void)getData{
    
}


- (void)initControl{
    [Utility setExtraCellLineHidden:self.tabView];
    [self.tabView registerNib:[UINib nibWithNibName:NSStringFromClass([CashWithDrawCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CashWithDrawCell class])];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F4F5F6"];
    
    // 下拉刷新
    LYRefreshHeader *header = [LYRefreshHeader headerWithRefreshingBlock:^{
        _nPageNum = 1;
        [self performSelectorInBackground:@selector(thread_query) withObject:nil];
    }];
    self.tabView.mj_header = header;
    
    // 上拉加载
    LYRefreshFooter *footer = [LYRefreshFooter footerWithRefreshingBlock:^{
        _nPageNum ++;
         [self performSelectorInBackground:@selector(thread_query) withObject:nil];
    }];
    self.tabView.mj_footer = footer;
    
    [self initData];
}

- (void)initData{
    _nPageNum = 1;
    _arrayDatas = [NSMutableArray new];
    
    [self.view DLLoadingInSelf];
    [self performSelectorInBackground:@selector(thread_query) withObject:nil];
}

#pragma mark uitableview delegate

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrayDatas.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    CommissionRecordModel *model = [_arrayDatas objectAtIndex:indexPath.row];
    
    CashWithDrawCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CashWithDrawCell class])];
    [cell loadData:model];
    
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//查询
- (void)thread_query{
    NSMutableArray *arrayTmp = nil;
    if (self.propertyTag == 1) {
        arrayTmp = [[DataViewModel getInstance] commissionGetRecord:_nPageNum];
    }else{
        arrayTmp = [[DataViewModel getInstance] commissionRecord:_nPageNum];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view DLLoadingHideInSelf];
        [self.tabView.mj_header endRefreshing];

        if (arrayTmp) {
            if (_nPageNum == 1) {
                [_arrayDatas removeAllObjects];
            }else{
                if (arrayTmp.count == 0) {
                    [self.tabView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.tabView.mj_footer endRefreshing];
                }
            }
            
            for (int i = 0; i < [arrayTmp count]; i ++) {
                [_arrayDatas addObject:[arrayTmp objectAtIndex:i]];
            }
            
            [self.tabView reloadData];
        }else{
            [DLLoading DLToolTipInWindow:[DataViewModel getInstance].ERROR_MSG];
        }
    });
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    [self.statusWidth setConstant:0.01f];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
