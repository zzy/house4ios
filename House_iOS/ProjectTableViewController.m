//
//  OudsFlipsideViewController.m
//  QieGan_iOS
//
//  Created by Zhongyu Zhang on 11-11-30.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "ProjectTableViewController.h"

#import "OudsAppDelegate.h"
#import "PlatformViewController.h"

#import "ASIHTTPRequest.h"
#import "NodeData.h"
#import "XMLParser.h"
#import "Project.h"

@implementation ProjectTableViewController

@synthesize delegate = _delegate;

@synthesize platformView = _platformView;
@synthesize projList = _projList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 480.0);
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    if ([oad SID] && ![@"" isEqualToString:[oad SID]]) {
        NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
        urlStr = [urlStr stringByAppendingString:@"/security/project/getProjectList/"];
        urlStr = [urlStr stringByAppendingString:[oad SID]];
        urlStr = [urlStr stringByAppendingFormat:@"?sellerUuid=%@&state=0", [oad USER_ID]];
        NSLog(@"%@", urlStr);
        
        NSURL *url = [NSURL URLWithString:urlStr];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        
        [request startSynchronous];
        NSError *error = [request error];
        // 网络连接成功
        if (!error) {
            NSData *projData = [request responseData];
            XMLParser *xmlParser = [XMLParser sharedInstance];
            NSMutableArray *projNodes = [[xmlParser parseXMLFromData:projData] objectsForKey:@"BEAN"];
            _projList = [[NSMutableArray alloc] initWithCapacity:[projNodes count]];
            for (NodeData *projNode in projNodes) {
                [_projList addObject:[Project projectWithID:[projNode leafForKey:@"id"] name:[projNode leafForKey:@"name"]]];
            }
            
        }
        else {
            UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
            [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
            [av show];
        }
    }
    else {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:@"会话过期，请重新登录！\n" delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"i_know", nil), @"退出", nil];
        [av show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        exit(0);
    }   
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark - Actions

- (IBAction)cancel:(id)sender
{
    [self.delegate projectTableViewControllerDidFinish:self];
}

#pragma mark -
#pragma mark UITableView data source and delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_projList count];
}

//- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath
//{
//    static NSString *TableViewDynamicLoadIdentifier = @"TableViewDynamicLoadIdentifier";
//    UITableViewCell *pCell = [tableView dequeueReusableCellWithIdentifier:TableViewDynamicLoadIdentifier];
//    if (pCell == nil) {
//        pCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableViewDynamicLoadIdentifier] autorelease];
//    }
//    
//    NSInteger nRow = [indexPath row];
//    pCell.textLabel.text = [_projList objectAtIndex:nRow];
//    
//    return pCell;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *projID = @"projID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:projID];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:projID] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	Project *project = [_projList objectAtIndex:indexPath.row];

	cell.textLabel.text = project.name;
    
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Project *project = [_projList objectAtIndex:indexPath.row];
    
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    [oad setPROJ_ID:[project projID]];
    [oad setPROJ_NAME:[project name]];
    [oad setSID_PROJ:[[oad SID] stringByAppendingString:[@"?projectUuid=" stringByAppendingString:[project projID]]]];
    
//    _platformView = [PlatformViewController sharedInstance];
//    [[_platformView projectName] setTitle:project.name forState:UIControlStateNormal];
//    [_platformView myStat:nil];
    
    [self.delegate setProj:project.name];
    [self.delegate projectTableViewControllerDidFinish:self];
}

@end
