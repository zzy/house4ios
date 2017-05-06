//
//  ServiceInfoViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-11.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import "ServiceInfoViewController.h"
#import "Server.h"

#import "OudsAppDelegate.h"
#import "XMLParser.h"
#import "NodeData.h"
#import "StateC.h"

#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

#import <QuartzCore/QuartzCore.h>

@implementation ServiceInfoViewController

@synthesize gjsj = _gjsj;
@synthesize qygj = _qygj;
@synthesize zxqk = _zxqk;
@synthesize tshz = _tshz;
@synthesize khzj = _khzj;
@synthesize zyqk = _zyqk;
@synthesize qtqk = _qtqk;

@synthesize sheetFormView = _sheetFormView;

@synthesize stateTable = _stateTable;
@synthesize stateList = _stateList;
@synthesize tmpCell = _tmpCell;
@synthesize cellNib = _cellNib;

@synthesize houseDesc = _houseDesc;
@synthesize orderTime = _orderTime;
@synthesize payMethod = _payMethod;
@synthesize buildingArea = _buildingArea;
@synthesize orderTotalPrice = _orderTotalPrice;
@synthesize contractSignDesc = _contractSignDesc;
@synthesize contentView = _contentView;

static NSString *sID;
static NSString *stID;

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
    
    [[_gjsj layer] setBorderWidth:1.0];
    [[_gjsj layer] setBorderColor:[[UIColor blueColor] CGColor]];
    
    [[_qygj layer] setBorderWidth:1.0];
    [[_qygj layer] setBorderColor:[[UIColor blueColor] CGColor]];
    
    [[_zxqk layer] setBorderWidth:1.0];
    [[_zxqk layer] setBorderColor:[[UIColor blueColor] CGColor]];
    
    [[_tshz layer] setBorderWidth:1.0];
    [[_tshz layer] setBorderColor:[[UIColor blueColor] CGColor]];
    
    [[_khzj layer] setBorderWidth:1.0];
    [[_khzj layer] setBorderColor:[[UIColor blueColor] CGColor]];
    
    [[_zyqk layer] setBorderWidth:1.0];
    [[_zyqk layer] setBorderColor:[[UIColor blueColor] CGColor]];
    
    [[_qtqk layer] setBorderWidth:1.0];
    [[_qtqk layer] setBorderColor:[[UIColor blueColor] CGColor]];
    
    Server *serv = [Server sharedInstance];
    
//    [sID release];
    sID = [NSString stringWithString:[serv sID]];
    
    [_houseDesc setText:[serv houseDesc]];
    [_orderTime setText:[serv orderTime]];
    [_payMethod setText:[serv payMethod]];
    [_buildingArea setText:[serv buildingArea]];
    [_orderTotalPrice setText:[serv orderTotalPrice]];
    [_contractSignDesc setText:[serv contractSignDesc]];
    
    self.stateTable.rowHeight = 40.0;
    self.cellNib = [UINib nibWithNibName:@"IndivideualBasedStateCell2" bundle:nil];
    
    // 获取楼栋列表数据
    [self setStateInfo];
}

- (void)setStateInfo
{
    //获取项目信息数据
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
    urlStr = [urlStr stringByAppendingString:@"/security/sell/getSheetTrackList/"];
    urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
    urlStr = [urlStr stringByAppendingString:[@"&sellerUuid=" stringByAppendingString:[oad USER_ID]]];
    //    urlStr = [urlStr stringByAppendingString:[@"&clientUuid=" stringByAppendingString:[serv clientUuid]]];
    urlStr = [urlStr stringByAppendingString:[@"&sheetUuid=" stringByAppendingString:sID]];
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
        
        _stateList = [[NSMutableArray alloc] initWithCapacity:[customerNodes count]];
        for (NodeData *cstNode in customerNodes) {
            if (cstNode && [cstNode leafForKey:@"id"] && [cstNode leafForKey:@"time"]) {
                NSString *updateTime = [[[NSString alloc] initWithString:[cstNode leafForKey:@"time"]] autorelease];
                if (10 <= [updateTime length]) {
                    updateTime = [updateTime substringToIndex:10];
                }
                
                [_stateList addObject:[NSArray arrayWithObjects:[cstNode leafForKey:@"sign"], updateTime, [cstNode leafForKey:@"client"], [cstNode leafForKey:@"colleague"], [cstNode leafForKey:@"descp"], [cstNode leafForKey:@"elseCircs"], [cstNode leafForKey:@"importantItems"], [cstNode leafForKey:@"id"], nil]];
            }
        }
        
        [_stateTable reloadData];
    }
    else {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
}

