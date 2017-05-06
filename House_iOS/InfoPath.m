//
//  InfoPath.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-16.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "InfoPath.h"

@implementation InfoPath

@synthesize key, value;

static InfoPath *sharedInstance = nil;

+ (InfoPath *) sharedInstance
{
    if(!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }
    
    return sharedInstance;
}

+ (id)initWithKey:(NSString *)key Value:(NSString *)value
{
    InfoPath *newCls = [[[self alloc] init] autorelease];
    
    newCls.key = key;
    newCls.value = value;
    
    return newCls;
}

@end
