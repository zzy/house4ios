//
//  PersonStatViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-12.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PersonCell.h"

@class ToolsViewController;

@interface PersonStatViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) ToolsViewController *toolsView;

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView_data;

@property (retain, nonatomic) IBOutlet UITableView *personTable;
@property (retain, nonatomic) IBOutlet PersonCell *tmpCell;
@property (nonatomic, retain) NSMutableArray *personList;
@property (nonatomic, retain) UINib *cellNib;

- (IBAction)tools:(id)sender;

@end
