//
//  BailViewController.m
//  integralMall
//
//  Created by liu on 2018/10/14.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "BailViewController.h"
#import "WithdrawInfoViewController.h"

@interface BailViewController ()

@end

@implementation BailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBarView.titleLabel.text = @"权益金";

    [self initControl];
}

- (void)viewDidAppear:(BOOL)animated{
    [_viewScrollArea startAnimationNotice];
}

- (void)initControl{
    self.imgAvatar.layer.cornerRadius = self.imgAvatar.frame.size.width*0.5f;
    self.imgAvatar.layer.masksToBounds = YES;
    
    self.webView.backgroundColor = [UIColor whiteColor];
    
    
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F4F5F6"];
    [self initData];
}

- (void)initData{
    _viewScrollArea = [[ViewPartnerScrollArea alloc] initWithParentView:self.viewPartner];
    
    [self.view DLLoadingInSelf];
    [self performSelectorInBackground:@selector(thread_query) withObject:nil];
}

- (void)getData{
    
}
//退还保证金
- (IBAction)btnBackBond_onClicked:(id)sender {
    [self.view DLLoadingInSelf];
    [self performSelectorInBackground:@selector(thread_chk_refund) withObject:nil];
    
}

//我要续约
- (IBAction)btnAdd_onClicked:(id)sender {
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要续约?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *actConfirm = [UIAlertAction actionWithTitle:@"确认续约" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.view DLLoadingInSelf];
        [self performSelectorInBackground:@selector(thread_renew) withObject:nil];
    }];
    [alertCtrl addAction:actCancel];
    [alertCtrl addAction:actConfirm];
    
    [self presentViewController:alertCtrl animated:YES completion:nil];
    
}

//更新界面数据
- (void)updateInterface:(BondModel*)model{
    [ImageLoadingUtils loadImage:self.imgAvatar withURL:model.partner_avatar];
    [ImageLoadingUtils loadImage:self.imgTeamLogo withURL:model.team_sign_thumb];
    self.lblTeamLevel.text = model.team_title;
    self.lblNickName.text = model.partner_nickname;
    self.lblBuyDT.text = [NSString stringWithFormat:@"权益金购买日期:%@",model.buy_time];
    self.lblEndDT.text = [NSString stringWithFormat:@"权益金到期日期:%@",model.exp_time];
    NSString *szBond = [NSString stringWithFormat:@"￥%0.2f权益金",model.bond];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:szBond];
    NSRange range = {szBond.length-3,3};
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0f] range:range];
    self.lblBond.attributedText = attrStr;
    [self.webView loadHTMLString:model.bond_desc baseURL:nil];
}

//查询数据
- (void)thread_query{
    BondModel *model = [[DataViewModel getInstance] partnerBond];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view DLLoadingHideInSelf];
        if (model) {
            [self updateInterface:model];
        }else{
            [DLLoading DLToolTipInWindow:[DataViewModel getInstance].ERROR_MSG];
        }
    });
}

//退还保证金
- (void)thread_chk_refund{
    BOOL bRet = [[DataViewModel getInstance] partnerChkRefund];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view DLLoadingHideInSelf];
       if (bRet) {
            WithdrawInfoViewController *withdrawViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([WithdrawInfoViewController class])];
            withdrawViewCtrl.propertyType = 2;
            [self.navigationController pushViewController:withdrawViewCtrl animated:YES];
        }else{
            [DLLoading DLToolTipInWindow:[DataViewModel getInstance].ERROR_MSG];
        }
    });
    
}

//我要续约
- (void)thread_renew{
    NSString *szMsg = [[DataViewModel getInstance] partnerRenewContract];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view DLLoadingHideInSelf];
        
        if (szMsg == nil) {
            [DLLoading DLToolTipInWindow:[DataViewModel getInstance].ERROR_MSG];
        }else{
            [DLLoading DLToolTipInWindow:szMsg];
        }
    });
    
}

@end
