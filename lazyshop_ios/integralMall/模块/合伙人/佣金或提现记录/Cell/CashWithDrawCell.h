//
//  CashWithDrawCell.h
//  integralMall
//
//  Created by liu on 2018/10/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntityModel.h"
#import "NSString+Extends.h"

NS_ASSUME_NONNULL_BEGIN

@interface CashWithDrawCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UILabel *lblMoney;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statusWidth;

- (void)loadData:(CommissionRecordModel*)model;

@end

NS_ASSUME_NONNULL_END
