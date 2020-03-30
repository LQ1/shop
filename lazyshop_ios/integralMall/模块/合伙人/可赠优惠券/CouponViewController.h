//
//  CouponViewController.h
//  integralMall
//
//  Created by liu on 2018/10/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePartnerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CouponViewController : BasePartnerViewController {
    NSMutableArray *_arrayDatas;
    NSString *_szIds;
}
@property (weak, nonatomic) IBOutlet UITableView *tabView;
@property (weak, nonatomic) IBOutlet UIView *viewAlpha;
@property (weak, nonatomic) IBOutlet UITextField *txtMobile;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;

@end

NS_ASSUME_NONNULL_END
