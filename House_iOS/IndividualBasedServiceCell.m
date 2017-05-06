//
//  IndividualBasedServiceCell.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-10.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import "IndividualBasedServiceCell.h"

@implementation IndividualBasedServiceCell

- (void)setOrderTime:(NSString *)newOrderTime
{
    [super setOrderTime:newOrderTime];
    label_orderTime.text = newOrderTime;
}

- (void)setHouseDesc:(NSString *)newHouseDesc
{
    [super setHouseDesc:newHouseDesc];
    label_houseDesc.text = newHouseDesc;
}

- (void)setPayMethod:(NSString *)newPayMethod
{
    [super setPayMethod:newPayMethod];
    label_payMethod.text = newPayMethod;
}

- (void)setBuildingArea:(NSString *)newBuildingArea
{
    [super setBuildingArea:newBuildingArea];
    label_buildingArea.text = newBuildingArea;
}

- (void)setOrderTotalPrice:(NSString *)newOrderTotalPrice
{
    [super setOrderTotalPrice:newOrderTotalPrice];
    label_orderTotalPrice.text = newOrderTotalPrice;
}

- (void)setContractSignDesc:(NSString *)newContractSignDesc
{
    [super setContractSignDesc:newContractSignDesc];
    label_contractSignDesc.text = newContractSignDesc;
}

- (void)dealloc
{
    [label_orderTime release];
    [label_houseDesc release];
    [label_payMethod release];
    [label_buildingArea release];
    [label_orderTotalPrice release];
    [label_contractSignDesc release];
    
    [super dealloc];
}

@end
