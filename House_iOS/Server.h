//
//  Service.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-10.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Server : NSObject
{
    NSString *sID;
    NSString *clientUuid;
    NSString *payMethod; 
    NSString *houseDesc;
    NSString *orderTime;
    NSString *buildingArea;
    NSString *contractSignDesc;
    NSString *orderTotalPrice;
}

@property (retain, nonatomic) NSString *sID, *clientUuid, *payMethod, *houseDesc, *orderTime, *buildingArea, *contractSignDesc, *orderTotalPrice;

+ (Server *)sharedInstance;

@end
