//
//  PersonCell.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-5.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonCell : UITableViewCell
{
    NSString *snStr;
    NSString *houseDesc;
    NSString *clientName;
    NSString *orderTime;
    NSString *contractTime;
    NSString *contractNo;
    NSString *buildingArea;
    NSString *contractTotalPrice;
    NSString *payMethod;
    NSString *backPay;
    NSString *unbackPay;
    NSString *handTime;
    NSString *radix;
    NSString *proportion;
    NSString *quotiety;
    NSString *haveMoney;
    NSString *leaveMoney;
}

@property (retain, nonatomic) NSString *snStr, *houseDesc, *clientName, *orderTime, *contractTime, *contractNo, *buildingArea, *contractTotalPrice, *payMethod, *backPay, *unbackPay, *handTime, *radix, *proportion, *quotiety, *haveMoney, *leaveMoney;

@end
