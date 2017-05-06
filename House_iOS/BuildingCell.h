//
//  BuildingCell.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-22.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BuildingCell : UITableViewCell
{
    NSString *bNO;
    NSString *houseCount;
    NSString *state;
    NSString *licence;
    NSString *sellCount;
}

@property (retain, nonatomic) NSString *bNO, *houseCount, *state, *licence, *sellCount;

@end
