//
//  ProjPhotosViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-9.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "ProjectPhotosViewController.h"

#import "OudsAppDelegate.h"
#import "PlatformViewController.h"
#import "ShowImgViewController.h"
#import "ZoomViewController.h"
#import "Photo.h"

@implementation ProjectPhotosViewController

@synthesize platformView = _platformView;
@synthesize showImgView = _showImgView;
@synthesize zoomView = _zoomView;

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

- (IBAction)platform:(id)sender
{
    // 跳转到工作平台界面
//    _platformView = [PlatformViewController sharedInstance];
    _platformView = [[PlatformViewController alloc] initWithNibName:@"PlatformViewController" bundle:[NSBundle mainBundle]];
//    
//    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate]; 
//    [oad.window setRootViewController:_platformView];
//    [oad.window makeKeyAndVisible];
    [self.view addSubview:_platformView.view];
}

- (IBAction)showApImg:(id)sender {
//    _showImgView = [[ShowImgViewController alloc] initWithNibName:@"ShowImgViewController" bundle:[NSBundle mainBundle]];
//	[self.view addSubview:_showImgView.view];
    Photo *photo = [Photo sharedInstance];
    [photo setPath:@"ap.png"];
    
    [self showZoomView];
}

- (IBAction)showBpImg:(id)sender {
    Photo *photo = [Photo sharedInstance];
    [photo setPath:@"bp.png"];
    
    [self showZoomView];
}

- (IBAction)showCpImg:(id)sender {
    Photo *photo = [Photo sharedInstance];
    [photo setPath:@"cp.png"];
    
    [self showZoomView];
}

- (IBAction)showDpImg:(id)sender {
    Photo *photo = [Photo sharedInstance];
    [photo setPath:@"dp.png"];
    
    [self showZoomView];
}

- (void)showZoomView {
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
//    _zoomView = [[[ZoomViewController alloc] init] autorelease];
    _showImgView = [[ShowImgViewController alloc] initWithNibName:@"ShowImgViewController" bundle:[NSBundle mainBundle]];
    //	[self.view addSubview:_showImgView.view];
    oad.window.rootViewController = _showImgView;
    [oad.window makeKeyAndVisible];
//    [self.view addSubview:_zoomView.view];
}

@end
