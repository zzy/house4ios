//
//  CalculatorViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-12.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CalValueViewController.h"

@class ToolsViewController;

@interface CalculatorViewController : UIViewController <UITextFieldDelegate, CalValueViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITextField *cField;
@property (retain, nonatomic) IBOutlet UIView *cView;

@property (retain, nonatomic) UIPopoverController *calvPopoverController;

@property (nonatomic, retain) ToolsViewController *toolsView;

@property (retain, nonatomic) IBOutlet UITextField *houseDesc;
@property (retain, nonatomic) IBOutlet UITextField *houseArea;
@property (retain, nonatomic) IBOutlet UITextField *unitPrice;
@property (retain, nonatomic) IBOutlet UITextField *totalPrice;
@property (retain, nonatomic) IBOutlet UITextField *lendPrice;
@property (retain, nonatomic) IBOutlet UITextField *lendLimit;
@property (retain, nonatomic) IBOutlet UITextField *upProportion;
@property (retain, nonatomic) IBOutlet UITextField *payMethod;
@property (retain, nonatomic) IBOutlet UITextField *payType;
@property (retain, nonatomic) IBOutlet UILabel *basicRate;
@property (retain, nonatomic) IBOutlet UILabel *interestRate;
@property (retain, nonatomic) IBOutlet UITextField *yhfs;

- (IBAction)houses:(id)sender;
- (IBAction)tools:(id)sender;

- (IBAction)getPayMethod:(id)sender;
- (IBAction)getPayType:(id)sender;
- (IBAction)yhfsValue:(id)sender;

- (void)setValue;
- (IBAction)doCalculator:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *housePrice;
@property (retain, nonatomic) IBOutlet UITextField *arangePrice;
@property (retain, nonatomic) IBOutlet UITextField *pay;
@property (retain, nonatomic) IBOutlet UITextField *perCredit;
@property (retain, nonatomic) IBOutlet UITextField *accrual;
@property (retain, nonatomic) IBOutlet UITextField *perPay;

- (IBAction)payMonth:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *zkyxj;
@property (retain, nonatomic) IBOutlet UILabel *zkyxjv;

@property (retain, nonatomic) IBOutlet UITableView *mTable;
@property (nonatomic, retain) NSMutableArray *mList;

@end
