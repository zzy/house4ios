//
//  Building.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-6.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "SaleInfo.h"

@implementation SaleInfo

@synthesize title;
@synthesize state;
@synthesize type;
@synthesize price;
@synthesize time;
@synthesize detail;

+ (id)initWithTitle:(NSString *)title State:(NSString *)state Type:(NSString *)type Price:(NSString *)price Time:(NSString *)time Detail:(NSString *) detail
{
	SaleInfo *newSaleInfo = [[[self alloc] init] autorelease];
	
    newSaleInfo.title = title;
    newSaleInfo.state = state;
    newSaleInfo.type = type;
    newSaleInfo.price = price;
    newSaleInfo.time = time;
    newSaleInfo.detail = detail;
    
	return newSaleInfo;
}

- (void)dealloc
{
	[title release];
	[state release];
    [type release];
    [price release];
    [time release];
    [detail release];
    
	[super dealloc];
}

@end
