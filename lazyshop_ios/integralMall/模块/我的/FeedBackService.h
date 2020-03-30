//
//  FeedBackService.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/2.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedBackService : NSObject

- (RACSignal *)submitFeedBackWithType:(NSString *)type
                              content:(NSString *)content
                               mobile:(NSString *)mobile;

@end
