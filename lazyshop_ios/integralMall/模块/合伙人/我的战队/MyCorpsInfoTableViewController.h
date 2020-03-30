//
//  MyCorpsInfoTableViewController.h
//  integralMall
//
//  Created by liu on 2018/10/13.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntityModel.h"
#import "ViewPartnerScrollArea.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyCorpsInfoTableViewController : UITableViewController{
    PartnerMyPageModel *_partnerMyPage;
    ViewPartnerScrollArea *_viewScrollArea;
    BOOL _isFirstLoad;
}
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIView *viewMenu;
@property (weak, nonatomic) IBOutlet UIView *viewPartner;
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblNickName;
@property (weak, nonatomic) IBOutlet UILabel *lblTeamNum;
@property (weak, nonatomic) IBOutlet UILabel *lblCommission;
@property (weak, nonatomic) IBOutlet UIView *viewMakeMoney;
@property (weak, nonatomic) IBOutlet UIView *viewRecommend;
@property (weak, nonatomic) IBOutlet UIView *viewBalanceCenter;
@property (weak, nonatomic) IBOutlet UIView *viewStudy;
@property (weak, nonatomic) IBOutlet UIButton *btnEmBuy;
@property (weak, nonatomic) IBOutlet UIImageView *imgSCBuy;
@property (weak, nonatomic) IBOutlet UIImageView *imgFootbanner;
@property (weak, nonatomic) IBOutlet UIImageView *viewCropLevel;
@property (weak, nonatomic) IBOutlet UILabel *lblBond;
@property (weak, nonatomic) IBOutlet UIImageView *imgShareApp;

@end

NS_ASSUME_NONNULL_END
