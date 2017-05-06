//
//  CustomerInfoViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-11-29.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AdvInfoViewController.h"
#import "Service.h"
#import "MeanFormViewController.h"
#import "CustomerGroupViewController.h"

@class CustomerFormViewController;
@class ServiceInfoViewController;

@interface CustomerInfoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, AdvInfoViewControllerDelegate, MeanFormViewControllerDelegate, CustomerGroupViewControllerDelegate>

@property (retain, nonatomic) UIPopoverController *advPopoverController;
@property (copy, nonatomic) NSString *isIssue;
//@property (retain, nonatomic) NSString *cstName;
//@property (retain, nonatomic) AdvInfo *advInfo;

@property (retain, nonatomic) IBOutlet UIButton *phoneBtn;
@property (retain, nonatomic) IBOutlet UIButton *visitBtn;
@property (retain, nonatomic) IBOutlet UIButton *selfBtn;
@property (retain, nonatomic) IBOutlet UIButton *allBtn;

@property (retain, nonatomic) IBOutlet UIButton *nameBtn;
@property (retain, nonatomic) IBOutlet UIButton *timeBtn;
@property (retain, nonatomic) IBOutlet UIButton *typeBtn;
@property (retain, nonatomic) IBOutlet UIButton *statBtn;

@property (retain, nonatomic) IBOutlet UITableView *customerTable;
@property (nonatomic, retain) NSMutableArray *customerList;

- (IBAction)byPhone:(id)sender;
- (IBAction)byVisit:(id)sender;
- (IBAction)bySelf:(id)sender;
- (IBAction)byAll:(id)sender;

- (IBAction)byName:(id)sender;
- (IBAction)byTime:(id)sender;
- (IBAction)byType:(id)sender;
- (IBAction)byStat:(id)sender;

- (void)resetCustomersByCatalog:(NSNumber *)catalog Sort:(NSString *)sort;
- (void)reloadViewCatalogBtn:(UIButton *)catalogBtn SortBtn:(UIButton *)sortBtn;

- (IBAction)getBasicInfo:(id)sender;
- (IBAction)getAdvanceInfo:(id)sender;
- (IBAction)getServices:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton *basicInfoBtn;
@property (retain, nonatomic) IBOutlet UIButton *advanceInfoBtn;
@property (retain, nonatomic) IBOutlet UIButton *serviceBtn;

@property (retain, nonatomic) IBOutlet UILabel *name;
@property (retain, nonatomic) IBOutlet UILabel *sellerName;
@property (retain, nonatomic) IBOutlet UILabel *job;
@property (retain, nonatomic) IBOutlet UILabel *phones;
@property (retain, nonatomic) IBOutlet UILabel *age;
@property (retain, nonatomic) IBOutlet UILabel *cognizePath;
@property (retain, nonatomic) IBOutlet UILabel *bideArea;
@property (retain, nonatomic) IBOutlet UILabel *workArea;
@property (retain, nonatomic) IBOutlet UILabel *familyEarning;
@property (retain, nonatomic) IBOutlet UILabel *bideHouseType;
@property (retain, nonatomic) IBOutlet UILabel *type;
@property (retain, nonatomic) IBOutlet UITextView *signDesc;
@property (retain, nonatomic) IBOutlet UILabel *bargainState;
@property (retain, nonatomic) IBOutlet UILabel *promoter;
@property (retain, nonatomic) IBOutlet UILabel *liver;
@property (retain, nonatomic) IBOutlet UITextView *remark;
@property (retain, nonatomic) IBOutlet UITextView *zysx;

@property (retain, nonatomic) IBOutlet UIButton *attendBtn;
- (IBAction)attendCstm:(id)sender;
- (void)rfsAtdBtn;

- (void)setCustomerInfo;
- (void)setAdvInfo;
- (void)setMeanInfo;
- (void)setSerInfo;

@property (retain, nonatomic) IBOutlet UILabel *issueLabel;
@property (retain, nonatomic) IBOutlet UILabel *issueCL;
@property (retain, nonatomic) IBOutlet UILabel *issueC;

@property (retain, nonatomic) IBOutlet UIView *filterView;
@property (retain, nonatomic) IBOutlet UIView *infoView;
@property (retain, nonatomic) IBOutlet UIView *advView;
@property (retain, nonatomic) IBOutlet UIView *serView;

@property (retain, nonatomic) CustomerFormViewController *customerFormView;
@property (retain, nonatomic) ServiceInfoViewController *servInfoView;
@property (retain, nonatomic) MeanFormViewController *meanFormView;

@property (retain, nonatomic) IBOutlet UITableView *advTable;
@property (nonatomic, retain) NSMutableArray *advList;

- (IBAction)newCustomerForm:(id)sender;
- (IBAction)editCustomerForm:(id)sender;

-(void) clearColor;
-(void) hideView;

@property (retain, nonatomic) IBOutlet UITableView *meanTable;
@property (nonatomic, retain) NSMutableArray *meanList;

@property (retain, nonatomic) IBOutlet UITableView *serTable;
@property (nonatomic, retain) NSMutableArray *serList;
@property (retain, nonatomic) IBOutlet Service *tmpCell;
@property (nonatomic, retain) UINib *cellNib;

@property (retain, nonatomic) IBOutlet UITextField *text_search;
- (IBAction)searchCstm:(id)sender;
- (IBAction)clearSearch:(id)sender;

- (IBAction)addMean:(id)sender;
- (IBAction)delMean:(id)sender;

- (void)refreshCstmInfo:(NSIndexPath *)indexPath;

@end
