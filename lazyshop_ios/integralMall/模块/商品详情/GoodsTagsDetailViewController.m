//
//  GoodsTagsDetailViewController.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/13.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsTagsDetailViewController.h"

#import "GoodsTagModel.h"
#import "GoodsTagsDetailCell.h"

static NSString *cellReuseID = @"GoodsTagsDetailCell";

@interface GoodsTagsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSArray *goodsTags;
@property (nonatomic,strong)UITableView *mainTable;

@end

@implementation GoodsTagsDetailViewController

- (instancetype)initWithGoodsTagModels:(NSArray *)goodsTagModels
{
    self = [super init];
    if (self) {
        self.goodsTags = goodsTagModels;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addViews];
    // Do any additional setup after loading the view.
}

- (void)addViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    // 导航
    UIView *topView = [UIView new];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
    // 说明
    UILabel *tipLabel = [topView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                        textAlignment:NSTextAlignmentCenter
                                            textColor:@"#333333"
                                         adjustsWidth:NO
                                         cornerRadius:0
                                                 text:@"说明"];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(topView);
    }];
    // 关闭按钮
    UIButton *closeBtn = [UIButton new];
    [closeBtn setImage:[UIImage imageNamed:@"选择样式叉"] forState:UIControlStateNormal];
    [topView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(0);
        make.width.mas_equalTo(50);
    }];
    closeBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [DLAlertShowAnimate disappear];
        return [RACSignal empty];
    }];
    // 列表
    UITableView *mainTable = [UITableView new];
    self.mainTable = mainTable;
    mainTable.dataSource = self;
    mainTable.delegate = self;
    mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mainTable];
    [mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    [mainTable registerClass:[GoodsTagsDetailCell class] forCellReuseIdentifier:cellReuseID];
    
    [self.mainTable reloadData];
}

#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goodsTags.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsTagModel *model = [self.goodsTags objectAtIndex:indexPath.row];
    return [GoodsTagsDetailCell cellHeight:model];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsTagsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    [cell bindViewModel:[self.goodsTags objectAtIndex:indexPath.row]];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
