//
//  WithdrawInfoViewController.h
//  integralMall
//
//  Created by liu on 2018/10/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePartnerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WithdrawInfoViewController : BasePartnerViewController

//1.提现   2.退还保证金  3.提现支付信息
@property int propertyType;
/// 可提现佣金
@property (assign, nonatomic) CGFloat can_get_commission;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UIView *viewBackBondSuc;
@property (weak, nonatomic) IBOutlet UIImageView *imgClose;
@property (weak, nonatomic) IBOutlet UIImageView *imgTips;

@end

NS_ASSUME_NONNULL_END
