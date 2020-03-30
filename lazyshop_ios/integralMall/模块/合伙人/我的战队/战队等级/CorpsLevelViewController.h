//
//  CorpsLevelViewController.h
//  integralMall
//
//  Created by liu on 2018/10/10.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYNavigationBarViewController.h"
#import "ViewPartnerScrollArea.h"
#import "Include.h"

NS_ASSUME_NONNULL_BEGIN

@interface CorpsLevelViewController : LYNavigationBarViewController{
    ViewPartnerScrollArea *_viewScrollArea;
}
@property (weak, nonatomic) IBOutlet UIView *viewPartner;
@property (weak, nonatomic) IBOutlet UILabel *lblHasRecommend;
@property (weak, nonatomic) IBOutlet UILabel *lblPartner;
@property (weak, nonatomic) IBOutlet UILabel *lblNextCon;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIImageView *imgTeam;

@end

NS_ASSUME_NONNULL_END
