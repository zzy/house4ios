//
//  Service.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-10.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import "Service.h"

@implementation Service

@synthesize payMethod, houseDesc, orderTime, buildingArea, contractSignDesc, orderTotalPrice;

- (void)dealloc
{
    [payMethod release];
    [houseDesc release];
    [orderTime release];
    [buildingArea release];
    [contractSignDesc release];
    [orderTotalPrice release];
    
    [super dealloc];
}

@end
