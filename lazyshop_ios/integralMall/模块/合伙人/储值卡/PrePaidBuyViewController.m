//
//  PrePaidBuyViewController.m
//  integralMall
//
//  Created by liu on 2018/10/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "PrePaidBuyViewController.h"
#import "StorageCardCCell.h"
#import "UIColor+YYAdd.h"
#import "DataViewModel.h"
#import "StorageBuyViewController.h"

@interface PrePaidBuyViewController ()

@end

@implementation PrePaidBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBarView.titleLabel.text = @"储值卡购买";
    
    [self initControl];
}

- (void)viewDidAppear:(BOOL)animated{
    [_viewScrollArea startAnimationNotice];
}

- (void)getData{
    
}

- (void)initControl{
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F4F5F6"];
    
    self.cvStoragecard.contentInset = UIEdgeInsetsMake(0, 16, 0, 16);
    
    [self initData];
}

- (void)initData{
    _nPageNum = 1;
    _arrayDatas = [NSMutableArray new];
    
    self.viewPartner.layer.cornerRadius = 6.0f;
    _viewScrollArea = [[ViewPartnerScrollArea alloc] initWithParentView:self.viewPartner];
    
    [self.view DLLoadingInSelf];
    [self performSelectorInBackground:@selector(thread_queryStorageCard) withObject:nil];
}

#pragma mark uicollectionview

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrayDatas.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StorageCardModel *model = [_arrayDatas objectAtIndex:indexPath.row];
    StorageCardCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([StorageCardCCell class]) forIndexPath:indexPath];
    [cell loadData:model];
    
    return cell;
}

- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    StorageCardModel *model = [_arrayDatas objectAtIndex:indexPath.row];
    StorageBuyViewController *storeBuyViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([StorageBuyViewController class])];
    storeBuyViewCtrl.store_card_id = model.store_card_id;
    [self.navigationController pushViewController:storeBuyViewCtrl animated:YES];
}

#pragma mark ---- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return (CGSize){KScreenWidth*0.5-22,260};
}

//定义每个UICollectionView 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(8, 0, 108, 0);
//}




//查询yw储值卡
- (void)thread_queryStorageCard{
    NSMutableArray *arrayTmp = [[DataViewModel getInstance] storageCardList:_nPageNum];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view DLLoadingHideInSelf];
        if (arrayTmp) {
            if (_nPageNum == 1) {
                [_arrayDatas removeAllObjects];
            }
            [_arrayDatas addObjectsFromArray:arrayTmp];
            [self.cvStoragecard reloadData];
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
