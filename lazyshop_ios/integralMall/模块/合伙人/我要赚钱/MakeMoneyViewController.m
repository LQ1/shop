//
//  MakeMoneyViewController.m
//  integralMall
//
//  Created by liu on 2018/10/10.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "MakeMoneyViewController.h"
#import "UIColor+YYAdd.h"
#import "DataViewModel.h"
#import "MakeMoneyBuyCell.h"
#import "Utility.h"
#import "CouponViewController.h"
#import "QRCodeView.h"
#import "CategoryViewController.h"

@interface MakeMoneyViewController ()

@end

@implementation MakeMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBarView.titleLabel.text = @"我要赚钱";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F4F5F6"];
    
    [self initControl];
}

- (void)viewDidAppear:(BOOL)animated{
    [_viewScrollArea startAnimationNotice];
}

- (void)initControl{
    [Utility setExtraCellLineHidden:self.tabView];
    [self.tabView registerNib:[UINib nibWithNibName:NSStringFromClass([MakeMoneyBuyCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MakeMoneyBuyCell class])];
    
    UITapGestureRecognizer *gesture_onekey = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_onkey_recomment_onClicked:)];
    self.imgRecomment.userInteractionEnabled = YES;
    [self.imgRecomment addGestureRecognizer:gesture_onekey];
    
    UITapGestureRecognizer *gesture_coupon = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_coupon_onClicked:)];
    self.viewCoupon.userInteractionEnabled = YES;
    [self.viewCoupon addGestureRecognizer:gesture_coupon];
    
    UITapGestureRecognizer *gesture_recommend = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_recommend_onClicked:)];
    self.viewRecommend.userInteractionEnabled = YES;
    [self.viewRecommend addGestureRecognizer:gesture_recommend];
    
    [self initData];
}

- (void)initData{
    _arrayDatas = [NSMutableArray new];
    
    _viewScrollArea = [[ViewPartnerScrollArea alloc] initWithParentView:self.viewPartner];
    
    [self.view DLLoadingInSelf];
    [self performSelectorInBackground:@selector(thread_queryBuyInfo) withObject:nil];
}

- (void)getData {
    
}

//一键推荐
- (void)gesture_onkey_recomment_onClicked:(id)sender{
    [self.view DLLoadingInSelf];
    [self performSelectorInBackground:@selector(thread_recomment) withObject:nil];
}

//优惠券
- (void)gesture_coupon_onClicked:(id)sender{
    CouponViewController *couponViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([CouponViewController class])];
    [self.navigationController pushViewController:couponViewCtrl animated:YES];
}

//推荐单品
- (void)gesture_recommend_onClicked:(id)sender{
    CategoryViewController *categoryViewCtrl = [[CategoryViewController alloc] init];
    categoryViewCtrl.isEnterFromMakeMoney = YES;
    [self.navigationController pushViewController:categoryViewCtrl animated:YES];
}

#pragma mark uitableview delegate
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 56;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrayDatas.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    MakeMoneyBuyInfoModel *model = [_arrayDatas objectAtIndex:indexPath.row];
    MakeMoneyBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MakeMoneyBuyCell class])];
    [cell loadData:model];
    
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//查询购买情况
- (void)thread_queryBuyInfo{
    MakeMoneyModel *makeMoney = [[DataViewModel getInstance] makeMoney:_nPageNum];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view DLLoadingHideInSelf];
        //更新佣金描述
        self.lblYJDesc.text = [NSString stringWithFormat:@"一级佣金%@ 二级佣金%@",makeMoney.first_level,makeMoney.second_level];
        
        if (makeMoney) {
            if (_nPageNum == 1) {
                [_arrayDatas removeAllObjects];
            }
            [_arrayDatas addObjectsFromArray:makeMoney.recommend];
            [self.tabView reloadData];
        }else{
            [DLLoading DLToolTipInWindow:[DataViewModel getInstance].ERROR_MSG];
        }
    });
}

//一键推荐
- (void)thread_recomment{
    NSString *szQRCodeUrl = [[DataViewModel getInstance] partnerQRCode:1 withGoodsId:@""];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view DLLoadingHideInSelf];
        
        if (![Utility isStringEmptyOrNull:szQRCodeUrl]) {
            NSArray *arrayViews = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([QRCodeView class]) owner:nil options:nil];
            QRCodeView *viewQRCode = [arrayViews objectAtIndex:0];
            [viewQRCode setFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
            [viewQRCode initEvent];
            [viewQRCode loadImage:szQRCodeUrl];
            
            CABasicAnimation *aniScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            aniScale.duration = 0.5f;
            aniScale.fromValue = [NSNumber numberWithFloat:0.1f];
            aniScale.toValue = [NSNumber numberWithFloat:1.0f];
            [viewQRCode.layer addAnimation:aniScale forKey:@"ANI_SCALE"];
            
            [self.view addSubview:viewQRCode];
            
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
