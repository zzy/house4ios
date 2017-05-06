//
//  SaleInfoViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-11-29.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaleInfoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *saleInfoList;

@property (retain, nonatomic) IBOutlet UILabel *saleInfoTitle;

- (IBAction)addSaleInfo:(id)sender;
- (IBAction)editSaleInfo:(id)sender;
- (IBAction)deleteSaleInfo:(id)sender;

@property (retain, nonatomic) IBOutlet UILabel *type;
@property (retain, nonatomic) IBOutlet UILabel *time;
@property (retain, nonatomic) IBOutlet UILabel *state;
@property (retain, nonatomic) IBOutlet UILabel *price;
@property (retain, nonatomic) IBOutlet UITextView *detail;

@end
