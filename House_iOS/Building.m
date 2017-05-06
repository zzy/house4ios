//
//  Building.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-6.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "Building.h"

@implementation Building

@synthesize bNO;
@synthesize houseCount;
@synthesize sellCount;
@synthesize licence;
@synthesize state, stateDesc;

+ (id)initWithNO:(NSString *)bNO hCount:(NSString *)houseCount sCount:(NSString *)sellCount lic:(NSString *)licence state:(NSString *) state stateDesc:(NSString *)stateDesc
{
	Building *newBuilding = [[[self alloc] init] autorelease];
	
    newBuilding.bNO = bNO;
    newBuilding.houseCount = houseCount;
    newBuilding.sellCount = sellCount;
    newBuilding.licence = licence;
    newBuilding.state = state;
    newBuilding.stateDesc = stateDesc;
    
	return newBuilding;
}

- (void)dealloc
{
	[bNO release];
    [houseCount release];
    [sellCount release];
    [licence release];
    [state release];
    [stateDesc release];
    
	[super dealloc];
}

@end