- (void)viewDidUnload
{
    [self setHouseDesc:nil];
    [self setOrderTime:nil];
    [self setPayMethod:nil];
    [self setBuildingArea:nil];
    [self setOrderTotalPrice:nil];
    [self setContractSignDesc:nil];
    [self setContentView:nil];
    [self setStateTable:nil];
    [self setTmpCell:nil];
    [self setGjsj:nil];
    [self setZxqk:nil];
    [self setTshz:nil];
    [self setKhzj:nil];
    [self setZyqk:nil];
    [self setQtqk:nil];
    [self setQygj:nil];
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
    [_houseDesc release];
    [_orderTime release];
    [_payMethod release];
    [_buildingArea release];
    [_orderTotalPrice release];
    [_contractSignDesc release];
    [_contentView release];
    [_stateTable release];
    [_tmpCell release];
    [_gjsj release];
    [_zxqk release];
    [_tshz release];
    [_khzj release];
    [_zyqk release];
    [_qtqk release];
    [_qygj release];
    [super dealloc];
}
- (IBAction)closeMe:(id)sender {
    [self.view removeFromSuperview];
}

- (IBAction)addState:(id)sender {
//    if (sID) {
    _sheetFormView = [[SheetFormViewController alloc] initWithNibName:@"SheetFormViewController" bundle:[NSBundle mainBundle]];
    [_sheetFormView setDelegate:self];
    
    [self.view addSubview:_sheetFormView.view];
//    }
//    else {
//        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
//        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"请先指定客户！\n", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
//        [av show];
//    }
}

- (IBAction)delState:(id)sender {
    //获取项目信息数据
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    if (stID) {
        OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
        
        NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
        urlStr = [urlStr stringByAppendingString:@"/security/sell/delSheetTrack/"];
        urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
//        urlStr = [urlStr stringByAppendingString:[@"&sellerUuid=" stringByAppendingString:[oad USER_ID]]];
        //    urlStr = [urlStr stringByAppendingString:[@"&clientUuid=" stringByAppendingString:[serv clientUuid]]];
//        urlStr = [urlStr stringByAppendingString:[@"&sheetUuid=" stringByAppendingString:sID]];
        NSLog(@"%@", urlStr);
        
        NSURL *url = [NSURL URLWithString:urlStr];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        
        [request setPostValue:stID forKey:@"id"];
        
        [request startSynchronous];
        NSError *error = [request error];
        // 网络连接成功
        if (!error) {
            [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"成功删除！\n", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
            [av show];
            
            stID = nil;
            
            [self setStateInfo];
        }
        else {
            [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
            [av show];
        }
    }
    else {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"请先选择删除项！\n", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
}

#pragma mark -
#pragma mark UITableView data source and delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_stateList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *stateID = @"stateID";
    
    StateC *cell = (StateC *)[tableView dequeueReusableCellWithIdentifier:stateID];
	
	if (cell == nil) {
        [self.cellNib instantiateWithOwner:self options:nil];
        cell = _tmpCell;
        self.tmpCell = nil;
	}
	
	NSArray *sArr = [_stateList objectAtIndex:indexPath.row];
    
    cell.sign = [sArr objectAtIndex:0];
    cell.time = [sArr objectAtIndex:1];
    cell.client = [sArr objectAtIndex:2];
    cell.colleague = [sArr objectAtIndex:3];
    cell.desc = [sArr objectAtIndex:4];
    cell.elseCircs = [sArr objectAtIndex:5];
    cell.importantItems = [sArr objectAtIndex:6];
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSArray *sArr = [_stateList objectAtIndex:indexPath.row];
    
//    if (stID) {
//        [stID release];
//    }
    stID = [NSString stringWithString:[sArr objectAtIndex:7]];
}

@end
