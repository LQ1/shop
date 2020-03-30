//
//  StorageBuyViewController.m
//  integralMall
//
//  Created by liu on 2018/12/29.
//  Copyright © 2018 Eggache_Yang. All rights reserved.
//

#import "StorageBuyViewController.h"
#import "CashierDeskViewController.h"
#import "StorageBuyTableViewController.h"

@interface StorageBuyViewController ()

@end

@implementation StorageBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBarView.titleLabel.text = @"储值卡详情";
    
    [self initControl];
}

- (void)getData{
    
}

- (void)initControl{
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F4F5F6"];
    
    [self setBtnDisable:self.btnBuy];
    
    [self initData];
}

- (void)initData{

    [self.view DLLoadingInSelf];
    [self performSelectorInBackground:@selector(thread_queryStoreCardDetail) withObject:nil];
}

//购买
- (IBAction)btnBuy_onclicked:(id)sender {
    [self.view DLLoadingInSelf];
    [self performSelectorInBackground:@selector(thread_storeCardBuy) withObject:nil];
}

//主界面更新
- (void)updateInMain:(StorageCardModel*)model{
    UITableView *tabView = [self.containerView.subviews firstObject];
    StorageBuyTableViewController *StorageBuyTvCtrl = (StorageBuyTableViewController*)tabView.dataSource;
    [StorageBuyTvCtrl updateInMain:model];

    [self setBtnEnable:self.btnBuy];
}

//查询
- (void)thread_queryStoreCardDetail{
    StorageCardModel *model = [[DataViewModel getInstance] storageCardDetail:self.store_card_id];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view DLLoadingHideInSelf];
        if (model) {
            [self performSelectorOnMainThread:@selector(updateInMain:) withObject:model waitUntilDone:NO];
        }else{
            [DLLoading DLToolTipInWindow:[DataViewModel getInstance].ERROR_MSG];
        }
    });
    
}

//购买
- (void)thread_storeCardBuy{
    StorageCardPayModel *storeCardPay = [[DataViewModel getInstance] storeCardBuy:self.store_card_id];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view DLLoadingHideInSelf];
        if (storeCardPay) {
            CashierDeskViewController *cashDeskViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([CashierDeskViewController class])];
            PayInfoModel *payInfo = [PayInfoModel new];
            payInfo.partner_order_id = storeCardPay.partner_order_id;
            payInfo.pay_money = storeCardPay.pay_money;
            payInfo.payTypeEnum = PAY_TYPE_BUY_STOAGECARD;
            cashDeskViewCtrl.propertyPayInfo = payInfo;
            cashDeskViewCtrl.isHiddenOfflinePayment = YES;
            
            [self.navigationController pushViewController:cashDeskViewCtrl animated:YES];
        }else{
            [DLLoading DLToolTipInWindow:[DataViewModel getInstance].ERROR_MSG];
        }
    });
}

@end
