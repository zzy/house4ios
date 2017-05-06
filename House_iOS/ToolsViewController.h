//
//  ToolsViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-12.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlatformViewController;

@class CalculatorViewController;
@class PolicyViewController;
@class PersonStatViewController;

@interface ToolsViewController : UIViewController

@property (nonatomic, retain) PlatformViewController *platformView;

@property (nonatomic, retain) CalculatorViewController *calculatorView;
@property (nonatomic, retain) PolicyViewController *policyView;
@property (nonatomic, retain) PersonStatViewController *personStatView;

- (IBAction)platform:(id)sender;
- (IBAction)calculator:(id)sender;
- (IBAction)policy:(id)sender;
- (IBAction)personStat:(id)sender;

@end
