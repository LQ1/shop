//
//  BailViewController.h
//  integralMall
//
//  Created by liu on 2018/10/14.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePartnerViewController.h"
#import "Include.h"
#import "ViewPartnerScrollArea.h"

NS_ASSUME_NONNULL_BEGIN

@interface BailViewController : BasePartnerViewController{
    ViewPartnerScrollArea *_viewScrollArea;
}
@property (weak, nonatomic) IBOutlet UIView *viewPartner;
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UIImageView *imgTeamLogo;
@property (weak, nonatomic) IBOutlet UILabel *lblNickName;
@property (weak, nonatomic) IBOutlet UILabel *lblTeamLevel;
@property (weak, nonatomic) IBOutlet UILabel *lblBond;
@property (weak, nonatomic) IBOutlet UILabel *lblBuyDT;
@property (weak, nonatomic) IBOutlet UILabel *lblEndDT;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *btnBackBond;
@property (weak, nonatomic) IBOutlet UIButton *btnAddBond;

@end

NS_ASSUME_NONNULL_END
