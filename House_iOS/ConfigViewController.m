//
//  ConfigViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-12.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "ConfigViewController.h"

#import "PlatformViewController.h"

#import "ResetPwdViewController.h"
#import "NetworkViewController.h"

@implementation ConfigViewController

@synthesize platformView = _platformView;

@synthesize resetPwdView = _resetPwdView;
@synthesize networkView = _networkView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)platform:(id)sender {
    // 跳转到工作平台界面
    //    _platformView = [PlatformViewController sharedInstance];
    _platformView = [[PlatformViewController alloc] initWithNibName:@"PlatformViewController" bundle:[NSBundle mainBundle]];
    //    
    //    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate]; 
    //    [oad.window setRootViewController:_platformView];
    //    [oad.window makeKeyAndVisible];
    [self.view addSubview:_platformView.view];
}

- (IBAction)resetPwd:(id)sender {
    _resetPwdView = [[ResetPwdViewController alloc] initWithNibName:@"ResetPwdViewController" bundle:[NSBundle mainBundle]];
    [self.view addSubview:_resetPwdView.view];
}

- (IBAction)networkCfg:(id)sender {
    _networkView = [[NetworkViewController alloc] initWithNibName:@"NetworkViewController" bundle:[NSBundle mainBundle]];
    [self.view addSubview:_networkView.view];
}

@end
