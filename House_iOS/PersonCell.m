//
//  PersonCell.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-5.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import "PersonCell.h"

@implementation PersonCell

@synthesize snStr, houseDesc, clientName, orderTime, contractTime, contractNo, buildingArea, contractTotalPrice, payMethod, backPay, unbackPay, handTime, radix, proportion, quotiety, haveMoney, leaveMoney;

- (void)dealloc
{
    [snStr release];
    [houseDesc release];
    [clientName release];
    [orderTime release];
    [contractTime release];
    [contractNo release];
    [buildingArea release];
    [contractTotalPrice release];
    [payMethod release];
    [backPay release];
    [unbackPay release];
    [handTime release];
    [radix release];
    [proportion release];
    [quotiety release];
    [haveMoney release];
    [leaveMoney release];
    
    [super dealloc];
}

@end
