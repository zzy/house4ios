//
//  SaleInfoViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-11-29.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "SaleInfoViewController.h"

#import "OudsAppDelegate.h"
#import "XMLParser.h"
#import "NodeData.h"
#import "ASIHTTPRequest.h"
#import "SaleInfo.h"

@implementation SaleInfoViewController
@synthesize type = _type;
@synthesize price = _price;
@synthesize detail = _detail;
@synthesize time = _time;
@synthesize state = _state;

@synthesize saleInfoList = _saleInfoList;
@synthesize saleInfoTitle = _saleInfoTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"优惠信息";
        //self.tabBarItem.image = [UIImage imageNamed:@"tab_sale.png"];
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
    urlStr = [urlStr stringByAppendingString:@"/security/preferential/getList/"];
    urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
    urlStr = [urlStr stringByAppendingString:@"&state=0"];

    NSLog(@"%@", urlStr);

    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];

    [request startSynchronous];
    NSError *error = [request error];
    // 网络连接成功
    if (!error) {
        NSData *saleInfoData = [request responseData];
        XMLParser *xmlParser = [XMLParser sharedInstance];
        NSMutableArray *saleInfoNodes = [[xmlParser parseXMLFromData:saleInfoData] objectsForKey:@"BEAN"];
        _saleInfoList = [[NSMutableArray alloc] initWithCapacity:[saleInfoNodes count]];
        for (NodeData *saleInfoNode in saleInfoNodes) {
            [_saleInfoList addObject:[SaleInfo initWithTitle:[saleInfoNode leafForKey:@"title"] State:[saleInfoNode leafForKey:@"state"] Type:[saleInfoNode leafForKey:@"type"] Price:[saleInfoNode leafForKey:@"price"] Time:[saleInfoNode leafForKey:@"time"] Detail:[saleInfoNode leafForKey:@"detail"]]];
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
    [self setSaleInfoTitle:nil];
    [self setTime:nil];
    [self setState:nil];
    [self setPrice:nil];
    [self setDetail:nil];
    [self setType:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)addSaleInfo:(id)sender {
}

- (IBAction)editSaleInfo:(id)sender {
}

- (IBAction)deleteSaleInfo:(id)sender {
}
- (void)dealloc {
    [_saleInfoTitle release];
    [_time release];
    [_state release];
    [_price release];
    [_detail release];
    [_type release];
    [super dealloc];
}

#pragma mark -
#pragma mark UITableView data source and delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_saleInfoList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *saleInfoID = @"saleInfoID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:saleInfoID];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:saleInfoID] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	SaleInfo *saleInfo = [_saleInfoList objectAtIndex:indexPath.row];
    
	cell.textLabel.text = [saleInfo title];
    
    NSString *stateStr = [[[NSString alloc] init] autorelease];
    if ([@"0" isEqualToString:[saleInfo state]]) {
        stateStr = [stateStr stringByAppendingString:@"有效"];
    }
    else {
        stateStr = [stateStr stringByAppendingString:@"无效"];
    }
    
    cell.detailTextLabel.text = [stateStr stringByAppendingString:[[@"(" stringByAppendingString:[saleInfo time]] stringByAppendingString:@")"]];
    cell.detailTextLabel.textColor = [UIColor blueColor];
    
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SaleInfo *saleInfo = [_saleInfoList objectAtIndex:indexPath.row];
    
    [_saleInfoTitle setText:[saleInfo title]];
    [_time setText:[saleInfo time]];
    
    NSString *stateStr = [[[NSString alloc] init] autorelease];
    if ([@"0" isEqualToString:[saleInfo state]]) {
        stateStr = [stateStr stringByAppendingString:@"有效"];
    }
    else {
        stateStr = [stateStr stringByAppendingString:@"无效"];
    }
    [_state setText:stateStr];
    
    NSString *typeStr = [[[NSString alloc] init] autorelease];
    if ([@"0" isEqualToString:[saleInfo type]]) {
        typeStr = [typeStr stringByAppendingString:@"折扣"];
    }
    else {
        typeStr = [typeStr stringByAppendingString:@"返现"];
    }
    [_type setText:typeStr];
    
    [_price setText:[saleInfo price]];
    [_detail setText:[saleInfo detail]];
}

@end
