//
//  Redirect2MarketViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-9.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "Redirect2MarketViewController.h"

#import "PlatformViewController.h"
//#import "OudsAppDelegate.h"
//
//#import "RedirectViewController.h"
//#import "ProjectViewController.h"
//#import "HouseListViewController.h"
//#import "SaleInfoViewController.h"
//#import "MarketViewController.h"

@implementation Redirect2MarketViewController

//@synthesize tabBarController = _tabBarController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"市场分析";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
//    UIViewController *redirectView = [[[RedirectViewController alloc] init] autorelease];
//    UIViewController *projectView = [[[ProjectViewController alloc] initWithNibName:@"ProjectViewController" bundle:nil] autorelease];
//    UIViewController *houseListView = [[[HouseListViewController alloc] initWithNibName:@"HouseListViewController" bundle:nil] autorelease];
//    UIViewController *saleInfoView = [[[SaleInfoViewController alloc] initWithNibName:@"SaleInfoViewController" bundle:nil] autorelease];
//    UIViewController *marketView = [[[MarketViewController alloc] initWithNibName:@"MarketViewController" bundle:nil] autorelease];
//    
//    //设置房源卡片
//    _tabBarController = [[[UITabBarController alloc] init] autorelease];
//    
//    _tabBarController.viewControllers = [NSArray arrayWithObjects:redirectView, projectView, houseListView, saleInfoView, marketView, nil];
//    [_tabBarController setSelectedIndex:4];
//    
//    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
//    [oad.window setRootViewController:_tabBarController];
//    [oad.window makeKeyAndVisible];
    
    // Init the view
    CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
	UIView *view = [[UIView alloc] initWithFrame:appFrame];
	view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
	self.view = view;
	[view release];
    
    // redirect to 市场情况
    PlatformViewController *platformView = [PlatformViewController sharedInstance];
    [platformView house:@"market"];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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

@end
