//
//  StudyViewController.m
//  integralMall
//
//  Created by liu on 2018/10/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "StudyViewController.h"
#import "Include.h"
#import "StudyCell.h"
#import "ZFFullScreenViewController.h"

@interface StudyViewController ()

@end

@implementation StudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBarView.titleLabel.text = @"社交空间";
    [self initControl];
}

- (void)getData{
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [_viewScrollArea startAnimationNotice];
}

- (void)initControl{
    _nPageNum = 1;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F4F5F6"];
    self.imgKF.layer.cornerRadius = self.imgKF.frame.size.width*0.5f;
    self.imgKF.layer.masksToBounds = YES;
    
    [self.cvStudy registerNib:[UINib nibWithNibName:NSStringFromClass([StudyCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([StudyCell class])];
    self.cvStudy.backgroundColor = self.view.backgroundColor;
    //UICollectionViewFlowLayout *flowlayout = (UICollectionViewFlowLayout*)self.cvStudy.collectionViewLayout;
    //flowlayout.minimumInteritemSpacing = 1;
    
    // 下拉刷新
    LYRefreshHeader *header = [LYRefreshHeader headerWithRefreshingBlock:^{
        _nPageNum = 1;
        [self performSelectorInBackground:@selector(thread_query) withObject:nil];
    }];
    self.cvStudy.mj_header = header;
    
    // 上拉加载
    LYRefreshFooter *footer = [LYRefreshFooter footerWithRefreshingBlock:^{
        _nPageNum ++;
         [self performSelectorInBackground:@selector(thread_query) withObject:nil];
    }];
    self.cvStudy.mj_footer = footer;
    
    [self initData];
}

- (void)initData{
    _arrayDatas = [NSMutableArray new];
    
     _viewScrollArea = [[ViewPartnerScrollArea alloc] initWithParentView:self.viewPartner];
    self.viewPartner.layer.cornerRadius = 6.0f;
    self.viewPartner.layer.masksToBounds = YES;
    
    [self.view DLLoadingInSelf];
    [self performSelectorInBackground:@selector(thread_query) withObject:nil];
}

#pragma collection

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrayDatas.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    StudyModel *model = [_arrayDatas objectAtIndex:indexPath.row];
    
    StudyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([StudyCell class]) forIndexPath:indexPath];
    //cell.backgroundColor = [UIColor greenColor];
    [cell loadData:model];
    
    return cell;
}

- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    StudyModel *model = [_arrayDatas objectAtIndex:indexPath.row];
    
    ZFFullScreenViewController *player = [[ZFFullScreenViewController alloc] init];
    player.propertyPlayerUrl = model.thumb;
    [self.navigationController pushViewController:player animated:YES];
   
}

#pragma mark ---- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float fW = (KScreenWidth-32 - 2*4)*0.333;
    return (CGSize){fW,fW+45};
}

//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 4;
}

//查询
- (void)thread_query{
    NSMutableArray *arrayTmp = [[DataViewModel getInstance] studyCenter:_nPageNum];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view DLLoadingHideInSelf];

       if (arrayTmp) {
           if (_nPageNum == 1) {
               [self.cvStudy.mj_header endRefreshing];
               [self.cvStudy.mj_footer resetNoMoreData];
               [_arrayDatas removeAllObjects];
           }else{
               if (arrayTmp.count == 0) {
                   [self.cvStudy.mj_footer endRefreshingWithNoMoreData];
               }else{
                   [self.cvStudy.mj_footer endRefreshing];
               }
           }
           
           for (int i = 0; i < [arrayTmp count]; i ++) {
               [_arrayDatas addObject:[arrayTmp objectAtIndex:i]];
           }
           
           [self.cvStudy reloadData];
       }else{
            [DLLoading DLToolTipInWindow:[DataViewModel getInstance].ERROR_MSG];
        }
    });
    
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
