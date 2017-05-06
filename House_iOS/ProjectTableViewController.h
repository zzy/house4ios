//
//  OudsFlipsideViewController.h
//  QieGan_iOS
//
//  Created by Zhongyu Zhang on 11-11-30.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProjectTableViewController;
@class PlatformViewController;

@protocol ProjectTableViewControllerDelegate

- (void)setProj:(NSString *)title;
- (void)projectTableViewControllerDidFinish:(ProjectTableViewController *)controller;

@end

@interface ProjectTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) IBOutlet id <ProjectTableViewControllerDelegate> delegate;

@property (nonatomic, retain) PlatformViewController *platformView;
@property (nonatomic, retain) NSMutableArray *projList;

- (IBAction)cancel:(id)sender;

@end
