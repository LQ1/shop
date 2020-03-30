//
//  EntityJson.h
//  fishPond
//
//  Created by liu on 16/3/5.
//  Copyright (c) 2016年 bytsh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EntityJson : NSObject

+ (void)JsonToEntity:(NSDictionary*)dictJson withEntity:(NSObject*)obj;

+ (void)JsonToEntity:(NSDictionary*)dictJson withEntity:(NSObject*)obj withSubEntity:(Class)subClass;


+ (NSString*)entityToString:(NSObject*)entity;

@end
