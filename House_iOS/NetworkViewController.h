//
//  NetworkViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-12.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ConfigViewController;
@class SplashViewController;

@interface NetworkViewController : UIViewController

@property (nonatomic, retain) ConfigViewController *configView;
@property (strong, nonatomic) SplashViewController *splashView;

@property (retain, nonatomic) IBOutlet UITextField *netAddr;
@property (retain, nonatomic) IBOutlet UITextField *netPort;
@property (retain, nonatomic) IBOutlet UITextField *netRoot;
@property (retain, nonatomic) IBOutlet UISwitch *isSSL;
@property (retain, nonatomic) IBOutlet UITextField *sslPort;
@property (retain, nonatomic) IBOutlet UITextField *sslAddr;

- (IBAction)config:(id)sender;
- (IBAction)emptyValues:(id)sender;
- (IBAction)resetNetwork:(id)sender;

@end
