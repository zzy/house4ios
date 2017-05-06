//
//  IndividualBasedServiceCell.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-10.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Service.h"

@interface IndividualBasedServiceCell : Service
{
    IBOutlet UILabel *label_contractSignDesc;
    IBOutlet UILabel *label_orderTime;
    IBOutlet UILabel *label_orderTotalPrice;
    IBOutlet UILabel *label_buildingArea;
    IBOutlet UILabel *label_payMethod;
    IBOutlet UILabel *label_houseDesc;
}

@end
