//
//  IndividualBasedBuildingCell.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-22.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "IndividualBasedHouseCell.h"

@implementation IndividualBasedHouseCell

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

- (void)setFloorNO:(NSString *)newFloorNO
{
    [super setFloorNO:newFloorNO];
    
    if (![@"" isEqualToString:newFloorNO])
        label_floorNO.text = [newFloorNO stringByAppendingString:@"层"];
    else
        label_floorNO.text = newFloorNO;
}

- (void)setHouse:(UIButton *)newHouse
{
    [super setHouse:newHouse];
    [scrollView_row addSubview:newHouse];
    scrollView_row.showsVerticalScrollIndicator = NO;
}

- (void)dealloc
{
    [label_floorNO release];
//    [label_h1NO release];
//    [label_h1State release];
//    [button_h1 release];
//    [button_h2 release];
//    [label_h2NO release];
//    [label_h2State release];
//    [button_h3 release];
//    [label_h3NO release];
//    [label_h3State release];
//    [button_h4 release];
//    [label_h4NO release];
//    [label_h4State release];
//    [button_h5 release];
//    [label_h5NO release];
//    [label_h5State release];
    [scrollView_row release];
    [super dealloc];
}

@end
