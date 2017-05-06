//
//  PersonStatViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-12.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "PersonStatViewController.h"

#import "ToolsViewController.h"
#import "ASIHTTPRequest.h"
#import "NodeData.h"
#import "XMLParser.h"
#import "OudsAppDelegate.h"

@implementation PersonStatViewController

@synthesize toolsView = _toolsView;
@synthesize scrollView_data = _scrollView_data;
@synthesize personTable = _personTable;
@synthesize tmpCell = _tmpCell;
@synthesize personList = _personList;
@synthesize cellNib = _cellNib;

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
    
    //获取项目信息数据
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
    urlStr = [urlStr stringByAppendingString:@"/security/report/getSellBargainStatList/"];
    urlStr = [urlStr stringByAppendingString:[oad SID]];
    urlStr = [urlStr stringByAppendingString:[@"?sellerUuid=" stringByAppendingString:[oad USER_ID]]];
    urlStr = [urlStr stringByAppendingString:[@"&projectUuid=" stringByAppendingString:[oad PROJ_ID]]];
    NSLog(@"%@", urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request startSynchronous];
    NSError *error = [request error];
    // 网络连接成功
    if (!error) {
        NSData *personData = [request responseData];
        XMLParser *xmlParser = [XMLParser sharedInstance];        
        NSMutableArray *personNodes = [[xmlParser parseXMLFromData:personData] objectsForKey:@"BEAN"];
        
        _personList = [[NSMutableArray alloc] initWithCapacity:[personNodes count]];
        for (int i=0; i<[personNodes count]; ++i) { // NodeData *pNode in personNodes
            NodeData *pNode = [personNodes objectAtIndex:i];
            NSString *orderTime = [[[NSString alloc] initWithString:[pNode leafForKey:@"orderTime"]] autorelease];
            if (10 <= [orderTime length]) {
                orderTime = [orderTime substringToIndex:10];
            }
            
            NSString *updateTime = [[[NSString alloc] initWithString:[pNode leafForKey:@"contractTime"]] autorelease];
            if (10 <= [updateTime length]) {
                updateTime = [updateTime substringToIndex:10];
            }
            
            [_personList addObject:[NSArray arrayWithObjects:[pNode leafForKey:@"houseDesc"], [pNode leafForKey:@"clientName"], orderTime, updateTime, [pNode leafForKey:@"contractNo"], [pNode leafForKey:@"buildingArea"], [pNode leafForKey:@"contractTotalPrice"], [pNode leafForKey:@"payMethod"], [pNode leafForKey:@"backPay"], [pNode leafForKey:@"unbackPay"], [pNode leafForKey:@"handTime"], [pNode leafForKey:@"radix"], [pNode leafForKey:@"proportion"], [pNode leafForKey:@"quotiety"], [pNode leafForKey:@"haveMoney"], [pNode leafForKey:@"leaveMoney"], [NSString stringWithFormat:@"%i.", i+1], nil]];
        }
    }
    else {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    
    // 获取楼栋列表数据
    _personTable.rowHeight = 31.0;
    self.cellNib = [UINib nibWithNibName:@"IndividualBasedPersonCell" bundle:nil];
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight|UIInterfaceOrientationLandscapeLeft];
    
    _scrollView_data.contentSize = CGSizeMake(1420, 666);
}

- (void)viewDidUnload
{
    [self setScrollView_data:nil];
    [self setPersonTable:nil];
    [self setTmpCell:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if (interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        return YES;   
    }
    else {
        return NO;
    }
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//{
//    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation))
//        return YES;
//    
//    return NO;
//}

- (IBAction)tools:(id)sender {
    _toolsView = [[ToolsViewController alloc] initWithNibName:@"ToolsViewController" bundle:[NSBundle mainBundle]];
    [self.view.window setRootViewController:_toolsView];
}

- (void)dealloc {
    [_scrollView_data release];
    [_personTable release];
    [_tmpCell release];
    [_personList release];
    [_cellNib release];
    
    [super dealloc];
}

#pragma mark -
#pragma mark UITableView data source and delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_personList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *personID = @"personID";
    
    PersonCell *cell = (PersonCell *)[tableView dequeueReusableCellWithIdentifier:personID];
	
	if (cell == nil) {
        [self.cellNib instantiateWithOwner:self options:nil];
        cell = _tmpCell;
        self.tmpCell = nil;
	}
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:personID];
//    if (cell == nil)
//    {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:personID] autorelease];
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
	
	NSArray *pNode = [_personList objectAtIndex:indexPath.row];
    
//    cell.textLabel.text = [pNode objectAtIndex:0];
//    cell.detailTextLabel.text = [pNode objectAtIndex:1];
    
    cell.houseDesc = [pNode objectAtIndex:0];
    cell.clientName = [pNode objectAtIndex:1];
    cell.orderTime = [pNode objectAtIndex:2];
    cell.contractTime = [pNode objectAtIndex:3];
    cell.contractNo = [pNode objectAtIndex:4];
    cell.buildingArea = [pNode objectAtIndex:5];
    cell.contractTotalPrice = [pNode objectAtIndex:6];
    cell.payMethod = [pNode objectAtIndex:7];
    cell.backPay = [pNode objectAtIndex:8];
    cell.unbackPay = [pNode objectAtIndex:9];
    cell.handTime = [pNode objectAtIndex:10];
    cell.radix = [pNode objectAtIndex:11];
    cell.proportion = [pNode objectAtIndex:12];
    cell.quotiety = [pNode objectAtIndex:13];
    cell.haveMoney = [pNode objectAtIndex:14];
    cell.leaveMoney = [pNode objectAtIndex:15];
    cell.snStr = [pNode objectAtIndex:16];
    
	return cell;
}

@end
