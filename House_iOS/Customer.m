//
//  Customer.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-13.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "Customer.h"

@implementation Customer

@synthesize customerID, name, phone, updateTime, type;
@synthesize isEdit, age, gfmd, jzqy, jzz, bgqy, cszy, czr, jcnl, rztj, zygw, zyID, remark, hztj, zysx;

static Customer *sharedInstance = nil;

+ (Customer *) sharedInstance
{
    if(!sharedInstance) {
        sharedInstance = [[self alloc] init];
        // [[PlatformViewController alloc] initWithNibName:@"PlatformViewController" bundle:[NSBundle mainBundle]];
    }
    
    return sharedInstance;
}

+ (id)initWithID:(NSString *)customerID Name:(NSString *)name phone:(NSString *)phone UpdateTime:(NSString *)updateTime Type:(NSString *)type
{
    Customer *newCustomer = [[[self alloc] init] autorelease];
    
    newCustomer.customerID = customerID;
    newCustomer.name = name;
    newCustomer.phone = phone;
    newCustomer.updateTime = updateTime;
    newCustomer.type = type;
    
    return newCustomer;
}

- (void)dealloc
{
	[customerID release];
	[name release];
    [updateTime release];
    [type release];
    
	[super dealloc];
}

@end
