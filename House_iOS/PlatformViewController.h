//
//  PlatformViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-11-28.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProjectTableViewController.h"

@class ProjPhotosViewController;
@class ToolsViewController;
@class ConfigViewController;

@interface PlatformViewController : UIViewController <ProjectTableViewControllerDelegate, UIAlertViewDelegate>

@property (retain, nonatomic) UIPopoverController *projectTablePopoverController;
@property (retain, nonatomic) UITabBarController *tabBarController;

@property (retain, nonatomic) ProjPhotosViewController *projPhotosView;
@property (retain, nonatomic) ToolsViewController *toolsView;
@property (retain, nonatomic) ConfigViewController *configView;

@property (retain, nonatomic) IBOutlet UILabel *curDay;
@property (retain, nonatomic) IBOutlet UILabel *username;
@property (retain, nonatomic) IBOutlet UILabel *phoneCustomers;
@property (retain, nonatomic) IBOutlet UILabel *visitCustomers;
@property (retain, nonatomic) IBOutlet UILabel *customers;
@property (retain, nonatomic) IBOutlet UILabel *issueCustomers;
@property (retain, nonatomic) IBOutlet UILabel *bizCount;
@property (retain, nonatomic) IBOutlet UILabel *bizArea;

@property (retain, nonatomic) IBOutlet UIButton *projectName;

+ (PlatformViewController *) sharedInstance;

- (IBAction)exit:(id)sender;
- (IBAction)config:(id)sender;
- (IBAction)house:(id)sender;
- (IBAction)customer:(id)sender;
- (IBAction)tools:(id)sender;
- (IBAction)projPhotos:(id)sender;

- (IBAction)setProject:(id)sender;

- (IBAction)myStat:(id)sender;
- (IBAction)sysNotice:(id)sender;
- (IBAction)revisitMind:(id)sender;

@property (retain, nonatomic) IBOutlet UIView *myStateV;
@property (retain, nonatomic) IBOutlet UIView *sysNtcV;
@property (retain, nonatomic) IBOutlet UIView *reNtcV;

- (void)ycView;

@property (retain, nonatomic) IBOutlet UITableView *sysTable;
@property (nonatomic, retain) NSMutableArray *sysList;
@property (retain, nonatomic) IBOutlet UITableView *rcvTable;
@property (nonatomic, retain) NSMutableArray *rcvList;

@end
