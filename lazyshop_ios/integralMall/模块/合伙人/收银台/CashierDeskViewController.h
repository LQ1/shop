//
//  CashierDeskViewController.h
//  integralMall
//
//  Created by liu on 2018/10/17.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePartnerViewController.h"
#import "EntityModel.h"

NS_ASSUME_NONNULL_BEGIN



@interface CashierDeskViewController : BasePartnerViewController

//@property PartnerMyPageModel *propertyPartnerMyPage;
//@property int propertyOrderId;
//@property double propertyPayMoney;

@property PayInfoModel *propertyPayInfo;
@property (assign, nonatomic) BOOL isHiddenOfflinePayment;

@property (weak, nonatomic) IBOutlet UIImageView *imgConfirm;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;

@end

NS_ASSUME_NONNULL_END
