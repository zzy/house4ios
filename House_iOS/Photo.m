//
//  Photo.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-21.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "Photo.h"

@implementation Photo

@synthesize isB, name, path;
@synthesize pArr;

static Photo *sharedInstance = nil;

+ (Photo *) sharedInstance
{
    if(!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }
    
    return sharedInstance;
}


- (void)dealloc
{
    [name release];
	[path release];
    [pArr release];
    
	[super dealloc];
}

@end
