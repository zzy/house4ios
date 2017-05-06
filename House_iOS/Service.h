//
//  Service.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-10.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Service : UITableViewCell
{
    NSString *payMethod; 
    NSString *houseDesc;
    NSString *orderTime;
    NSString *buildingArea;
    NSString *contractSignDesc;
    NSString *orderTotalPrice;
}

@property (retain, nonatomic) NSString *payMethod, *houseDesc, *orderTime, *buildingArea, *contractSignDesc, *orderTotalPrice;


@end

