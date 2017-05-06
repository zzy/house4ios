//
//  CustomerGroupViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-11-29.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "CustomerGroupViewController.h"

#import "OudsAppDelegate.h"
#import "NodeData.h"
#import "XMLParser.h"
#import "ASIHTTPRequest.h"
#import "Group.h"
#import "Customer.h"

@implementation CustomerGroupViewController

@synthesize delegate = _delegate;

@synthesize groupTable = _groupTable;
@synthesize groupList = _groupList;
@synthesize cltTable = _cltTable;
@synthesize cltList = _cltList;

static NSString *limit = @"100";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"客户群组";
        //self.tabBarItem.image = [UIImage imageNamed:@"tab_group.png"];
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
    
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];

    NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
    urlStr = [urlStr stringByAppendingString:@"/security/seller/getTeamList/"];
    urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
    NSLog(@"%@", urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request startSynchronous];
    NSError *error = [request error];
    // 网络连接成功
    if (!error) {
        NSData *groupData = [request responseData];
        XMLParser *xmlParser = [XMLParser sharedInstance];
        NSMutableArray *groupNodes = [[xmlParser parseXMLFromData:groupData] objectsForKey:@"BEAN"];
        
        _groupList = [[NSMutableArray alloc] initWithCapacity:[groupNodes count]];
        for (NodeData *groupNode in groupNodes) {
            if (groupNode && [groupNode leafForKey:@"id"] && [groupNode leafForKey:@"name"]) {
                NSString *gID = [[groupNode leafForKey:@"id"] autorelease];
                
                NSString *urlCStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
                urlCStr = [urlCStr stringByAppendingString:@"/security/seller/getSellerList/"];
                urlCStr = [urlCStr stringByAppendingString:[oad SID_PROJ]];
                urlCStr = [urlCStr stringByAppendingString:[@"&teamUuid=" stringByAppendingString:gID]];
                NSLog(@"%@", urlCStr);
                
                NSURL *urlC = [NSURL URLWithString:urlCStr];
                ASIHTTPRequest *requestC = [ASIHTTPRequest requestWithURL:urlC];
                
                [requestC startSynchronous];
                NSError *errorC = [requestC error];
                // 网络连接成功
                if (!errorC) {
                    NSData *gcData = [requestC responseData];
                    NSMutableArray *gcNodes = [[xmlParser parseXMLFromData:gcData] objectsForKey:@"BEAN"];
                    
                    NSMutableArray *gcArr = [[[NSMutableArray alloc] init] autorelease];
                    for (NodeData *gcNode in gcNodes) {
                        if (gcNode && [gcNode leafForKey:@"id"] && [gcNode leafForKey:@"name"] && [gcNode leafForKey:@"clientCount"]) {
                            [gcArr addObject:[NSArray arrayWithObjects:[gcNode leafForKey:@"id"], [gcNode leafForKey:@"name"], [gcNode leafForKey:@"clientCount"], nil]];
                        }
                    }
                    
//                    if ([gcArr count] > 0) {
                    [_groupList addObject:[Group initWithName:[groupNode leafForKey:@"name"] cList:gcArr]];
//                    }
                }
                else {
                    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
                    [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
                    [av show];
                }
        }
        }
        
    }
    else {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    
    [_groupTable setTag:1];
    [_cltTable setTag:2];
}

- (void)viewDidUnload
{
    [self setGroupTable:nil];
    [self setCltTable:nil];
    [self setGroupList:nil];
    [self setCltList:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark UITableView data source and delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    int secCount = 1;
    switch ([tableView tag]) {
        case 1:{
            secCount = [_groupList count];
            
            break;
        }
    }
    
	// Number of sections is the number of regions.
	return secCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int rowCount = 0;
    switch ([tableView tag]) {
        case 1:{
            // Number of rows is the number of time zones in the region for the specified section.
            Group *group = [_groupList objectAtIndex:section];
            rowCount = [[group cList] count];
            
            break;
        }
        case 2:{
            rowCount = [_cltList count];
            
            break;
        }
    }
    
	return rowCount;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *name;
    switch ([tableView tag]) {
        case 1:{
            // The header for the section is the region name -- get this from the region at the section index.
            Group *group = [_groupList objectAtIndex:section];
            name = [[NSString alloc] initWithString:[group name]];
            
            break;
        }
        case 2:{
            name = [[NSString alloc] initWithString:@"客户列表"];
            
            break;
        }
    }
    
	return name;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    switch ([tableView tag]) {
        case 1:{
            static NSString *groupID = @"groupID";
            
            cell = [tableView dequeueReusableCellWithIdentifier:groupID];
            if (cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:groupID] autorelease];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            
            // Get the section index, and so the region for that section.
            Group *group = [_groupList objectAtIndex:indexPath.section];
            NSArray *sArr = [[group cList] objectAtIndex:indexPath.row];
            
            // Set the cell's text to the name of the time zone at the row
            cell.textLabel.text = [sArr objectAtIndex:1];
            cell.detailTextLabel.text = [sArr objectAtIndex:2];
            
            break;
        }
        case 2:{
            static NSString *cltID = @"cltID";
            
            cell = [tableView dequeueReusableCellWithIdentifier:cltID];
            if (cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cltID] autorelease];
                cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
            }
            
            // Get the section index, and so the region for that section.
//            NSArray *cArr = [_cltList objectAtIndex:indexPath.row];
            
            // Set the cell's text to the name of the time zone at the row
//            cell.textLabel.text = [cArr objectAtIndex:1];
//            cell.detailTextLabel.text = [cArr objectAtIndex:2];
            
            Customer *customer = [_cltList objectAtIndex:indexPath.row];
            
            cell.textLabel.text = [customer name];
            cell.detailTextLabel.text = [customer phone];
            
            [cell.detailTextLabel setFont:[UIFont systemFontOfSize:16]];
            [cell.detailTextLabel setTextColor:[UIColor darkGrayColor]];
            
            break;
        }
    }
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([tableView tag]) {
        case 1:{
            // Get the section index, and so the region for that section.
            Group *group = [_groupList objectAtIndex:indexPath.section];
            
            NSArray *cArr = [[group cList] objectAtIndex:indexPath.row];
            
            [self refreshClients:[cArr objectAtIndex:0]];
            
            break;
        }
        case 2:{
            Customer *customer = [_cltList objectAtIndex:indexPath.row];
            
            if ([@"电话隐藏" isEqualToString:[customer phone]]) {
                UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
                [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:@"无权浏览客户信息！\n" delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
                [av show];
            }
            else {
//                Group *group = [Group sharedInstance];
                
                [_delegate setGrpCstm:_cltList index:indexPath];
                
                [self.tabBarController setSelectedIndex:1];
            }
            
            break;
        }
    }
}

