//
//  AppDelegate.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-11-28.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SplashViewController;

@interface OudsAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) BOOL isLogin;

// server info
@property (retain, nonatomic) NSString *SERVER;
@property (retain, nonatomic) NSString *HTTP_PORT;
@property (retain, nonatomic) NSString *USE_SSL;
@property (retain, nonatomic) NSString *SSL_SERVER;
@property (retain, nonatomic) NSString *SSL_PORT;
@property (retain, nonatomic) NSString *ROOT_PATH;

// user info
@property (retain, nonatomic) NSString *USER_ID;
@property (retain, nonatomic) NSString *LOGIN_ID;
@property (retain, nonatomic) NSString *USERNAME;
@property (retain, nonatomic) NSString *USER_ROLE;
@property (retain, nonatomic) NSString *USER_PMS;

// projet info
@property (retain, nonatomic) NSString *SID;
@property (retain, nonatomic) NSString *PROJ_ID;
@property (retain, nonatomic) NSString *PROJ_NAME;
@property (retain, nonatomic) NSString *SID_PROJ; // SID + "?projectUuid=" + PROJECT
@property (retain, nonatomic) NSString *BLD;
@property (retain, nonatomic) NSString *BLD_TYPE;

@property (strong, nonatomic) SplashViewController *splashView;

@end
