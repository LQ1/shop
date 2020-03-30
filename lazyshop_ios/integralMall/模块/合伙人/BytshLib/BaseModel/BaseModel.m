//
//  BaseModel.m
//  PartyConstruction
//
//  Created by liu on 2017/11/10.
//  Copyright © 2017年 liu. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>

@implementation BaseModel1

- (NSDictionary*)toDictionary{
    NSMutableDictionary *dct = [NSMutableDictionary new];
    unsigned int nCount;
    objc_property_t *properties = class_copyPropertyList([self class],&nCount);
    
    for (int i=0; i<nCount; i++) {
        objc_property_t property = properties[i];
        NSString *szName = [NSString stringWithUTF8String:(property_getName(property))];
        [dct setValue:[self valueForKey:szName] forKey:szName];
    }
    return dct;
}


- (id)clone{
    id obj = class_createInstance([self class], sizeof(self));
    unsigned int nCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class],&nCount);
    for (int i=0; i<nCount; i++) {
        objc_property_t property = properties[i];
        NSString *szName = [NSString stringWithUTF8String:(property_getName(property))];
        const char *szAttr = property_getAttributes(property);
        NSString *strAttr = [NSString stringWithUTF8String:szAttr];
        if (![self isReadOnly:strAttr]) {
            [obj setValue:[self valueForKey:szName] forKey:szName];
        }
    }
    return obj;
}

- (BOOL)isReadOnly:(NSString*)szStr{
    NSArray *arraySplits = [szStr componentsSeparatedByString:@","];
    for (NSString *s in arraySplits) {
        if ([@"R" isEqualToString:s]) {
            return YES;
        }
    }
    return NO;
}

//序列化数据
- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int nCount,nPropertyCount;
    objc_property_attribute_t *properties_attr;
    //objc_property_attribute_t property_attr;
    objc_property_t *properties = class_copyPropertyList([self class], &nCount);
    for (int i=0; i<nCount; i++) {
        objc_property_t property = properties[i];
        NSString *szName = [NSString stringWithUTF8String:(property_getName(property))];
        properties_attr = property_copyAttributeList(property, &nPropertyCount);
        if(strcmp(properties_attr->value, "@\"NSString\"") == 0){//nsstring
            [aCoder encodeObject:[self valueForKey:szName] forKey:szName];
        }else if(strcmp(properties_attr->value, "q") == 0){//long
            [aCoder encodeInt64:[[self valueForKey:szName] longValue] forKey:szName];
        }else if(strcmp(properties_attr->value, "i") == 0){//int
            [aCoder encodeInt:[[self valueForKey:szName] intValue] forKey:szName];
        }else if(strcmp(properties_attr->value, "f") == 0){//float
            [aCoder encodeFloat:[[self valueForKey:szName] floatValue] forKey:szName];
        }else if(strcmp(properties_attr->value, "d") == 0){//double
            [aCoder encodeDouble:[[self valueForKey:szName] doubleValue] forKey:szName];
        }else if(strcmp(properties_attr->value, "B") == 0){
            [aCoder encodeBool:[[self valueForKey:szName] boolValue] forKey:szName];
        }
        
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    unsigned int nCount,nPropertyCount;
    objc_property_attribute_t *properties_attr;
    objc_property_t *properties = class_copyPropertyList([self class], &nCount);
    for (int i=0; i<nCount; i++) {
        objc_property_t property = properties[i];
        NSString *szName = [NSString stringWithUTF8String:(property_getName(property))];
        properties_attr = property_copyAttributeList(property, &nPropertyCount);
        if(strcmp(properties_attr->value, "@\"NSString\"") == 0){//nsstring
            [self setValue:[aDecoder decodeObjectForKey:szName] forKey:szName];
        }else if(strcmp(properties_attr->value, "q") == 0){//long
            [self setValue:[NSNumber numberWithLong:[aDecoder decodeInt64ForKey:szName]] forKey:szName];
        }else if(strcmp(properties_attr->value, "i") == 0){//int
            [self setValue:[NSNumber numberWithInt:[aDecoder decodeIntForKey:szName]] forKey:szName];
        }else if(strcmp(properties_attr->value, "f") == 0){//float
            [self setValue:[NSNumber numberWithFloat:[aDecoder decodeFloatForKey:szName]] forKey:szName];
        }else if(strcmp(properties_attr->value, "d") == 0){//double
            [self setValue:[NSNumber numberWithDouble:[aDecoder decodeDoubleForKey:szName]] forKey:szName];
        }else if(strcmp(properties_attr->value, "B") == 0){
            [self setValue:[NSNumber numberWithBool:[aDecoder decodeBoolForKey:szName]] forKey:szName];
        }
    }
    
    return self;
}

@end
