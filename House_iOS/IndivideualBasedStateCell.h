//
//  IndivideualBasedStateCell.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-11.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "StateC.h"

@interface IndivideualBasedStateCell : StateC
{
    IBOutlet UITextView *label_sign;
    IBOutlet UITextView *label_elseCircs;
    IBOutlet UITextView *textView_importantItems;
    IBOutlet UITextView *label_desc;
    IBOutlet UITextView *label_colleague;
    IBOutlet UITextView *label_time;
    IBOutlet UITextView *label_client;
}

@end
