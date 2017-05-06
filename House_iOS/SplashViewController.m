//
//  SplashViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-11-28.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "SplashViewController.h"

#import "OudsAppDelegate.h"
#import "LoginViewController.h"

@interface SplashViewController (Private)
- (void)Ouds;
@end

@implementation SplashViewController

@synthesize timer = _timer;
@synthesize splashImage = _splashImage;
@synthesize loginView = _loginView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }
    return self;
}

- (void)loadView {
	// Init the view
	CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
	UIView *view = [[UIView alloc] initWithFrame:appFrame];
	view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
	self.view = view;
	[view release];
	
	_splashImage = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default.png"]] autorelease];
	_splashImage.frame = CGRectMake(0, 0, 768, 1024);
	[self.view addSubview:_splashImage];
	
    // 实例化登录界面
	_loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
	_loginView.view.alpha = 0.0;
	[self.view addSubview:_loginView.view];
	
	[self Ouds];
}

- (void)fadeScreen
{
	[UIView beginAnimations:nil context:nil]; // begins animation block
	[UIView setAnimationDuration:0.75];        // sets animation duration
	[UIView setAnimationDelegate:self];        // sets delegate for this block
	[UIView setAnimationDidStopSelector:@selector(finishedFading)];   // calls the finishedFading method when the animation is done (or done fading out)	
	self.view.alpha = 0.0;       // Fades the alpha channel of this view to "0.0" over the animationDuration of "0.75" seconds
	[UIView commitAnimations];   // commits the animation block.  This Block is done.
}


- (void) finishedFading
{
	
	[UIView beginAnimations:nil context:nil]; // begins animation block
	[UIView setAnimationDuration:0.75];        // sets animation duration
	self.view.alpha = 1.0;   // fades the view to 1.0 alpha over 0.75 seconds
	_loginView.view.alpha = 1.0;
	[UIView commitAnimations];   // commits the animation block.  This Block is done.
	[_splashImage removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)Ouds 
{
	NSLog(@"启动中……");
    
    NSString *oPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    if (!oPath) {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:@"网络环境无法读取，请先配置！\n" delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    else {
        NSString *oPlist = [oPath stringByAppendingPathComponent:@"Ouds.plist"];
        
        NSMutableArray *tmpNet = [[[NSMutableArray alloc] init] autorelease];
        if([[NSFileManager defaultManager] fileExistsAtPath:oPlist])
            tmpNet = [NSMutableArray arrayWithContentsOfFile:oPlist];        
        else
            tmpNet = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Ouds" ofType:@"plist"]];
        
        NSString *network;
        if ([tmpNet objectAtIndex:0] && [tmpNet objectAtIndex:1] && [tmpNet objectAtIndex:2]) {
            network = [[NSString stringWithFormat:@"http://%@:%@/%@", [tmpNet objectAtIndex:0], [tmpNet objectAtIndex:1], [tmpNet objectAtIndex:2]] autorelease];
        }
        else {
            network = [[[NSString alloc] initWithString:@"http://"] autorelease];
        }
    
        OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
        //192.168.1.2:8080/renju
        //118.122.122.93:8181/renju
        [oad setSERVER:[[NSString alloc] initWithString:network]];
        
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(fadeScreen) userInfo:nil repeats:NO];
}

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


