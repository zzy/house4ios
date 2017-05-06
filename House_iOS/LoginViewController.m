//
//  LoginViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-11-28.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "LoginViewController.h"

#import "PlatformViewController.h"
#import "OudsAppDelegate.h"
#import "COMMON.h"
#import "ASIFormDataRequest.h"
#import "XMLParser.h"
#import "NodeData.h"
#import "NetworkViewController.h"

@implementation LoginViewController

@synthesize username = _username;
@synthesize password = _password;
@synthesize remPwd = _remPwd;
@synthesize networkView = _networkView;

@synthesize platformView = _platformView;
//@synthesize platformView2 = _platformView2;

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
    _username.frame = CGRectMake(360, 437, 200, 46);
    [_username setReturnKeyType:UIReturnKeyNext];
    
    _password.frame = CGRectMake(360, 527, 200, 46);
    [_password setReturnKeyType:UIReturnKeyNext];
    
    _remPwd.frame = CGRectMake(360, 586, 300, 246);
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    [oad setIsLogin:NO];
}

- (void)viewDidUnload
{
    [self setUsername:nil];
    [self setPassword:nil];
    [self setRemPwd:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [_username release];
    [_password release];
    [_remPwd release];
    
    [super dealloc];
}

- (IBAction)login:(id)sender {
    [_username resignFirstResponder];
    [_password resignFirstResponder];
    
    // 获取用户输入
    NSString *username = [[[NSString alloc] initWithString:[_username.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]] autorelease];
    NSString *password = [[[NSString alloc] initWithString:[_password.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]] autorelease];
    COMMON *common = [COMMON sharedInstance];
    password = [common md5:password];
    
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    // 输入不能为空
    if (!([@"" isEqualToString:username] || [@"" isEqualToString:password])) {
        NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
        urlStr = [urlStr stringByAppendingString:@"/public/login/"];
        NSLog(@"%@", urlStr);
        
        NSURL *url = [NSURL URLWithString:urlStr];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:username forKey:@"id"];
        [request setPostValue:password forKey:@"pwd"];
        
        // [request setRequestMethod:@"POST"];
        [request startSynchronous];
        NSError *error = [request error];
        // 网络连接成功
        if (!error) {
            NSData *loginData = [request responseData];
            XMLParser *xmlParser = [XMLParser sharedInstance];
            NodeData *loginNode = [xmlParser parseXMLFromData:loginData];
            
            if (loginNode) {
                NSString *state = [[[NSString alloc] initWithString:[loginNode leafForKey:@"state"]] autorelease];
                // 登录成功
                if ([@"0" isEqualToString:state]) {
                    [oad setLOGIN_ID:[loginNode leafForKey:@"loginId"]];
                    [oad setUSER_ID:[loginNode leafForKey:@"sellerUuid"]];
                    [oad setUSERNAME:[loginNode leafForKey:@"sellerName"]];
                    [oad setSID:[@";" stringByAppendingString:[loginNode leafForKey:@"sessionid"]]];
                    
                    // 跳转到工作平台界面
    //                _platformView = [PlatformViewController sharedInstance];
                    _platformView = [[PlatformViewController alloc] initWithNibName:@"PlatformViewController" bundle:[NSBundle mainBundle]];
//                    oad.window.rootViewController = _platformView;
                    [oad setIsLogin:YES];
                    [oad.window setRootViewController:_platformView];
    //                [self.view addSubview:_platformView.view];
                }
                else {
                    [av initWithTitle:NSLocalizedString(@"login_info", nil) message:[loginNode leafForKey:@"stateDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"back", nil), NSLocalizedString(@"config", nil), nil];
                    [av show];
                }
            }
            else {
                [av initWithTitle:NSLocalizedString(@"login_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"back", nil), NSLocalizedString(@"config", nil), nil];
                [av show];
            }
        }
        else {
            [av initWithTitle:NSLocalizedString(@"login_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"back", nil), NSLocalizedString(@"config", nil), nil];
            [av show];
        }
        
    }
    else {
        [av initWithTitle:NSLocalizedString(@"login_info", nil) message:NSLocalizedString(@"login_input", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
}

- (IBAction)netConfig:(id)sender {
    [self alertView:nil clickedButtonAtIndex:1];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.username || theTextField == _password) {
        [theTextField resignFirstResponder];
    }
    
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        _networkView = [[NetworkViewController alloc] initWithNibName:@"NetworkViewController" bundle:[NSBundle mainBundle]];
        [self.view.window setRootViewController:_networkView];
    }   
}

@end
