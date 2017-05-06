//
//  AppDelegate.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-11-28.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "OudsAppDelegate.h"

#import "SplashViewController.h"

@implementation OudsAppDelegate

@synthesize window = _window;
@synthesize isLogin = _isLogin;

// server info
@synthesize SERVER = _SERVER;
@synthesize HTTP_PORT = _HTTP_PORT;
@synthesize USE_SSL = _USE_SSL;
@synthesize SSL_SERVER = _SSL_SERVER;
@synthesize SSL_PORT = _SSL_PORT;
@synthesize ROOT_PATH = _ROOT_PATH;

// user info
@synthesize USER_ID = _USER_ID;
@synthesize LOGIN_ID = _LOGIN_ID;
@synthesize USERNAME = _USERNAME;
@synthesize USER_ROLE = _USER_ROLE;
@synthesize USER_PMS = _USER_PMS;

// projet info
@synthesize SID = _SID;
@synthesize PROJ_ID = _PROJ_ID;
@synthesize PROJ_NAME = _PROJ_NAME;
@synthesize SID_PROJ = _SID_PROJ;
@synthesize BLD = _BLD;
@synthesize BLD_TYPE = _BLD_TYPE;

@synthesize splashView = _splashView;

- (void)dealloc
{
    [_window release];
    [_splashView release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    // 装载启动视图
    self.splashView = [[[SplashViewController alloc] init] autorelease];
    self.window.rootViewController = self.splashView;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
