//
//  MarketViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-11-29.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Market.h"

@class MarketViewController;

@protocol MarketViewControllerDelegate

- (void) transferMarket:(MarketViewController *)currentView;     

@end  

@interface MarketViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *marketList;
@property (strong, nonatomic) UITabBarController *marketTabBarController;

//@property (assign, nonatomic) Market <MarketViewControllerDelegate> *market;

@end
