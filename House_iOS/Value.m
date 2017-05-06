//
//  Value.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-14.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import "Value.h"

@implementation Value

@synthesize vID, vName;

static Value *sharedInstance = nil;

+ (Value *) sharedInstance
{
    if(!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }
    
    return sharedInstance;
}

@end
