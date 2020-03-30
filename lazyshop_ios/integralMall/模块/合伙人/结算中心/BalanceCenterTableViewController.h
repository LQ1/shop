//
//  BalanceCenterTableViewController.h
//  integralMall
//
//  Created by liu on 2018/10/13.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntityModel.h"
#import "ViewPartnerScrollArea.h"

NS_ASSUME_NONNULL_BEGIN

//佣金提现点击
typedef void (^BlockCommissionCash) (SettlementCenterModel *settleCenter);

@interface BalanceCenterTableViewController : UITableViewController{
    SettlementCenterModel *_settlementCenter;
    ViewPartnerScrollArea *_viewScrollArea;
}

@property BlockCommissionCash propertyCommissionCashBlock;

@property (weak, nonatomic) IBOutlet UIView *viewHeaderCorner;
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UIImageView *imgTeamLogo;
@property (weak, nonatomic) IBOutlet UILabel *lblNickName;
@property (weak, nonatomic) IBOutlet UILabel *lblCropLevel;
@property (weak, nonatomic) IBOutlet UILabel *lblSaleCommission;
@property (weak, nonatomic) IBOutlet UILabel *lblStoreSellGoods;
@property (weak, nonatomic) IBOutlet UILabel *lblRecommend;
@property (weak, nonatomic) IBOutlet UIView *viewWithdraw;
@property (weak, nonatomic) IBOutlet UIView *viewCommission;
@property (weak, nonatomic) IBOutlet UIView *viewPayInfo;
@property (weak, nonatomic) IBOutlet UIView *viewBail;
@property (weak, nonatomic) IBOutlet UIView *viewPartner;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *viewCash;

@end

NS_ASSUME_NONNULL_END
