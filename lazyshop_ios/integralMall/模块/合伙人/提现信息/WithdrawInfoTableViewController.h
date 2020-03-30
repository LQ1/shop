//
//  WithdrawInfoTableViewController.h
//  integralMall
//
//  Created by liu on 2018/10/17.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^BlockBackSuccess)(void);

@interface WithdrawInfoTableViewController : UITableViewController{
    UIImage *_imgChk,*_imgUnChk;
    int _nType;//1支付宝 2银联
    NSString *_szRealName,*_szAccount;
}

@property int propertyType;

@property BlockBackSuccess propertyBlockBackSuccess;

/// 可提现佣金
@property (assign, nonatomic) CGFloat can_get_commission;

@property (weak, nonatomic) IBOutlet UILabel *withdrawDescLabel;
@property (weak, nonatomic) IBOutlet UIView *viewUnionPay;
@property (weak, nonatomic) IBOutlet UIView *viewAlipyPay;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;
@property (weak, nonatomic) IBOutlet UITextField *txtRealName;
@property (weak, nonatomic) IBOutlet UITextField *txtAccount;
@property (weak, nonatomic) IBOutlet UILabel *lblBackDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblBack;
@property (weak, nonatomic) IBOutlet UILabel *commissionMethodLabel;
@property (weak, nonatomic) IBOutlet UIImageView *protocolImageView;
@property (weak, nonatomic) IBOutlet UIImageView *upOrDownImageView;
@property (weak, nonatomic) IBOutlet UILabel *bankDescLabel;

@end

NS_ASSUME_NONNULL_END
