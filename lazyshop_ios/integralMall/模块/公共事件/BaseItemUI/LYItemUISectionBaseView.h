//
//  LYItemUISectionBaseView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BindVMProtocol.h"

@interface LYItemUISectionBaseView : UITableViewHeaderFooterView<BindVMProtocol>

@property (nonatomic, readonly) RACSubject *baseClickSignal;

@end
