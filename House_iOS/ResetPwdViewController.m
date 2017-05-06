//
//  ResetPwdViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-12.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "ResetPwdViewController.h"

#import "ConfigViewController.h"
#import "LoginViewController.h"
#import "OudsAppDelegate.h"
#import "ASIFormDataRequest.h"
#import "NodeData.h"
#import "XMLParser.h"
#import "COMMON.h"

@implementation ResetPwdViewController

@synthesize configView = _configView;
@synthesize loginView = _loginView;

@synthesize oldPwd = _oldPwd;
@synthesize newPwd = _newPwd;
@synthesize reNewPwd = _reNewPwd;

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
    [self setOldPwd:nil];
    [self setNewPwd:nil];
    [self setReNewPwd:nil];
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
    _configView = [[ConfigViewController alloc] initWithNibName:@"ConfigViewController" bundle:[NSBundle mainBundle]];
    [self.view addSubview:_configView.view];
}

- (IBAction)resetPwd:(id)sender {
    [_oldPwd resignFirstResponder];
    [_newPwd resignFirstResponder];
    [_reNewPwd resignFirstResponder];
    
    // 获取用户输入
    NSString *oldPwd = [[[NSString alloc] initWithString:[_oldPwd.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]] autorelease];
    NSString *newPswd = [[[NSString alloc] initWithString:[_newPwd.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]] autorelease];
    NSString *reNewPwd = [[[NSString alloc] initWithString:[_reNewPwd.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]] autorelease];
    
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if ([@"" isEqualToString:oldPwd] || [@"" isEqualToString:newPswd] || [@"" isEqualToString:reNewPwd]) {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:@"所有输入项均不能为空！\n" delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    else if (![newPswd isEqualToString:reNewPwd]) {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:@"新密码两次输入不匹配！\n" delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    else if ([newPswd isEqualToString:oldPwd]) {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:@"新旧密码请勿相同！\n" delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }                                     
    else {
        NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
        urlStr = [urlStr stringByAppendingString:@"/public/login/"];
        NSLog(@"%@", urlStr);
        
        NSURL *url = [NSURL URLWithString:urlStr];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:[oad LOGIN_ID] forKey:@"id"];
        COMMON *common = [COMMON sharedInstance];
        [request setPostValue:[common md5:oldPwd] forKey:@"pwd"];
        
        NSLog(@"%@", [oad LOGIN_ID]);
        
        // [request setRequestMethod:@"POST"];
        [request startSynchronous];
        NSError *error = [request error];
        // 网络连接成功
        if (!error) {
            NSData *loginData = [request responseData];
            XMLParser *xmlParser = [XMLParser sharedInstance];
            NodeData *loginNode = [xmlParser parseXMLFromData:loginData];
            
            NSString *state = [[[NSString alloc] initWithString:[loginNode leafForKey:@"state"]] autorelease];
            
            // 登录成功
            if ([@"0" isEqualToString:state]) {
                NSString *urlStr2 = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
                urlStr2 = [urlStr2 stringByAppendingString:@"/security/seller/updateSellerByLoginId/"];
                NSLog(@"%@", urlStr2);
                
                NSURL *url2 = [NSURL URLWithString:urlStr2];
                ASIFormDataRequest *request2 = [ASIFormDataRequest requestWithURL:url2];
                [request2 setPostValue:[oad LOGIN_ID] forKey:@"loginId"];
                [request2 setPostValue:newPswd forKey:@"pwd"];
                
                [request setPostValue:[oad PROJ_ID] forKey:@"projectUuid"];
                [request setPostValue:[oad USER_ID] forKey:@"sellerUuid"];
                
                // [request setRequestMethod:@"POST"];
                [request2 startSynchronous];
                NSError *error2 = [request2 error];
                if (!error2) {
                    [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:@"密码修改成功！" delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
                    [av show];
                    
                    // 实例化登录界面
                    _loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];   
                    self.view.window.rootViewController = _loginView;
                    [self.view.window makeKeyAndVisible];
                    //	_loginView.view.alpha = 0.0;
                    //	[self.view addSubview:_loginView.view];
                }
                else {
                    [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:@"修改密码失败，请检查！\n" delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
                    [av show];
                }
            }
            else {
                [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:[loginNode leafForKey:@"stateDesc"] delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
                [av show];
            }
        }
        else {
            [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
            [av show];
        }
    }
}

- (void)dealloc {
    [_oldPwd release];
    [_newPwd release];
    [_reNewPwd release];
    [super dealloc];
}
@end
