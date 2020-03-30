//
//  FeedBackViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

@interface FeedBackViewModel : BaseViewModel

- (NSArray *)fetchSwitchViewModels;

@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *phoneNumber;

- (void)submitFeedBack;

@end
