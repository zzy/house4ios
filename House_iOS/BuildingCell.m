//
//  BuildingCell.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-22.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "BuildingCell.h"

@implementation BuildingCell

@synthesize houseCount, bNO, sellCount, state, licence;

- (void)dealloc
{
    [houseCount release];
    [bNO release];
    [sellCount release];
    [state release];
    [licence release];
    
    [super dealloc];
}

@end
