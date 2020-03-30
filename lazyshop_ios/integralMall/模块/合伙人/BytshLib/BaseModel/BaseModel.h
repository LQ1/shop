//
//  BaseModel.h
//  PartyConstruction
//
//  Created by liu on 2017/11/10.
//  Copyright © 2017年 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel1 : NSObject<NSCoding>

- (NSDictionary*)toDictionary;

- (id)clone;

- (void)encodeWithCoder:(NSCoder *)aCoder;

- (id)initWithCoder:(NSCoder *)aDecoder;



@end
