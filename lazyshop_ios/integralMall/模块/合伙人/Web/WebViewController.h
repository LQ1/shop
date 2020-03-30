//
//  WebViewController.h
//  integralMall
//
//  Created by liu on 2019/1/4.
//  Copyright © 2019 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePartnerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : BasePartnerViewController<UIWebViewDelegate>

@property NSString *propertyUrl;

@property (weak, nonatomic) IBOutlet UIWebView *web;

@end

NS_ASSUME_NONNULL_END
