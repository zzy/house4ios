//
//  Service.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-10.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StateC : UITableViewCell
{
    NSString *time;
    NSString *sign;
    NSString *desc;
    NSString *client;
    NSString *colleague;
    NSString *importantItems;
    NSString *elseCircs;
}

@property (retain, nonatomic) NSString *time, *sign, *desc, *client, *colleague, *importantItems, *elseCircs;

@end

