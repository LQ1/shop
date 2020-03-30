//
//  GlobalSetting.m
//  NtOA
//
//  Created by liu on 16/4/9.
//  Copyright (c) 2016年 bytsh. All rights reserved.
//

#import "GlobalSetting.h"


static GlobalSetting *shareObj = nil;

@implementation GlobalSetting

+ (GlobalSetting*)getThis{
    @synchronized(self){
        if (shareObj == nil) {
            shareObj = [[self alloc] init];
        }
    }
    return shareObj;
}

+ (id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (shareObj == nil) {
            shareObj = [super allocWithZone:zone];
            return shareObj;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone*)zone{
    return self;
}



+ (oneway void)release{
    
}


+ (id)autoRelease{
    return self;
}


+ (id)init{
    @synchronized(self){
        [super init];
        return self;
    }
}



@end
