//
//  IndivideualBasedStateCell.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-11.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import "IndivideualBasedStateCell.h"

@implementation IndivideualBasedStateCell

- (void)setSign:(NSString *)newSign
{
    [super setSign:newSign];
    label_sign.text = newSign;
}

- (void)setTime:(NSString *)newTime
{
    [super setTime:newTime];
    label_time.text = newTime;
}

- (void)setClient:(NSString *)newClient
{
    [super setClient:newClient];
    label_client.text = newClient;
}

- (void)setColleague:(NSString *)newColleague
{
    [super setColleague:newColleague];
    label_colleague.text = newColleague;
}

- (void)setDesc:(NSString *)newDesc
{
    [super setDesc:newDesc];
    label_desc.text = newDesc;
}

- (void)setImportantItems:(NSString *)newImportantItems
{
    [super setImportantItems:newImportantItems];
    textView_importantItems.text = newImportantItems;
}

- (void)setElseCircs:(NSString *)newElseCircs
{
    [super setElseCircs:newElseCircs];
    label_elseCircs.text = newElseCircs;
}

- (void)dealloc
{
    [label_sign release];
    [label_time release];
    [label_client release];
    [label_colleague release];
    [label_desc release];
    [textView_importantItems release];
    [label_elseCircs release];
    [super dealloc];
}

@end