- (void)refreshClients:(NSString *)seller
{
    //获取项目信息数据
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
    urlStr = [urlStr stringByAppendingString:@"/security/client/getClientList/"];
    urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
    urlStr = [urlStr stringByAppendingString:[@"&sellerUuid=" stringByAppendingString:seller]];
//    urlStr = [urlStr stringByAppendingString:[@"&limit=" stringByAppendingString:limit]];
    NSLog(@"%@", urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request startSynchronous];
    NSError *error = [request error];
    // 网络连接成功
    if (!error) {
        NSData *customerData = [request responseData];
        XMLParser *xmlParser = [XMLParser sharedInstance];
        NSMutableArray *customerNodes = [[xmlParser parseXMLFromData:customerData] objectsForKey:@"BEAN"];
        
        _cltList = [[NSMutableArray alloc] initWithCapacity:[customerNodes count]];
        for (NodeData *cltNode in customerNodes) {
            if (cltNode && [cltNode leafForKey:@"id"] && [cltNode leafForKey:@"name"] && [cltNode leafForKey:@"phone"]) {
                
                NSString *cltPhone;
                if ([[oad USER_ID] isEqualToString:[cltNode leafForKey:@"sellerUuid"]]) {
                    cltPhone = [[[NSString alloc] initWithString:[cltNode leafForKey:@"phone"]] autorelease];
                }
                else {
                    cltPhone = [[[NSString alloc] initWithString:@"电话隐藏"] autorelease];
                }
                
//                [_cltList addObject:[NSArray arrayWithObjects:[cltNode leafForKey:@"id"], [cltNode leafForKey:@"name"], cltPhone, nil]];
                NSString *updateTime = [[[NSString alloc] initWithString:[cltNode leafForKey:@"updateTime"]] autorelease];
                if (10 <= [updateTime length]) {
                    updateTime = [updateTime substringToIndex:10];
                }
                
                [_cltList addObject:[Customer initWithID:[cltNode leafForKey:@"id"] Name:[cltNode leafForKey:@"name"] phone:cltPhone UpdateTime:updateTime Type:[cltNode leafForKey:@"type"]]];
            }
        }
        
        [_cltTable reloadData];
    }
    else {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
}

- (void)dealloc {
    [_groupTable release];
    [_groupList release];
    
    [_cltTable release];
    [_cltList release];
    
    [super dealloc];
}

@end
