//
//  ServiceInfoViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-11.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StateC.h"
#import "SheetFormViewController.h"

@interface ServiceInfoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SheetFormViewControllerDelegate>

@property (retain, nonatomic) SheetFormViewController *sheetFormView;

@property (retain, nonatomic) IBOutlet UILabel *houseDesc;
@property (retain, nonatomic) IBOutlet UILabel *orderTime;
@property (retain, nonatomic) IBOutlet UILabel *payMethod;
@property (retain, nonatomic) IBOutlet UILabel *buildingArea;
@property (retain, nonatomic) IBOutlet UILabel *orderTotalPrice;
@property (retain, nonatomic) IBOutlet UILabel *contractSignDesc;

@property (retain, nonatomic) IBOutlet UIView *contentView;

- (IBAction)closeMe:(id)sender;
- (IBAction)addState:(id)sender;
- (IBAction)delState:(id)sender;

@property (retain, nonatomic) IBOutlet UITableView *stateTable;
@property (nonatomic, retain) NSMutableArray *stateList;
@property (retain, nonatomic) IBOutlet StateC *tmpCell;
@property (nonatomic, retain) UINib *cellNib;

- (void)setStateInfo;

@property (retain, nonatomic) IBOutlet UILabel *gjsj;
@property (retain, nonatomic) IBOutlet UILabel *qygj;
@property (retain, nonatomic) IBOutlet UILabel *zxqk;
@property (retain, nonatomic) IBOutlet UILabel *tshz;
@property (retain, nonatomic) IBOutlet UILabel *khzj;
@property (retain, nonatomic) IBOutlet UILabel *zyqk;
@property (retain, nonatomic) IBOutlet UILabel *qtqk;

@end
