//
//  HomeArea.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-16.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "HomeArea.h"

@implementation HomeArea

@synthesize key, value;

static HomeArea *sharedInstance = nil;

+ (HomeArea *) sharedInstance
{
    if(!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }
    
    return sharedInstance;
}

+ (id)initWithKey:(NSString *)key Value:(NSString *)value
{
    HomeArea *newCls = [[[self alloc] init] autorelease];
    
    newCls.key = key;
    newCls.value = value;
    
    return newCls;
}

@end
