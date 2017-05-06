//
//  NetworkViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-12.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "NetworkViewController.h"

#import "ConfigViewController.h"
#import "SplashViewController.h"
#import "OudsAppDelegate.h"

@implementation NetworkViewController

@synthesize configView = _configView;
@synthesize splashView = _splashView;

@synthesize netAddr = _netAddr;
@synthesize netPort = _netPort;
@synthesize netRoot = _netRoot;
@synthesize isSSL = _isSSL;
@synthesize sslPort = _sslPort;
@synthesize sslAddr = _sslAddr;

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
    
    NSString *oPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    if (!oPath) {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];

        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:@"配置失败，无法读取本机环境！\n" delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    else {
        NSString *oPlist = [oPath stringByAppendingPathComponent:@"Ouds.plist"];
    
        NSMutableArray *tmpNet = [[[NSMutableArray alloc] init] autorelease];
        if([[NSFileManager defaultManager] fileExistsAtPath:oPlist])
            tmpNet = [NSMutableArray arrayWithContentsOfFile:oPlist];        
        else
            tmpNet = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Ouds" ofType:@"plist"]];
            
        if ([tmpNet objectAtIndex:0]) {
            [_netAddr setText:[[[NSString alloc] initWithString:[tmpNet objectAtIndex:0]] autorelease]];
        }
        else {
            [_netAddr setText:[[[NSString alloc] initWithString:@""] autorelease]];
        }
        
        if ([tmpNet objectAtIndex:1]) {
            [_netPort setText:[[[NSString alloc] initWithString:[tmpNet objectAtIndex:1]] autorelease]];
        }
        else {
            [_netPort setText:[[[NSString alloc] initWithString:@""] autorelease]];
        }
        
        if ([tmpNet objectAtIndex:2]) {
            [_netRoot setText:[[[NSString alloc] initWithString:[tmpNet objectAtIndex:2]] autorelease]];
        }
        else {
            [_netRoot setText:[[[NSString alloc] initWithString:@""] autorelease]];
        }
    }
    
}

- (void)viewDidUnload
{
    [self setNetAddr:nil];
    [self setNetPort:nil];
    [self setNetRoot:nil];
    [self setIsSSL:nil];
    [self setSslPort:nil];
    [self setSslAddr:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)config:(id)sender {
    OudsAppDelegate *oad = [[UIApplication sharedApplication] delegate];
    if ([oad isLogin]) {
        _configView = [[ConfigViewController alloc] initWithNibName:@"ConfigViewController" bundle:[NSBundle mainBundle]];
        [self.view addSubview:_configView.view];
    }
    else {
        // 装载启动视图
        _splashView = [[[SplashViewController alloc] init] autorelease];
        [self.view.window setRootViewController:_splashView];
        [self.view.window makeKeyAndVisible];
    }
}

- (IBAction)emptyValues:(id)sender {
    [_netAddr setText:@""];
    [_netPort setText:@""];
    [_netRoot setText:@""];
    [_isSSL setOn:false];
    [_sslAddr setText:@""];
    [_sslPort setText:@""];
}

- (IBAction)resetNetwork:(id)sender {
    [_netAddr resignFirstResponder];
    
    // 获取用户输入
    NSString *netAddr;
    if (_netAddr.text) {
        netAddr = [[[NSString alloc] initWithString:[_netAddr.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]] autorelease];
    }
    else {
        netAddr = [[[NSString alloc] initWithString:@""] autorelease];
    }
    
    NSString *netPort;
    if (_netPort.text) {
        netPort = [[[NSString alloc] initWithString:[_netPort.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]] autorelease];
    }
    else {
        netPort = [[[NSString alloc] initWithString:@""] autorelease];
    }
    
    NSString *netRoot;
    if (_netRoot.text) {
        netRoot = [[[NSString alloc] initWithString:[_netRoot.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]] autorelease];
    }
    else {
        netRoot = [[[NSString alloc] initWithString:@""] autorelease];
    }
    
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    
    if ([@"" isEqualToString:netAddr] || [@"" isEqualToString:netPort] || [@"" isEqualToString:netRoot]) {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:@"非加密服务器设置中，\n地址、端口、根目录均不能为空！\n" delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    else {
        NSString *oPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        if (!oPath) {
            UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
            
            [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:@"配置失败，无法读取本机环境！\n" delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
            [av show];
        }
        else {
            NSString *oPlist = [oPath stringByAppendingPathComponent:@"Ouds.plist"];
            
            [[NSArray arrayWithObjects:netAddr, netPort, netRoot, nil] writeToFile:oPlist atomically:NO];
//            [[NSArray arrayWithObjects:netAddr, netPort, netRoot, nil] writeToFile:oPlist atomically:NO encoding:NSStringEncodingConversionAllowLossy error:nil];
            
            [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:@"网络配置成功！\n" delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
            [av show];
            
            // 装载启动视图
            _splashView = [[[SplashViewController alloc] init] autorelease];
            [self.view.window setRootViewController:_splashView];
            [self.view.window makeKeyAndVisible];
            
            // 实例化登录界面
    //            _loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];    
    //            [self.view.window setRootViewController:_loginView];
    //            [self.view.window makeKeyAndVisible];   
            }
    }
}

- (void)dealloc {
    [_netAddr release];
    [_netPort release];
    [_netRoot release];
    [_isSSL release];
    [_sslPort release];
    [_sslAddr release];
    
    [super dealloc];
}

@end
