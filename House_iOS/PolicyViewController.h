//
//  PolicyViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-12.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ToolsViewController;

@interface PolicyViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *policyList;

@property (nonatomic, retain) ToolsViewController *toolsView;
@property (retain, nonatomic) IBOutlet UILabel *label_title;
@property (retain, nonatomic) IBOutlet UILabel *label_time;
@property (retain, nonatomic) IBOutlet UILabel *label_state;
@property (retain, nonatomic) IBOutlet UITextView *textView_detail;

- (IBAction)tools:(id)sender;

@end
