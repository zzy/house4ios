//
//  House.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-1.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import "House.h"

@implementation House

@synthesize hNO, hID, sellState, stateDesc;
@synthesize hDesc, hArea, unitPrice, totalPrice, hPic;

static House *sharedInstance = nil;

+ (House *) sharedInstance
{
    if(!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }
    
    return sharedInstance;
}

+ (id)initWithID:(NSString *)hID hNO:(NSString *)hNO sellState:(NSString *)sellState stateDesc:(NSString *)stateDesc
{
    House *newHouse = [[[House alloc] init] autorelease];
    
    newHouse.hID = hID;
    newHouse.hNO = hNO;
    newHouse.sellState = sellState;
    newHouse.stateDesc = stateDesc;
    
    return newHouse;
}

@end
