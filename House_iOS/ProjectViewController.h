//
//  ProjectViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-11-29.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BuildingCell.h"

//@class PlatformViewController;
@class ShowPmtViewController;

@interface ProjectViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UILabel *projName;
@property (retain, nonatomic) IBOutlet UILabel *projAddr;

@property (retain, nonatomic) IBOutlet UILabel *area;
@property (retain, nonatomic) IBOutlet UILabel *totalArea;
@property (retain, nonatomic) IBOutlet UILabel *cubage;
@property (retain, nonatomic) IBOutlet UILabel *floorDesc;
@property (retain, nonatomic) IBOutlet UILabel *carParking;
@property (retain, nonatomic) IBOutlet UILabel *areaBetween;
@property (retain, nonatomic) IBOutlet UILabel *density;
@property (retain, nonatomic) IBOutlet UILabel *greenbelt;
@property (retain, nonatomic) IBOutlet UILabel *houseCount;
@property (retain, nonatomic) IBOutlet UILabel *carBili;

@property (retain, nonatomic) IBOutlet UITableView *buildingTable;
@property (retain, nonatomic) IBOutlet UIButton *switchButton;

@property (nonatomic, retain) NSMutableArray *buildingList;
@property (retain, nonatomic) IBOutlet BuildingCell *tmpCell;
@property (nonatomic, retain) UINib *cellNib;

//@property (nonatomic, retain) PlatformViewController *platformView;
@property (nonatomic, retain) ShowPmtViewController *showPmtView;

- (IBAction)planPic:(id)sender;
- (IBAction)switchBuildings:(id)sender;

// 楼栋列表刷新
- (void)buildingListByStateType;
- (void)reColor;

- (IBAction)byZZ:(id)sender;
- (IBAction)bySP:(id)sender;
- (IBAction)byCK:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton *zzBtn;
@property (retain, nonatomic) IBOutlet UIButton *spBtn;
@property (retain, nonatomic) IBOutlet UIButton *ckBtn;

@end
