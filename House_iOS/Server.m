//
//  Service.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-10.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import "Server.h"

@implementation Server

@synthesize sID, payMethod, houseDesc, orderTime, buildingArea, contractSignDesc, orderTotalPrice, clientUuid;

static Server *sharedInstance = nil;

+ (Server *)sharedInstance
{
    if (!sharedInstance) {
        sharedInstance = [[Server alloc] init];
    }
    
    return sharedInstance;
}

- (void)dealloc
{
    [payMethod release];
    [houseDesc release];
    [orderTime release];
    [buildingArea release];
    [contractSignDesc release];
    [orderTotalPrice release];
    [sID release];
    [clientUuid release];
    
    [super dealloc];
}

@end
