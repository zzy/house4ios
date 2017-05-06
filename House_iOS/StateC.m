//
//  Service.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-10.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import "StateC.h"

@implementation StateC

@synthesize time, sign, desc, client, colleague, importantItems, elseCircs;

- (void)dealloc
{
    [time release];
    [sign release];
    [desc release];
    [client release];
    [colleague release];
    [importantItems release];
    [elseCircs release];
    
    [super dealloc];
}

@end
