//
//  Calculator.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-19.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

@synthesize fromHouse, type, lendLimit;

static Calculator *sharedInstance;

+ (Calculator *)sharedInstance
{
    if (!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }
    
    return sharedInstance;
}

@end
