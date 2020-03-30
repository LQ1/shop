//
//  PartnerCompactProtocolViewModel.h
//  integralMall
//
//  Created by lc on 2019/10/26.
//  Copyright © 2019 Eggache_Yang. All rights reserved.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PartnerCompactProtocolViewModel : BaseViewModel

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *content;

- (void)getData;

@end

NS_ASSUME_NONNULL_END
