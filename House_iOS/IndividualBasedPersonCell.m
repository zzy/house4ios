//
//  IndividualBasedPersonCell.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-5.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import "IndividualBasedPersonCell.h"

@implementation IndividualBasedPersonCell

- (void)dealloc {
    [label_houseDesc release];
    [label_clientName release];
    [label_orderTime release];
    [label_contractTime release];
    [label_contractNo release];
    [label_buildingArea release];
    [label_contractTotalPrice release];
    [label_payMethod release];
    [label_backPay release];
    [label_unbackPay release];
    [label_handTime release];
    [label_radix release];
    [label_proportion release];
    [label_quotiety release];
    [label_haveMoney release];
    [label_leaveMoney release];
    [label_sn release];
    [super dealloc];
}

- (void)setSnStr:(NSString *)newSnStr
{
    [super setSnStr:newSnStr];
    [label_sn setText:newSnStr];
}

- (void)setLeaveMoney:(NSString *)newLeaveMoney
{
    [super setLeaveMoney:newLeaveMoney];
    [label_leaveMoney setText:newLeaveMoney];
}

- (void)setHaveMoney:(NSString *)newHaveMoney
{
    [super setHaveMoney:newHaveMoney];
    [label_haveMoney setText:newHaveMoney];
}

- (void)setQuotiety:(NSString *)newQuotiety
{
    [super setQuotiety:newQuotiety];
    [label_quotiety setText:newQuotiety];
}

- (void)setProportion:(NSString *)newProportion
{
    [super setProportion:newProportion];
    [label_proportion setText:newProportion];
}

- (void)setRadix:(NSString *)newRadix
{
    [super setRadix:newRadix];
    [label_radix setText:newRadix];
}

- (void)setHandTime:(NSString *)newHandTime
{
    [super setHandTime:newHandTime];
    [label_handTime setText:newHandTime];
}

- (void)setUnbackPay:(NSString *)newUnbackPay
{
    [super setUnbackPay:newUnbackPay];
    [label_unbackPay setText:newUnbackPay];
}

- (void)setBackPay:(NSString *)newBackPay
{
    [super setBackPay:newBackPay];
    [label_backPay setText:newBackPay];
}

- (void)setPayMethod:(NSString *)newPayMethod
{
    [super setPayMethod:newPayMethod];
    [label_payMethod setText:newPayMethod];
}

- (void)setContractTotalPrice:(NSString *)newContractTotalPrice
{
    [super setContractTotalPrice:newContractTotalPrice];
    [label_contractTotalPrice setText:newContractTotalPrice];
}

- (void)setBuildingArea:(NSString *)newBuildingArea
{
    [super setBuildingArea:newBuildingArea];
    [label_buildingArea setText:newBuildingArea];
}

- (void)setContractNo:(NSString *)newContractNo
{
    [super setContractNo:newContractNo];
    [label_contractNo setText:newContractNo];
}

- (void)setContractTime:(NSString *)newContractTime
{
    [super setContractTime:newContractTime];
    [label_contractTime setText:newContractTime];
}
- (void)setOrderTime:(NSString *)newOrderTime
{
    [super setOrderTime:newOrderTime];
    [label_orderTime setText:newOrderTime];
}

- (void)setClientName:(NSString *)newClientName
{
    [super setClientName:newClientName];
    [label_clientName setText:newClientName];
}

- (void)setHouseDesc:(NSString *)newHouseDesc
{
    [super setHouseDesc:newHouseDesc];
    [label_houseDesc setText:newHouseDesc];
    
}

@end
