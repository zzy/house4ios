//
//  RedirectViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-11-29.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "RedirectViewController.h"

#import "OudsAppDelegate.h"
#import "PlatformViewController.h"

@implementation RedirectViewController

@synthesize platformView = _platformView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"工作平台";
        //self.tabBarItem.image = [UIImage imageNamed:@"tab_platform.png"];
    }
    
    return self;
}

- (void)loadView {
    // Init the view
//    CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
//	UIView *view = [[UIView alloc] initWithFrame:appFrame];
//	view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
//	self.view = view;
//	[view release];
    
    _platformView = [PlatformViewController sharedInstance];
//    _platformView = [[[PlatformViewController alloc] initWithNibName:@"PlatformViewController" bundle:[NSBundle mainBundle]] autorelease];

    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate]; 
    [oad.window setRootViewController:_platformView];
    [oad.window makeKeyAndVisible];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

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
