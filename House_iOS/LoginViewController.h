//
//  LoginViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-11-28.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlatformViewController;
@class OudsMainViewController;
@class NetworkViewController;

@interface LoginViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>

@property (retain, nonatomic) IBOutlet UITextField *username;
@property (retain, nonatomic) IBOutlet UITextField *password;
@property (retain, nonatomic) IBOutlet UISwitch *remPwd;

@property (retain, nonatomic) PlatformViewController *platformView;
//@property (retain, nonatomic) OudsMainViewController *platformView;
@property (nonatomic, retain) NetworkViewController *networkView;

- (IBAction)login:(id)sender;
- (IBAction)netConfig:(id)sender;

@end
