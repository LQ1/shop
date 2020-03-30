//
//  LYItemUIBaseCell.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BindVMProtocol.h"

@interface LYItemUIBaseCell : UITableViewCell<BindVMProtocol>

@property (nonatomic, readonly) RACSubject *itemClickSignal;
@property (nonatomic, readonly) RACSubject *baseClickSignal;

@end
