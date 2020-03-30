//
//  BalanceCenterViewController.h
//  integralMall
//
//  Created by liu on 2018/10/13.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePartnerViewController.h"
#import "Include.h"

NS_ASSUME_NONNULL_BEGIN

@interface BalanceCenterViewController : BasePartnerViewController{
    CommissionPopupModel *_commissionPopModel;
}
@property (weak, nonatomic) IBOutlet UIView *viewCash;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnCash;
@property (weak, nonatomic) IBOutlet UILabel *lblCommission;
@property (weak, nonatomic) IBOutlet UILabel *lblFreezion;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UIView *viewCenter;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;

@end

NS_ASSUME_NONNULL_END
