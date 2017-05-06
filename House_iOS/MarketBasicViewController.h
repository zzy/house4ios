//
//  MarketBasicViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-8.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MarketViewController.h"

@class Market;

@interface MarketBasicViewController : UIViewController <MarketViewControllerDelegate>

@property (retain, nonatomic) IBOutlet UILabel *projName;
//@property (retain, nonatomic) Market *market;

@property (retain, nonatomic) IBOutlet UILabel *type;
@property (retain, nonatomic) IBOutlet UILabel *modelArea;
@property (retain, nonatomic) IBOutlet UILabel *publicApportion;
@property (retain, nonatomic) IBOutlet UILabel *managerPrice;
@property (retain, nonatomic) IBOutlet UILabel *fitment;
@property (retain, nonatomic) IBOutlet UILabel *openingTime;
@property (retain, nonatomic) IBOutlet UILabel *handTime;
@property (retain, nonatomic) IBOutlet UILabel *area;
@property (retain, nonatomic) IBOutlet UILabel *totalArea;
@property (retain, nonatomic) IBOutlet UILabel *countHouse;
@property (retain, nonatomic) IBOutlet UILabel *cubage;
@property (retain, nonatomic) IBOutlet UILabel *density;
@property (retain, nonatomic) IBOutlet UILabel *virescence;
@property (retain, nonatomic) IBOutlet UILabel *parking;

@property (retain, nonatomic) IBOutlet UILabel *time;
@property (retain, nonatomic) IBOutlet UILabel *mainModel;
@property (retain, nonatomic) IBOutlet UILabel *priceBetween;
@property (retain, nonatomic) IBOutlet UILabel *averagePrice;
@property (retain, nonatomic) IBOutlet UILabel *projectPlan;
@property (retain, nonatomic) IBOutlet UILabel *sellMeans;
@property (retain, nonatomic) IBOutlet UILabel *buildDesign;
@property (retain, nonatomic) IBOutlet UILabel *sightDesign;
@property (retain, nonatomic) IBOutlet UILabel *manager;
@property (retain, nonatomic) IBOutlet UILabel *sellProxy;
@property (retain, nonatomic) IBOutlet UILabel *ad;
@property (retain, nonatomic) IBOutlet UILabel *makeModel;

@end
