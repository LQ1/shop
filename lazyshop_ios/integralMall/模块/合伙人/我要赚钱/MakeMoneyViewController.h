//
//  MakeMoneyViewController.h
//  integralMall
//
//  Created by liu on 2018/10/10.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePartnerViewController.h"
#import "ViewPartnerScrollArea.h"
#import "UIViewAnimation.h"

NS_ASSUME_NONNULL_BEGIN

@interface MakeMoneyViewController : BasePartnerViewController{
    int _nPageNum;
    NSMutableArray *_arrayDatas;
    ViewPartnerScrollArea *_viewScrollArea;
}
@property (weak, nonatomic) IBOutlet UILabel *lblYJDesc;
@property (weak, nonatomic) IBOutlet UITableView *tabView;
@property (weak, nonatomic) IBOutlet UIView *viewCoupon;
@property (weak, nonatomic) IBOutlet UIView *viewRecommend;
@property (weak, nonatomic) IBOutlet UIView *viewPartner;
@property (weak, nonatomic) IBOutlet UIImageView *imgRecomment;

@end

NS_ASSUME_NONNULL_END
