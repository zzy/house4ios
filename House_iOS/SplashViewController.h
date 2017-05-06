//
//  SplashViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-11-28.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginViewController;

@interface SplashViewController : UIViewController

@property(nonatomic,retain) NSTimer *timer;
@property(nonatomic,retain) UIImageView *splashImage;
@property(nonatomic,retain) LoginViewController *loginView;

@end
