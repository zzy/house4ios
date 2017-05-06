//
//  IndividualBasedBuildingCell.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-22.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BuildingCell.h"

@interface IndividualBasedBuildingCell : BuildingCell
{
    IBOutlet UILabel *label_buildingNO;
    IBOutlet UILabel *label_houseCount;
    IBOutlet UILabel *label_state;
    IBOutlet UILabel *label_licence;
    IBOutlet UILabel *label_sellCount;
}

@end
