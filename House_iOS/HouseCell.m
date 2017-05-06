//
//  BuildingCell.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-22.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "HouseCell.h"

@implementation HouseCell

@synthesize floorNO, house;

- (void)dealloc
{
    [floorNO release];
    [floorRow release];
    
    [super dealloc];
}

@end
