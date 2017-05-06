//
//  AgeTableViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-16.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ValueTableViewController;
@class CustomerFormViewController;

@protocol ValueTableViewControllerDelegate

- (void)setValue:(NSString *)val;
- (void)valueTableViewControllerDidFinish:(ValueTableViewController *)controller;

@end

@interface ValueTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) IBOutlet id <ValueTableViewControllerDelegate> delegate;

@property (nonatomic, retain) CustomerFormViewController *customerFormView;
@property (nonatomic, retain) NSMutableArray *valueList;

- (IBAction)doChoose:(id)sender;
- (void)setDic:(NSString *)val key:(NSString *)key type:(NSString *)type;

@end
