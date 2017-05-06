//
//  SheetFormViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-11.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import "SheetFormViewController.h"

#import "COMMON.h"
#import "Server.h"

#import "OudsAppDelegate.h"
#import "ASIFormDataRequest.h"

#import "XMLParser.h"
#import "NodeData.h"

@implementation SheetFormViewController

@synthesize delegate = _delegate;

@synthesize time = _time;
@synthesize sign = _sign;
@synthesize desc = _desc;
@synthesize client = _client;
@synthesize colleague = _colleague;
@synthesize importantItems = _importantItems;
@synthesize elseCircs = _elseCircs;

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
}

- (void)viewDidUnload
{
    [self setTime:nil];
    [self setSign:nil];
    [self setDesc:nil];
    [self setClient:nil];
    [self setColleague:nil];
    [self setImportantItems:nil];
    [self setElseCircs:nil];
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
    [_sign release];
    [_desc release];
    [_client release];
    [_colleague release];
    [_importantItems release];
    [_elseCircs release];
    [super dealloc];
}
- (IBAction)submit:(id)sender {
    //获取项目信息数据
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    
    if (!([@"" isEqualToString:[_sign text]] || 
          [@"" isEqualToString:[_desc text]] || 
          [@"" isEqualToString:[_colleague text]] || 
          [@"" isEqualToString:[_client text]] || 
          [@"" isEqualToString:[_importantItems text]] || 
          [@"" isEqualToString:[_elseCircs text]])) {
        OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
        
        NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
        urlStr = [urlStr stringByAppendingString:@"/security/sell/addSheetTrack/"];
        urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
        //        urlStr = [urlStr stringByAppendingString:[@"&sheetUuid=" stringByAppendingString:sID]];
        //        urlStr = [urlStr stringByAppendingString:[@"&id=" stringByAppendingString:mID]];
        NSLog(@"%@", urlStr);
        
        NSURL *url = [NSURL URLWithString:urlStr];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        
        [request setPostValue:[oad PROJ_ID] forKey:@"projectUuid"];
//        [request setPostValue:[oad USER_ID] forKey:@"sellerUuid"];
        
        Server *sev= [Server sharedInstance];
        [request setPostValue:[sev sID] forKey:@"sheetUuid"];
        
        [request setPostValue:[_time text] forKey:@"time"];
        [request setPostValue:[COMMON iso8859str:[_sign text]] forKey:@"sign"];
        [request setPostValue:[COMMON iso8859str:[_desc text]] forKey:@"descp"];
        [request setPostValue:[COMMON iso8859str:[_colleague text]] forKey:@"colleague"];
        [request setPostValue:[COMMON iso8859str:[_client text]] forKey:@"client"];
        [request setPostValue:[COMMON iso8859str:[_importantItems text]] forKey:@"importantItems"];
        [request setPostValue:[COMMON iso8859str:[_elseCircs text]] forKey:@"elseCircs"];
        
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
                    [_delegate setStateInfo];
                    
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
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"所有内容必须填写！\n", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];  
    }
}

- (IBAction)cancel:(id)sender {
    [self.view removeFromSuperview];
}

@end
