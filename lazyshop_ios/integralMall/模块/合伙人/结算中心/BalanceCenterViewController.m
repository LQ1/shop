//
//  BalanceCenterViewController.m
//  integralMall
//
//  Created by liu on 2018/10/13.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "BalanceCenterViewController.h"
#import "BalanceCenterTableViewController.h"
#import "WithdrawInfoViewController.h"
#import "UIViewAnimation.h"

@interface BalanceCenterViewController ()

@end

@implementation BalanceCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBarView.titleLabel.text = @"结算中心";
    
    //[self.viewCenter removeFromSuperview];
    
    UITableView *tabView = [self.viewContainer.subviews firstObject];
    BalanceCenterTableViewController *bcTvCtrl = (BalanceCenterTableViewController*)tabView.dataSource;
    bcTvCtrl.propertyCommissionCashBlock = ^(SettlementCenterModel * _Nonnull settleCenter) {
        if (!_commissionPopModel) {
            //如果初次没有查询到数据 这里再查询一次
            
        }
        
        //UIViewAnimation *ani = [[UIViewAnimation alloc] init];
        //ani.isShowInnterViewAnimation = YES;
        //[ani showViewAnimation:MoveIn withSelfView:self.viewCenter];
        //self.viewCenter.alpha = 1;
        [self.view DLLoadingInSelf];
        [self performSelectorInBackground:@selector(thread_queryCommission) withObject:nil];
        //self.viewCash.hidden = NO;
    };
    self.viewCenter.layer.cornerRadius = 6.0f;
    self.viewCenter.layer.masksToBounds = YES;
    
    [self.btnCancel addTarget:self action:@selector(btnCancel_onClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnCash addTarget:self action:@selector(btnConfirm_onClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //[self performSelectorInBackground:@selector(thread_queryCommission) withObject:nil];
}

- (void)getData{
    
}

//取消
- (void)btnCancel_onClicked:(id)sender{
    self.viewCash.hidden = YES;
}

//提交
- (void)btnConfirm_onClicked:(id)sender{
    if (_commissionPopModel) {
        if (_commissionPopModel.can_get_commission > 0) {
            WithdrawInfoViewController *withdrawInfoViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([WithdrawInfoViewController class])];
            withdrawInfoViewCtrl.propertyType = 1;//提现信息
            withdrawInfoViewCtrl.can_get_commission = _commissionPopModel.can_get_commission;
            [self.navigationController pushViewController:withdrawInfoViewCtrl animated:YES];
            self.viewCash.hidden = YES;
        }else{
            [DLLoading DLToolTipInWindow:@"当前无可提现的佣金"];
        }
    }else{
        [DLLoading DLToolTipInWindow:@"操作失败"];
    }
}


//查询佣金提现信息
- (void)thread_queryCommission{
    _commissionPopModel = [[DataViewModel getInstance] commissionPopup];
    if (_commissionPopModel) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view DLLoadingHideInSelf];
            
            self.lblCommission.text = [NSString stringWithFormat:@"%.2f",_commissionPopModel.can_get_commission];
            self.lblFreezion.text = [NSString stringWithFormat:@"%.2f",_commissionPopModel.frozen_commission];
            self.lblDesc.text = [Utility getSafeString:_commissionPopModel.frozen_desc];
            self.viewCash.hidden = NO;
        });
    }
}

@end
