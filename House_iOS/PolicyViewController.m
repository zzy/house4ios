//
//  PolicyViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-12.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "PolicyViewController.h"

#import "ToolsViewController.h"
#import "Policy.h"

#import "OudsAppDelegate.h"
#import "XMLParser.h"
#import "NodeData.h"
#import "ASIHTTPRequest.h"

@implementation PolicyViewController

@synthesize policyList = _policyList;

@synthesize textView_detail = _textView_detail;
@synthesize toolsView = _toolsView;
@synthesize label_title = _label_title;
@synthesize label_time = _label_time;
@synthesize label_state = _label_state;

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
    
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    // 判断当前是否在项目中
    //    NSString *currentProject = [oad PROJ_ID];
    //    if (nil == currentProject || [@"" isEqualToString:currentProject]) {
    //        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"proj_select", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
    //        [av show];
    //    }
    //    else {
    NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
    urlStr = [urlStr stringByAppendingString:@"/security/policy/getList/"];
    urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
    urlStr = [urlStr stringByAppendingString:@"&state=0&sort=title&dir=asc"];
    NSLog(@"%@", urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request startSynchronous];
    NSError *error = [request error];
    // 网络连接成功
    if (!error) {
        NSData *policyData = [request responseData];
        XMLParser *xmlParser = [XMLParser sharedInstance];
        NSMutableArray *policyNodes = [[xmlParser parseXMLFromData:policyData] objectsForKey:@"BEAN"];
        _policyList = [[NSMutableArray alloc] initWithCapacity:[policyNodes count]];
        for (NodeData *policyNode in policyNodes) {
            if ([policyNode leafForKey:@"title"] && [policyNode leafForKey:@"time"]) {
                [_policyList addObject:[Policy initWithID:[policyNode leafForKey:@"id"] Detail:[policyNode leafForKey:@"detail"] State:[policyNode leafForKey:@"state"] Time:[policyNode leafForKey:@"time"] Title:[policyNode leafForKey:@"title"]]];
            }
        }
        
    }
    else {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    //    }
}

- (void)viewDidUnload
{
    [self setLabel_title:nil];
    [self setTextView_detail:nil];
    [self setLabel_time:nil];
    [self setLabel_state:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)tools:(id)sender {
    _toolsView = [[ToolsViewController alloc] initWithNibName:@"ToolsViewController" bundle:[NSBundle mainBundle]];
    [self.view addSubview:_toolsView.view];
}

- (void)dealloc {
    [_label_title release];
    [_textView_detail release];
    [_label_time release];
    [_label_state release];
    [super dealloc];
}

#pragma mark -
#pragma mark UITableView data source and delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_policyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *policyID = @"policyID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:policyID];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:policyID] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	Policy *policy = [_policyList objectAtIndex:indexPath.row];
    
	cell.textLabel.text = [policy title];
    
    NSString *stateStr = [[[NSString alloc] init] autorelease];
    if ([@"0" isEqualToString:[policy state]]) {
        stateStr = [stateStr stringByAppendingString:@"有效"];
    }
    else {
        stateStr = [stateStr stringByAppendingString:@"无效"];
    }
    
    cell.detailTextLabel.text = [stateStr stringByAppendingString:[[@"(" stringByAppendingString:[policy time]] stringByAppendingString:@")"]];
    cell.detailTextLabel.textColor = [UIColor blueColor];
    
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Policy *policy = [_policyList objectAtIndex:indexPath.row];
    
    [_label_title setText:[policy title]];
    [_label_time setText:[policy time]];
    
    NSString *stateStr = [[[NSString alloc] init] autorelease];
    if ([@"0" isEqualToString:[policy state]]) {
        stateStr = [stateStr stringByAppendingString:@"有效"];
    }
    else {
        stateStr = [stateStr stringByAppendingString:@"无效"];
    }
    
    [_label_state setText:stateStr];
    [_textView_detail setText:[policy detail]];
}

@end
