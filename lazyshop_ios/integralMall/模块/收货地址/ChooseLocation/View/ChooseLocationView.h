//
//  ChooseLocationView.h
//  ChooseLocation
//
//  Created by Sekorm on 16/8/22.
//  Copyright © 2016年 HY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShippingAddressEidtViewModel;

@interface ChooseLocationView : UIView

@property (nonatomic, copy) NSString * address;

@property (nonatomic,strong)ShippingAddressEidtViewModel *viewModel;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)bindViewModel:(ShippingAddressEidtViewModel *)viewModel;

- (void)setSelectAddress;

@end
