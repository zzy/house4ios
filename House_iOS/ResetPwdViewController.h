//
//  ResetPwdViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-12.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ConfigViewController;
@class LoginViewController;

@interface ResetPwdViewController : UIViewController

@property (nonatomic, retain) ConfigViewController *configView;
@property(nonatomic,retain) LoginViewController *loginView;

@property (retain, nonatomic) IBOutlet UITextField *oldPwd;
@property (retain, nonatomic) IBOutlet UITextField *newPwd;
@property (retain, nonatomic) IBOutlet UITextField *reNewPwd;

- (IBAction)config:(id)sender;
- (IBAction)resetPwd:(id)sender;

@end
