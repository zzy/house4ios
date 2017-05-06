//
//  IndividualBasedBuildingCell.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-22.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "IndividualBasedBuildingCell.h"

@implementation IndividualBasedBuildingCell

//- (void)setBackgroundColor:(UIColor *)backgroundColor
//{
//    [super setBackgroundColor:backgroundColor];
//
//    iconView.backgroundColor = backgroundColor;
//    publisherLabel.backgroundColor = backgroundColor;
//    nameLabel.backgroundColor = backgroundColor;
//    ratingView.backgroundColor = backgroundColor;
//    numRatingsLabel.backgroundColor = backgroundColor;
//    priceLabel.backgroundColor = backgroundColor;
//}

- (void)setBNO:(NSString *)newBuildingNO
{
    [super setBNO:newBuildingNO];
    label_buildingNO.text = newBuildingNO;
}

- (void)setHouseCount:(NSString *)newHouseCount
{
    [super setHouseCount:newHouseCount];
    label_houseCount.text = newHouseCount;
}

- (void)setSellCount:(NSString *)newSellCount
{
    [super setSellCount:newSellCount];
    label_sellCount.text = newSellCount;
}

- (void)setLicence:(NSString *)newLicence
{
    [super setLicence:newLicence];
    label_licence.text = newLicence;
}

- (void)setState:(NSString *)newState
{
    [super setState:newState];
    label_state.text = newState;
}

- (void)dealloc
{
    [label_buildingNO release];
    [label_houseCount release];
    [label_sellCount release];
    [label_licence release];
    [label_state release];
    
    [super dealloc];
}

@end
