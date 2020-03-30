//
//  MyRecommendViewController.h
//  integralMall
//
//  Created by liu on 2018/10/13.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePartnerViewController.h"
#import "EntityModel.h"
#import "ViewPartnerScrollArea.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyRecommendViewController : BasePartnerViewController{
    MyRecommendInfoModel *_myRecInfo;
    NSMutableArray *_arrayDatas;
    ViewPartnerScrollArea *_viewScrollArea;
}
@property (weak, nonatomic) IBOutlet UIView *viewScroll;
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UIImageView *imgTeamLogo;
@property (weak, nonatomic) IBOutlet UILabel *lblNickName;
@property (weak, nonatomic) IBOutlet UILabel *lblCorpLevel;
@property (weak, nonatomic) IBOutlet UILabel *lblCorpCount;
@property (weak, nonatomic) IBOutlet UIImageView *imgRecommend;
@property (weak, nonatomic) IBOutlet UITableView *tabView;
@property (weak, nonatomic) IBOutlet UILabel *lblL2;
@property (weak, nonatomic) IBOutlet UILabel *lblL3;
@property (weak, nonatomic) IBOutlet UIView *viewPartner;

@end

NS_ASSUME_NONNULL_END
