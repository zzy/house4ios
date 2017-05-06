//
//  ProjPhotosViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-9.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZoomViewController.h"

@class PlatformViewController;

@interface ProjPhotosViewController : ZoomViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) PlatformViewController *platformView;

@property (retain, nonatomic) IBOutlet UINavigationItem *name;

- (IBAction)platform:(id)sender;
- (IBAction)closeMe:(id)sender;

@property (retain, nonatomic) IBOutlet UIView *zoomView;
@property (retain, nonatomic) IBOutlet UIImageView *imgView;

@property (retain, nonatomic) IBOutlet UIButton *preBtn;
@property (retain, nonatomic) IBOutlet UIButton *nextBtn;

- (IBAction)preImg:(id)sender;
- (IBAction)mextImg:(id)sender;

- (void)getPic;
@property (retain, nonatomic) IBOutlet UITableView *nameTab;
@property (nonatomic, retain) NSMutableArray *nameList;
@property (retain, nonatomic) IBOutlet UILabel *spL;

- (IBAction)navCg:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *navBtn;

@end
