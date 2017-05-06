//
//  House.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-1.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import "Floor.h"

@implementation Floor

@synthesize fNO, fRow;

+ (id)initWithNO:(NSString *)fNO hRow:(NSMutableArray *)fRow
{
    Floor *newFloor = [[[Floor alloc] init] autorelease];
    
    newFloor.fNO = fNO;
    newFloor.fRow = fRow;
    
    return newFloor;
}

@end
