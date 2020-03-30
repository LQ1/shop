//
//  NSURL+Extends.h
//  BytshBase
//
//  Created by liu on 2018/9/29.
//  Copyright © 2018年 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (Extends)

- (NSMutableDictionary *)getURLParameters:(NSString *)urlStr;

@end

NS_ASSUME_NONNULL_END
