//
//  ConfigViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-12.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlatformViewController;

@class ResetPwdViewController;
@class NetworkViewController;

@interface ConfigViewController : UIViewController

@property (nonatomic, retain) PlatformViewController *platformView;

@property (nonatomic, retain) ResetPwdViewController *resetPwdView;
@property (nonatomic, retain) NetworkViewController *networkView;

- (IBAction)platform:(id)sender;
- (IBAction)resetPwd:(id)sender;
- (IBAction)networkCfg:(id)sender;

@end
