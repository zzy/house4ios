//
//  IndividualBasedBuildingCell.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-22.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HouseCell.h"

@interface IndividualBasedHouseCell : HouseCell
{
    IBOutlet UILabel *label_floorNO;
    
//    IBOutlet UIButton *button_h1;
//    IBOutlet UILabel *label_h1NO;
//    IBOutlet UILabel *label_h1State;
//    
//    IBOutlet UIButton *button_h2;
//    IBOutlet UILabel *label_h2NO;
//    IBOutlet UILabel *label_h2State;
//    
//    IBOutlet UIButton *button_h3;
//    IBOutlet UILabel *label_h3NO;
//    IBOutlet UILabel *label_h3State;
//    
//    IBOutlet UIButton *button_h4;
//    IBOutlet UILabel *label_h4NO;
//    IBOutlet UILabel *label_h4State;
//    
//    IBOutlet UIButton *button_h5;
//    IBOutlet UILabel *label_h5NO;
//    IBOutlet UILabel *label_h5State;
    
    IBOutlet UIScrollView *scrollView_row;
}

@end
