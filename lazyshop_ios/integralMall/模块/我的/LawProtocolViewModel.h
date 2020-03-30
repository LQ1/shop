//
//  LawProtocolViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/12.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

@interface LawProtocolViewModel : BaseViewModel

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *content;

- (instancetype)initWithContentID:(NSString *)contentID;

- (void)getData;

@end
