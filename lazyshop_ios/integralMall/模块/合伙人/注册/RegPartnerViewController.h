//
//  RegPartnerViewController.h
//  integralMall
//
//  Created by liu on 2018/10/9.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "BaseViewController.h"
#import "LYNavigationBarViewController.h"
#import "BasePartnerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegPartnerViewController : BasePartnerViewController
@property (weak, nonatomic) IBOutlet UIView *viewContainer;

@property NSString *propertyRefUsrId;


@end

NS_ASSUME_NONNULL_END
