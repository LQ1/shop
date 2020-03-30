//
//  PartnerCompactViewController.h
//  integralMall
//  合伙人合同
//  Created by liu on 2018/10/10.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYNavigationBarViewController.h"
#import "BasePartnerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PartnerCompactViewController : BasePartnerViewController{
    UIImage *_imgChked,*_imgUnChk;
}

@property int propertyOrderId;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *lblYear;
@property (weak, nonatomic) IBOutlet UILabel *lblMonth;
@property (weak, nonatomic) IBOutlet UILabel *lblDay;
@property (weak, nonatomic) IBOutlet UIImageView *imgChk;
@property (weak, nonatomic) IBOutlet UILabel *lblCompact;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;
@property (weak, nonatomic) IBOutlet UIView *protocolView;

@property (weak, nonatomic) IBOutlet UIImageView *imgConfirmPay;

@end

NS_ASSUME_NONNULL_END
