//
//  PartnerSimpleIntroViewController.h
//  integralMall
//  合伙人简介
//  Created by liu on 2018/10/10.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYNavigationBarViewController.h"
#import "DataViewModel.h"
#import "BasePartnerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PartnerSimpleIntroViewController : BasePartnerViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *btnJoinPartner;

@property NSString *propertyRefUsrId;

@end

NS_ASSUME_NONNULL_END
