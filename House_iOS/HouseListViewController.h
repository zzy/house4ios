//
//  HouseListViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-11-29.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HouseCell;
@class NodeData;
@class CalculatorViewController;
@class ProjPhotosViewController;

@interface HouseListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) ProjPhotosViewController *phtsView;
@property (nonatomic, retain) CalculatorViewController *calculatorView;

@property (retain, nonatomic) IBOutlet UITableView *floorTable;
@property (nonatomic, retain) NSMutableArray *floorList;
@property (retain, nonatomic) IBOutlet HouseCell *tmpCell;
@property (nonatomic, retain) UINib *cellNib;

@property (retain, nonatomic) IBOutlet UILabel *label_notSale;
@property (retain, nonatomic) IBOutlet UILabel *label_forSale;
@property (retain, nonatomic) IBOutlet UILabel *label_inOrder;
@property (retain, nonatomic) IBOutlet UILabel *label_contracting;
@property (retain, nonatomic) IBOutlet UILabel *label_contracted;

@property (retain, nonatomic) IBOutlet UILabel *label_bNO;

@property (retain, nonatomic) NSMutableString *crtUnit;
@property (retain, nonatomic) UIButton *button_crtUnit;
@property (retain, nonatomic) UIButton *button_crtHouse;

- (void)onClickUnit:(UIButton *)sender;
- (void)onClickHouse:(UIButton *)sender;
- (void)attendHouse:(NSString *)hID;

@property (retain, nonatomic) IBOutlet UILabel *houseDesc;
@property (retain, nonatomic) IBOutlet UILabel *attentioning;
@property (retain, nonatomic) IBOutlet UILabel *directType;
@property (retain, nonatomic) IBOutlet UILabel *stateDesc;
@property (retain, nonatomic) IBOutlet UILabel *modelType;
@property (retain, nonatomic) IBOutlet UILabel *buildingArea;
@property (retain, nonatomic) IBOutlet UILabel *insideArea;
@property (retain, nonatomic) IBOutlet UILabel *unitPrice;
@property (retain, nonatomic) IBOutlet UILabel *totalPrice;
@property (retain, nonatomic) IBOutlet UILabel *publicArea;
@property (retain, nonatomic) IBOutlet UILabel *gardenPrice;
@property (retain, nonatomic) IBOutlet UILabel *gardenArea;
@property (retain, nonatomic) IBOutlet UILabel *gardenArea2;

@property (retain, nonatomic) IBOutlet UIButton *refreshBtn;
- (IBAction)refreshHouse:(id)sender;
- (IBAction)searchBySellState:(id)sender;

- (IBAction)housePic:(id)sender;
- (IBAction)calculator:(id)sender;

@end
