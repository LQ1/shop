//
//  CashierDeskTableViewController.m
//  integralMall
//
//  Created by liu on 2018/10/17.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "CashierDeskTableViewController.h"
#import "Utility.h"
#import "DataViewModel.h"
#import "DLOtherPayController.h"
#import "JoinPaySuccessViewController.h"

@interface CashierDeskTableViewController ()

@end

@implementation CashierDeskTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [Utility setExtraCellLineHidden:self.tableView];
    _imgChk = [UIImage imageNamed:@"已勾选_chked.png"];
    _imgUnChk = [UIImage imageNamed:@"未勾选_unchked.png"];
    _nPayType = 1;

}

- (void)viewDidAppear:(BOOL)animated{
    self.lblPayMoney.text = [NSString stringWithFormat:@"￥%.2f",self.propertyPayInfo.pay_money];
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row < 3) {//静态label
        return;
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    for (int i=1; i<5; i++) {
        UIImageView *imgView = [self.view viewWithTag:i];
        if (imgView) {
            imgView.image = _imgUnChk;
        }
    }
    
    NSArray *arraySubViews = cell.contentView.subviews;
    UIImageView *img = [arraySubViews objectAtIndex:1];
    if (img) {
        img.image = _imgChk;
    }
    _nPayType = (int)img.tag;
}

//提交
- (void)doSumbit{
    [self.view DLLoadingInSelf];
    [self performSelectorInBackground:@selector(thread_pay) withObject:nil];
}

- (void)thread_pay{
    if (_nPayType == 1) {
        //微信
        [self handlePay_wx];
    }else if(_nPayType == 2){
        //支付宝
        [self handlePay_Alipy];
    }else if(_nPayType == 3){
        //银联
        [self handlePay_Union];
    }else if(_nPayType == 4){
        //线下
        [self handlePay_offline];
    }
}

//微信支付
- (void)handlePay_wx{
    WxPayModel *wxPayModel = [[DataViewModel getInstance] payByWx:self.propertyPayInfo.partner_order_id withOrderType:1];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view DLLoadingHideInSelf];
        if (wxPayModel) {
            [[DLOtherPayController sharedInstance] startWXPayWithAppid:wxPayModel.appid
                                                             partnerID:wxPayModel.partnerid
                                                              prepayID:wxPayModel.prepayid
                                                              nonceStr:wxPayModel.noncestr
                                                             timeStamp:[wxPayModel.timestamp intValue]
                                                               package:wxPayModel.package_value
                                                                  sign:wxPayModel.sign
                                                            isAppAgree:[LYAppCheckManager shareInstance].isAppAgree
                                                            paySuccess:^{
                                                                // 微信支付成功
                                                                [self onPaySuccess];
                                                            } payFailed:^{
                                                                // 微信支付失败
                                                                
                                                            }];
        }else{
            [DLLoading DLToolTipInWindow:[DataViewModel getInstance].ERROR_MSG];
        }
    });
}

//支付宝支付
- (void)handlePay_Alipy{
    NSString *szPayStr = [[DataViewModel getInstance] payByAlipy:self.propertyPayInfo.partner_order_id withOrderType:1];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view DLLoadingHideInSelf];
        
        if (![Utility isStringEmptyOrNull:szPayStr]) {
            [[DLOtherPayController sharedInstance] startAliPayWithOrderString:szPayStr paySuccess:^{
                // 支付宝支付成功
                [self onPaySuccess];
            } payFailed:^{
                // 支付宝支付失败
            }];
        }else{
            [DLLoading DLToolTipInWindow:[DataViewModel getInstance].ERROR_MSG];
        }
        
    });
}

//银联支付
- (void)handlePay_Union{
    NSString *szPayStr = [[DataViewModel getInstance] payByUnion:self.propertyPayInfo.partner_order_id withOrderType:1];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view DLLoadingHideInSelf];
        
        if (![Utility isStringEmptyOrNull:szPayStr]) {
            [[DLOtherPayController sharedInstance] startUnionSDKPayWithTranNumber:szPayStr
                                                                   viewController:self
                                                                       paySuccess:^{
                                                                           // 银联支付成功
                                                                           [self onPaySuccess];
                                                                       } payFailed:^{
                                                                           // 银联支付失败
                                                                           
                                                                           
                                                                       }];
            
        }else{
            [DLLoading DLToolTipInWindow:[DataViewModel getInstance].ERROR_MSG];
        }
        
    });
}

//线下支付
- (void)handlePay_offline {
    NSDictionary *dictionary = [[DataViewModel getInstance] offlinePayments:self.propertyPayInfo.partner_order_id];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view DLLoadingHideInSelf];
        
        if (![Utility isStringEmptyOrNull:[dictionary objectForKey:@"toast"]]) {
            [DLLoading DLToolTipInWindow:[dictionary objectForKey:@"toast"]];
            
            // 状态1 订单已支付
            if ([[dictionary objectForKey:@"status"] intValue] == 1) {
                [self onPaySuccess];
            }
        }else{
            [DLLoading DLToolTipInWindow:[DataViewModel getInstance].ERROR_MSG];
        }
    });
}

//支付成功--跳转到支付成功页面
- (void)onPaySuccess{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        switch (self.propertyPayInfo.payTypeEnum) {
            case PAY_TYPE_JOINPARTNER://加入合伙人跳转
                {
                    JoinPaySuccessViewController *joinPaySucViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([JoinPaySuccessViewController class])];
                    [self.navigationController pushViewController:joinPaySucViewCtrl animated:YES];
                }
                break;
            case PAY_TYPE_BUY_STOAGECARD://购买w储值卡跳转
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
                break;
            default:
                break;
        }
        
    });
}

@end
