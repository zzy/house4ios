//
//  BuildingCell.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-22.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HouseCell : UITableViewCell
{
    NSString *floorNO;
    UIButton *floorRow;
}

@property (retain, nonatomic) NSString *floorNO;
@property (retain, nonatomic) UIButton *house;

@end
