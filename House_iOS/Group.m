//
//  Group.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-6.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import "Group.h"

@implementation Group

@synthesize name;
@synthesize cList; //, cstmList;

static Group *sharedInstance;

+ (Group *)sharedInstance
{
    if (!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }
    
    return sharedInstance;
}

+ (id)initWithName:(NSString *)name cList:(NSMutableArray *)cList
{
    Group *newGrp = [[[Group alloc] init] autorelease];
    
    newGrp.name = name;
    newGrp.cList = cList;
    
    return newGrp;
}

- (void)dealloc
{
	[name release];
    [cList release];
    
	[super dealloc];
}

@end
