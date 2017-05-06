//
//  ToolsViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-12.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "ToolsViewController.h"

#import "PlatformViewController.h"
#import "Calculator.h"

#import "CalculatorViewController.h"
#import "PolicyViewController.h"
#import "PersonStatViewController.h"

@implementation ToolsViewController

@synthesize platformView = _platformView;

@synthesize calculatorView = _calculatorView;
@synthesize policyView = _policyView;
@synthesize personStatView = _personStatView;

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

- (IBAction)calculator:(id)sender {
    Calculator *cal = [Calculator sharedInstance];
    [cal setFromHouse:@"0"];
    
    _calculatorView = [[CalculatorViewController alloc] initWithNibName:@"CalculatorViewController" bundle:[NSBundle mainBundle]];
    [self.view.window setRootViewController:_calculatorView];
}

- (IBAction)policy:(id)sender {
    _policyView = [[PolicyViewController alloc] initWithNibName:@"PolicyViewController" bundle:[NSBundle mainBundle]];
    [self.view.window setRootViewController:_policyView];
}

- (IBAction)personStat:(id)sender {
    _personStatView = [[PersonStatViewController alloc] initWithNibName:@"PersonStatViewController" bundle:[NSBundle mainBundle]];
    [self.view.window setRootViewController:_personStatView];
}

@end
