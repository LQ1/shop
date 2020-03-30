//
//  EntityJson.m
//  fishPond
//
//  Created by liu on 16/3/5.
//  Copyright (c) 2016年 bytsh. All rights reserved.
//

#import "EntityJson.h"
#import <objc/runtime.h>


@implementation EntityJson

+ (BOOL)stringContainSubStr:(NSString*)szStr withSubStr:(NSString*)szSubStr{
    if (szStr && szSubStr) {
        NSRange range = [szStr rangeOfString:szSubStr options:NSCaseInsensitiveSearch];
        if (range.length >0) {
            return YES;
        }
    }
    return NO;
}

//
+ (void)JsonToEntity:(NSDictionary*)dictJson withEntity:(NSObject*)obj{
    if (![dictJson isKindOfClass:[NSDictionary class]]) return;
    //class_copyPropertyList  返回的仅仅是对象类的属性(@property申明的属性)
    unsigned int nCount,nParentCount;
    objc_property_t *properties = class_copyPropertyList([obj class],&nCount);
    
    objc_property_t *properties_parent = class_copyPropertyList(class_getSuperclass([obj class]), &nParentCount);
    
    for (int i=0; i<nCount; i++) {
        objc_property_t property = properties[i];
        NSString *szName = [NSString stringWithUTF8String:(property_getName(property))];
        if ([self stringContainSubStr:szName withSubStr:@"array"]) {
            continue;
        }
        if ([dictJson objectForKey:szName]) {
            [obj setValue:[dictJson objectForKey:szName] forKey:szName];
        }
    }
    //super class set value
    for (int i=0; i<nParentCount; i++) {
        objc_property_t property = properties_parent[i];
        NSString *szName = [NSString stringWithUTF8String:(property_getName(property))];
        if ([self stringContainSubStr:szName withSubStr:@"array"]) {
            continue;
        }
        if ([dictJson objectForKey:szName]) {
            [obj setValue:[dictJson objectForKey:szName] forKey:szName];
        }
    }
    
}

+ (void)JsonToEntity:(NSDictionary*)dictJson withEntity:(NSObject*)obj withSubEntity:(Class)subClass{
    unsigned int nCount,nSubCount;
    objc_property_t *properties = class_copyPropertyList([obj class],&nCount);
    for (int i=0; i<nCount; i++) {
        objc_property_t property = properties[i];
        NSString *szName = [NSString stringWithUTF8String:(property_getName(property))];
        if ([dictJson objectForKey:szName]) {
            if (szName.length > 4 && [[szName substringToIndex:5] isEqualToString:@"array"]) {
                //是个集合
                objc_property_t *properties_sub = class_copyPropertyList(subClass, &nSubCount);
                NSArray *arraySub = [dictJson objectForKey:szName];
                NSDictionary *dictSub = nil;
                NSString *szSubName=@"";
                //const char *className = [NSStringFromClass(subClass) UTF8String];
                for (int j=0;j<arraySub.count;j++) {
                    dictSub = [arraySub objectAtIndex:j];
                    //Class cSub = objc_getClass(className);//objc_allocateClassPair(subClass, className, 0);
                    //比较
                    for (int k=0; k<nSubCount; k++) {
                        objc_property_t propertySub = properties_sub[k];
                        szSubName = [NSString stringWithUTF8String:(property_getName(propertySub))];
                    }
                }
            }else{
                [obj setValue:[dictJson objectForKey:szName] forKey:szName];
            }
        }
    }
    free(properties);
}

//实体转成JSON串
+ (NSString*)entityToString:(NSObject*)entity{
    unsigned int nCount,nParentCount;
    NSString *szJson=@"{";
    //char *szValue;
    id value;
    NSString *strValue=@"";
    objc_property_t *properties = class_copyPropertyList([entity class],&nCount);
    //parent property
    objc_property_t *properties_parent = class_copyPropertyList(class_getSuperclass([entity class]), &nParentCount);
    
    for (int i=0; i<nCount; i++) {
        objc_property_t property = properties[i];
        NSString *szName = [NSString stringWithUTF8String:(property_getName(property))];
        value = [entity valueForKey:szName];//property_copyAttributeValue(property, [szName UTF8String]);
        /*
        if (![value isKindOfClass:[NSString class]]) {
            if (sizeof(long) == sizeof(strValue)) {
                strValue = [NSString stringWithFormat:@"%@",value];
            }
        }*/
        if ([value isKindOfClass:[NSNull class]] || value == NULL || value == nil) {
            value = @"";
        }
        strValue = [NSString stringWithFormat:@"%@",value];
        szJson = [NSString stringWithFormat:@"%@\"%@\":\"%@\",",szJson,szName,strValue];
    }
    //super class set value
    for (int i=0; i<nParentCount; i++) {
        objc_property_t property = properties_parent[i];
        NSString *szName = [NSString stringWithUTF8String:(property_getName(property))];
        value = [entity valueForKey:szName];
        if ([value isKindOfClass:[NSNull class]] || value == NULL || value == nil) {
            value = @"";
        }
        strValue = [NSString stringWithFormat:@"%@",value];
        szJson = [NSString stringWithFormat:@"%@\"%@\":\"%@\",",szJson,szName,strValue];
    }
    
    szJson = [szJson substringToIndex:szJson.length-1];
    szJson = [szJson stringByAppendingString:@"}"];
    NSLog(@"Entity to Json:\n%@",szJson);
    return szJson;
}

























@end
