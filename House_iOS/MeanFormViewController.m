//
//  MeanFormViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-11.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import "MeanFormViewController.h"

#import "OudsAppDelegate.h"
#import "COMMON.h"
#import "ASIFormDataRequest.h"

#import "Customer.h"
#import "NodeData.h"
#import "XMLParser.h"

@implementation MeanFormViewController

@synthesize time = _time;
@synthesize policy = _policy;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    COMMON *comm = [COMMON sharedInstance];
    [_time setText:[comm cur_day]];
    
//    [_policy setFrame:CGRectMake(130, 135, 206, 120)];
//    [_policy setEnablesReturnKeyAutomatically:YES];
}

- (void)viewDidUnload
{
    [self setTime:nil];
    [self setPolicy:nil];
    
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
    [_time release];
    [_policy release];
    
    [super dealloc];
}
- (IBAction)submit:(id)sender {
    //获取项目信息数据
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    
    if (![@"" isEqualToString:[_policy text]]) {
        OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
        
        NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
        urlStr = [urlStr stringByAppendingString:@"/security/client/addClientTactic/"];
        urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
        //        urlStr = [urlStr stringByAppendingString:[@"&sheetUuid=" stringByAppendingString:sID]];
        //        urlStr = [urlStr stringByAppendingString:[@"&id=" stringByAppendingString:mID]];
        NSLog(@"%@", urlStr);
        
        NSURL *url = [NSURL URLWithString:urlStr];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        
        [request setPostValue:[oad PROJ_ID] forKey:@"projectUuid"];
        [request setPostValue:[oad USER_ID] forKey:@"sellerUuid"];
        
        Customer *cstm = [Customer sharedInstance];
        [request setPostValue:[cstm customerID] forKey:@"clientUuid"];
        
        [request setPostValue:[COMMON iso8859str:[_policy text]] forKey:@"policy"];
        
        [request startSynchronous];
        NSError *error = [request error];
        // 网络连接成功
        if (!error) {
            NSData *loginData = [request responseData];
            XMLParser *xmlParser = [XMLParser sharedInstance];
            NodeData *loginNode = [xmlParser parseXMLFromData:loginData];
            
            if (loginNode) {
                [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:[[loginNode leafForKey:@"message"] stringByAppendingString:@"\n"] delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
                [av show];
                
                if ([@"0" isEqualToString:[loginNode leafForKey:@"state"]]){
                    [self.delegate setMeanInfo];
                    
                    [self.view removeFromSuperview];
                }
            }
            else {
                [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:@"未知错误，请联系管理员！\n" delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
                [av show];
            }
        }
        else {
            [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
            [av show];
        }
    }
    else {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"策略内容必须填写！\n", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];  
    }
}

- (IBAction)cancel:(id)sender {
    [self.view removeFromSuperview];
}

- (const char *)printBytes:(NSString *)str encoding:(NSStringEncoding)enc 
{
    NSLog (@"defaultCStringEncoding:%d" ,[NSString defaultCStringEncoding]);
    // 根据给定的字符编码，打印出编码后的字符数组
    const char *bytes= [str cStringUsingEncoding:enc];
    for (int i= 0 ;i< strlen(bytes);i++) {
        NSLog ( @"%d %X" ,(i+ 1 ),bytes[i]);
    }
    
    return bytes;
}

@end
