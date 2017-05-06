//
//  Policy.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-26.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "Policy.h"

@implementation Policy

@synthesize policyID, detail, state, time, title;

+ (id)initWithID:(NSString *)policyID Detail:(NSString *)detail State:(NSString *)state Time:(NSString *)time Title:(NSString *)title
{
    Policy *newPolicy = [[[self alloc] init] autorelease];
	
    newPolicy.policyID = policyID;
	newPolicy.detail = detail;
    newPolicy.state = state;
    newPolicy.time = time;
    newPolicy.title = title;
    
	return newPolicy;

}

- (void)dealloc
{
	[policyID release];
	[detail release];
    [state release];
    [time release];
    [title release];
    
	[super dealloc];
}

@end
