//
//  PartnerCompactViewController.m
//  integralMall
//
//  Created by liu on 2018/10/10.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "PartnerCompactViewController.h"
#import "JoinPaySuccessViewController.h"
#import "CashierDeskViewController.h"
#import "PartnerCompactProtocolViewController.h"
#import "DataViewModel.h"

@interface PartnerCompactViewController ()

@end

@implementation PartnerCompactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBarView.titleLabel.text = @"加入合伙人合同";
    
    [self initControl];
}

- (void)initControl{
    self.webView.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *gesture_chk = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_chk_onClicked:)];
    self.imgChk.userInteractionEnabled = YES;
    [self.imgChk addGestureRecognizer:gesture_chk];
    
    UITapGestureRecognizer *gesture_confirm = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_confirm:)];
    self.imgConfirmPay.userInteractionEnabled = YES;
    [self.imgConfirmPay addGestureRecognizer:gesture_confirm];
    
    UITapGestureRecognizer *procotolGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressPartnerCompactProcotolButton)];
    [self.protocolView setUserInteractionEnabled:YES];
    [self.protocolView addGestureRecognizer:procotolGesture];
    
    [self initData];
}

- (void)initData{
    _imgChked = [UIImage imageNamed:@"已勾选_chked.png"];
    _imgUnChk = [UIImage imageNamed:@"未勾选_unchked.png"];
    self.imgChk.image = _imgChked;
}


- (void)getData{
    [self.view DLLoadingInSelf];
    [self performSelectorInBackground:@selector(thread_queryCompact) withObject:nil];
}

//确认支付按钮
- (IBAction)btnConfirmPay:(id)sender {
    [self gesture_confirm:nil];
}

//勾选或不勾选
- (void)gesture_chk_onClicked:(id)sender{
    if (self.imgChk.image == _imgChked) {
        self.imgChk.image = _imgUnChk;
    }else{
        self.imgChk.image = _imgChked;
    }
}

//确认支付
- (void)gesture_confirm:(id)sender{
    if (self.imgChk.image == _imgUnChk) {
        [DLLoading DLToolTipInWindow:@"请先同意《懒店合伙人合同》"];
        return;
    }
//    JoinPaySuccessViewController *joinPaySucViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([JoinPaySuccessViewController class])];
//    [self.navigationController pushViewController:joinPaySucViewCtrl animated:YES];
    //转到收银台
    CashierDeskViewController *cashierDeskViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([CashierDeskViewController class])];
    PayInfoModel *payInfo = [PayInfoModel new];
    payInfo.partner_order_id = self.propertyOrderId;
    payInfo.pay_money = 10000.00;
    payInfo.payTypeEnum = PAY_TYPE_JOINPARTNER;
    cashierDeskViewCtrl.propertyPayInfo = payInfo;
    cashierDeskViewCtrl.isHiddenOfflinePayment = NO;
    
    [self.navigationController pushViewController:cashierDeskViewCtrl animated:YES];
}

//点击阅读协议书
- (void)pressPartnerCompactProcotolButton {
    PartnerCompactProtocolViewController *vc = [PartnerCompactProtocolViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

//查询电子合同 // .propertyUrl
- (void)thread_queryCompact{
    PartnerCompactModel *pcm = [[DataViewModel getInstance] partnerCompact:self.propertyOrderId];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view DLLoadingHideInSelf];
        if (pcm) {
            [self.webView loadHTMLString:pcm.content baseURL:nil];
            self.lblYear.text = pcm.year;
            self.lblMonth.text = pcm.month;
            self.lblDay.text = pcm.day;
            [self setBtnEnable:self.btnConfirm];
        }else{
            [DLLoading DLToolTipInWindow:[DataViewModel getInstance].ERROR_MSG];
        }
    });
}

@end
