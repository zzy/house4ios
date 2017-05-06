//
//  IndividualBasedPersonCell.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-5.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import "PersonCell.h"

@interface IndividualBasedPersonCell : PersonCell
{
    IBOutlet UILabel *label_sn;
    IBOutlet UILabel *label_houseDesc;
    IBOutlet UILabel *label_clientName;
    IBOutlet UILabel *label_orderTime;
    IBOutlet UILabel *label_contractTime;
    IBOutlet UILabel *label_contractNo;
    IBOutlet UILabel *label_buildingArea;
    IBOutlet UILabel *label_contractTotalPrice;
    IBOutlet UILabel *label_payMethod;
    IBOutlet UILabel *label_backPay;
    IBOutlet UILabel *label_unbackPay;
    IBOutlet UILabel *label_handTime;
    IBOutlet UILabel *label_radix;
    IBOutlet UILabel *label_proportion;
    IBOutlet UILabel *label_quotiety;
    IBOutlet UILabel *label_haveMoney;
    IBOutlet UILabel *label_leaveMoney;
}

@end
