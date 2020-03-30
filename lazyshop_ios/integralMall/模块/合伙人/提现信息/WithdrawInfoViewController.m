//
//  WithdrawInfoViewController.m
//  integralMall
//
//  Created by liu on 2018/10/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "WithdrawInfoViewController.h"
#import "WithdrawInfoTableViewController.h"

@interface WithdrawInfoViewController ()

@end

@implementation WithdrawInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.propertyType == 1) {
        self.navigationBarView.titleLabel.text = @"提现";
    } else if (self.propertyType == 2) {
        self.navigationBarView.titleLabel.text = @"退还保证金";
        self.imgTips.image = [UIImage imageNamed:@"refund_success"];
    } else {
        self.navigationBarView.titleLabel.text = @"支付信息";
    }
    
    UITableView *tabView = [self.viewContainer.subviews objectAtIndex:0];
    WithdrawInfoTableViewController *withdrawInfoTabViewCtrl = (WithdrawInfoTableViewController*)tabView.dataSource;
    withdrawInfoTabViewCtrl.propertyBlockBackSuccess = ^{
        
        self.viewBackBondSuc.hidden = NO;
    };
    withdrawInfoTabViewCtrl.propertyType = self.propertyType;
    withdrawInfoTabViewCtrl.can_get_commission = self.can_get_commission;
    
    UITapGestureRecognizer *gesture_close = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_close_onClicked:)];
    self.imgClose.userInteractionEnabled = YES;
    [self.imgClose addGestureRecognizer:gesture_close];
}

- (void)getData{
    
}

//关闭
- (void)gesture_close_onClicked:(id)sender{
    self.viewBackBondSuc.hidden = YES;
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
