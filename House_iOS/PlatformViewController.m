//
//  PlatformViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-11-28.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "PlatformViewController.h"

#import "OudsAppDelegate.h"

#import "RedirectViewController.h"

#import "ProjectViewController.h"
#import "HouseListViewController.h"
#import "SaleInfoViewController.h"
#import "MarketViewController.h"

#import "CustomerInfoViewController.h"
#import "CustomerGroupViewController.h"
//#import "CustomerIssuedViewController.h"

#import "ProjPhotosViewController.h"
#import "ToolsViewController.h"
#import "ConfigViewController.h"

#import "ASIHTTPRequest.h"
#import "XMLParser.h"
#import "NodeData.h"
#import "COMMON.h"
#import "Photo.h"
#import "Customer.h"

@implementation PlatformViewController

@synthesize sysTable = _sysTable;
@synthesize sysList = _sysList;
@synthesize rcvTable = _rcvTable;
@synthesize rcvList = _rcvList;

@synthesize myStateV = _myStateV;
@synthesize sysNtcV = _sysNtcV;
@synthesize reNtcV = _reNtcV;

@synthesize projectTablePopoverController = _projectTablePopoverController;
@synthesize tabBarController = _tabBarController;

@synthesize projPhotosView = _projPhotosView;
@synthesize toolsView = _toolsView;
@synthesize configView = _configView;
@synthesize curDay = _curDay;

@synthesize username = _username;
@synthesize phoneCustomers = _phoneCustomers;
@synthesize visitCustomers = _visitCustomers;
@synthesize customers = _customers;
@synthesize issueCustomers = _issueCustomers;
@synthesize bizCount = _bizCount;
@synthesize bizArea = _bizArea;
@synthesize projectName = _projectName;

static PlatformViewController *sharedInstance = nil;

+ (PlatformViewController *) sharedInstance
{
    if(!sharedInstance) {
        sharedInstance = [[self alloc] init];
        // [[PlatformViewController alloc] initWithNibName:@"PlatformViewController" bundle:[NSBundle mainBundle]];
    }
    
    return sharedInstance;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"工作平台";
        self.tabBarItem.image = [UIImage imageNamed:@"icon2.png"];
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
    
    [_myStateV setHidden:NO];
    
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    [_username setText:[oad USERNAME]];
    
    NSString *currentProjID = [oad PROJ_ID];
    if (!(nil == currentProjID || [@"" isEqualToString:currentProjID])) {
        [_projectName setTitle:[oad PROJ_NAME] forState:UIControlStateNormal];
        
        [self myStat:nil];
    }
    
    COMMON *comm = [COMMON sharedInstance];
    [_curDay setText:[comm curDay]];
    
    [_sysTable setTag:250];
    [_rcvTable setTag:251];
}

- (void)viewDidUnload
{
    [self setUsername:nil];
    [self setPhoneCustomers:nil];
    [self setVisitCustomers:nil];
    [self setCustomers:nil];
    [self setIssueCustomers:nil];
    [self setBizCount:nil];
    [self setBizArea:nil];
    [self setProjectName:nil];
    [self setCurDay:nil];
    [self setMyStateV:nil];
    [self setSysNtcV:nil];
    [self setReNtcV:nil];
    [self setSysTable:nil];
    [self setRcvTable:nil];
    
    [self setSysList:nil];
    [self setRcvList:nil];
    
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

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//    return YES;
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [_username release];
    [_phoneCustomers release];
    [_visitCustomers release];
    [_customers release];
    [_issueCustomers release];
    [_bizCount release];
    [_bizArea release];
    [_projectTablePopoverController release];

    [_projectName release];
    [_curDay release];
    [_myStateV release];
    [_sysNtcV release];
    [_reNtcV release];
    [_sysTable release];
    [_rcvTable release];
    
    [_sysList release];
    [_rcvList release];
    
    [super dealloc];
}

- (IBAction)exit:(id)sender {
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    [av initWithTitle:@"退出提示" message:@"确定退出销售辅助系统？\n" delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"back", nil), @"退出", nil];
    [av show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        OudsAppDelegate *oad = [[UIApplication sharedApplication] delegate];
        [oad setIsLogin:NO];
        
        exit(0);
    }   
}

/**
 * 设置模块
 */
- (IBAction)config:(id)sender {
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    // 判断当前是否在项目中
    if (nil == [oad PROJ_ID] || [@"" isEqualToString:[oad PROJ_ID]]) {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"proj_select", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    else {
        // 跳转到工作平台界面
        _configView = [[ConfigViewController alloc] init];
//        [self.view addSubview:_configView.view];
        [self.view.window setRootViewController:_configView];
    }
}

/**
 * 房源模块
 */
- (IBAction)house:(id)sender {
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    // 判断当前是否在项目中
    if (nil == [oad PROJ_ID] || [@"" isEqualToString:[oad PROJ_ID]]) {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"proj_select", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    else {
        UIViewController *redirectView = [[[RedirectViewController alloc] init] autorelease];
        UIViewController *projectView = [[[ProjectViewController alloc] initWithNibName:@"ProjectViewController" bundle:nil] autorelease];
        UIViewController *houseListView = [[[HouseListViewController alloc] initWithNibName:@"HouseListViewController" bundle:nil] autorelease];
        UIViewController *saleInfoView = [[[SaleInfoViewController alloc] initWithNibName:@"SaleInfoViewController" bundle:nil] autorelease];
        UIViewController *marketView = [[[MarketViewController alloc] initWithNibName:@"MarketViewController" bundle:nil] autorelease];
        
        //设置房源卡片
        _tabBarController = [[[UITabBarController alloc] init] autorelease];
        
        _tabBarController.viewControllers = [NSArray arrayWithObjects:redirectView, projectView, houseListView, saleInfoView, marketView, nil];
        
        if ([@"houses" isEqualToString:sender]) {
            [_tabBarController setSelectedIndex:2];
        }
        else if ([@"market" isEqualToString:sender]) {
            [_tabBarController setSelectedIndex:4];
        }
        else {
            [_tabBarController setSelectedIndex:1];
        }
        
        COMMON *comm = [COMMON sharedInstance];
        [comm def_tbf:[_tabBarController tabBar]];
        
        [oad.window setRootViewController:_tabBarController];
        [oad.window makeKeyAndVisible];
    }
}

/**
 * 客户模块
 */
- (IBAction)customer:(id)sender {
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    // 判断当前是否在项目中
    if (nil == [oad PROJ_ID] || [@"" isEqualToString:[oad PROJ_ID]]) {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"proj_select", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    else {
        UIViewController *redirectView = [[[RedirectViewController alloc] init] autorelease];
        CustomerInfoViewController *customerInfoView = [[[CustomerInfoViewController alloc] initWithNibName:@"CustomerInfoViewController" bundle:nil] autorelease];
        CustomerGroupViewController *customerGroupView = [[[CustomerGroupViewController alloc] initWithNibName:@"CustomerGroupViewController" bundle:nil] autorelease];
        UIViewController *customerIssuedView = [[[CustomerInfoViewController alloc] initWithNibName:@"CustomerInfoViewController" bundle:nil] autorelease];
        
        [customerInfoView setTitle:@"客户信息"];
        customerGroupView.delegate = customerInfoView;
        [customerIssuedView setTitle:@"重点客户"];
        
        // 设置客户卡片
        _tabBarController = [[[UITabBarController alloc] init] autorelease];
        
        _tabBarController.viewControllers = [NSArray arrayWithObjects:redirectView, customerInfoView, customerGroupView, customerIssuedView, nil];
        
        if ([@"issue" isEqualToString:sender]) {
            [_tabBarController setSelectedIndex:3];
        }
        else {
            [_tabBarController setSelectedIndex:1];
        }
        
        COMMON *comm = [COMMON sharedInstance];
        [comm def_tbf:[_tabBarController tabBar]];
        
        [oad.window setRootViewController:_tabBarController];
        [oad.window makeKeyAndVisible];
    }
}

/**
 * 工具模块
 */
- (IBAction)tools:(id)sender {
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    // 判断当前是否在项目中
    if (nil == [oad PROJ_ID] || [@"" isEqualToString:[oad PROJ_ID]]) {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"proj_select", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    else {
        // 跳转到工作平台界面
        _toolsView = [[ToolsViewController alloc] init];
//        [self.view addSubview:_toolsView.view];
        [self.view.window setRootViewController:_toolsView];
    }
}

/**
 * 图片模块
 */
- (IBAction)projPhotos:(id)sender {
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    // 判断当前是否在项目中
    if (nil == [oad PROJ_ID] || [@"" isEqualToString:[oad PROJ_ID]]) {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"proj_select", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    else {
        Photo *pht = [Photo sharedInstance];
        
        [pht setIsB:@"1"];
        [pht setName:[[oad PROJ_NAME] stringByAppendingString:@"项目楼书"]];
        [pht setPath:[NSString stringWithFormat:@"%@%@%@%@", [oad SERVER], @"/security/project/getProjectHousePic/", [oad SID_PROJ], @"&type=0&src="]];
        
        NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
        urlStr = [urlStr stringByAppendingString:@"/security/project/getSrcList/"];
        urlStr = [urlStr stringByAppendingString:[oad SID]];
        urlStr = [urlStr stringByAppendingString:[@"?projectUuid=" stringByAppendingString:[oad PROJ_ID]]];
        urlStr = [urlStr stringByAppendingString:@"&type=0"];
        NSLog(@"%@", urlStr);
        
        NSURL *url = [NSURL URLWithString:urlStr];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        
        [request startSynchronous];
        NSError *error = [request error];
        // 网络连接成功
        if (!error) {
            NSData *statData = [request responseData];
            XMLParser *xmlParser = [XMLParser sharedInstance];
            NSMutableArray *customerNodes = [[xmlParser parseXMLFromData:statData] objectsForKey:@"BEAN"];
            
            NSMutableArray *tmpArr = [[NSMutableArray alloc] init];
            for (NodeData *cstNode in customerNodes) {
                if ([cstNode leafForKey:@"src"] && ![@"" isEqualToString:[cstNode leafForKey:@"src"]]) {
                    [tmpArr addObject:[cstNode leafForKey:@"src"]];
                }
            }
            
            [pht setPArr:[NSMutableArray arrayWithArray:tmpArr]];
            [tmpArr release];
            
            if ([[pht pArr] count] > 0) {
                // 跳转到工作平台界面
                _projPhotosView = [[ProjPhotosViewController alloc] initWithNibName:@"ProjPhotosViewController" bundle:[NSBundle mainBundle]];
                
                [self.view addSubview:_projPhotosView.view];
                
                //        [av initWithTitle:NSLocalizedString(@"data_info", nil) message:NSLocalizedString(@"empty_data", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
                //        [av show];
            }
            else {
                [av initWithTitle:NSLocalizedString(@"data_info", nil) message:@"当前楼书为空，请先上传内容！\n" delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
                [av show];
            }
        }
        else {
            [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
            [av show];
        }
    }
}

#pragma mark - Project Table View Controller

- (void)projectTableViewControllerDidFinish:(ProjectTableViewController *)controller
{
    [self.projectTablePopoverController dismissPopoverAnimated:YES];
}

- (void)setProj:(NSString *)title
{
    [_projectName setTitle:title forState:UIControlStateNormal];
    [self myStat:nil];
}

- (IBAction)setProject:(id)sender {
//    if (!self.projectTablePopoverController) {
        ProjectTableViewController *projectTableView = [[[ProjectTableViewController alloc] initWithNibName:@"ProjectTableViewController" bundle:nil] autorelease];
        projectTableView.delegate = self;
        
        self.projectTablePopoverController = [[[UIPopoverController alloc] initWithContentViewController:projectTableView] autorelease];
//    }
    
//    if ([self.projectTablePopoverController isPopoverVisible]) {
        [self.projectTablePopoverController dismissPopoverAnimated:YES];
//    }
//    else {        
        [self.projectTablePopoverController presentPopoverFromRect:_projectName.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//    }
}

- (IBAction)myStat:(id)sender {
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    
    // 判断当前是否在项目中
    NSString *currentProject = [oad PROJ_ID];
    if (nil == currentProject || [@"" isEqualToString:currentProject]) {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"proj_select", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    else {
        NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
        urlStr = [urlStr stringByAppendingString:@"/security/client/getMyReport/"];
        urlStr = [urlStr stringByAppendingString:[oad SID]];
        urlStr = [urlStr stringByAppendingString:[@"?sellerUuid=" stringByAppendingString:[oad USER_ID]]];
        urlStr = [urlStr stringByAppendingString:[@"&projectUuid=" stringByAppendingString:currentProject]];
        NSLog(@"%@", urlStr);
        
        NSURL *url = [NSURL URLWithString:urlStr];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        
        [request startSynchronous];
        NSError *error = [request error];
        // 网络连接成功
        if (!error) {
            NSData *statData = [request responseData];
            XMLParser *xmlParser = [XMLParser sharedInstance];
            NodeData *statNode = [xmlParser parseXMLFromData:statData];
            
            [_phoneCustomers setText:[[statNode leafForKey:@"callCount"] stringByAppendingString:@"位"]];
            [_visitCustomers setText:[[statNode leafForKey:@"visitCount"] stringByAppendingString:@"位"]];
            [_customers setText:[[statNode leafForKey:@"oldClientCount"] stringByAppendingString:@"位"]];
            [_issueCustomers setText:[[statNode leafForKey:@"attentionCount"] stringByAppendingString:@"位"]];
            [_bizCount setText:[[statNode leafForKey:@"bargainCount"] stringByAppendingString:@"套"]];
            [_bizArea setText:[[NSString stringWithFormat:@"%.2f", [[statNode leafForKey:@"bargainAreaCount"] floatValue]] stringByAppendingString:@"平方米"]];
            
            [self ycView];
            [_myStateV setHidden:NO];
        }
        else {
            [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
            [av show];
        }
    }
}

- (IBAction)sysNotice:(id)sender {
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    // 判断当前是否在项目中
    if (nil == [oad PROJ_ID] || [@"" isEqualToString:[oad PROJ_ID]]) {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"proj_select", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    else {
        NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
        urlStr = [urlStr stringByAppendingString:@"/security/client/getMyNotice/"];
        urlStr = [urlStr stringByAppendingString:[oad SID]];
        urlStr = [urlStr stringByAppendingString:[@"?sellerUuid=" stringByAppendingString:[oad USER_ID]]];
        urlStr = [urlStr stringByAppendingString:[@"&projectUuid=" stringByAppendingString:[oad PROJ_ID]]];
        urlStr = [urlStr stringByAppendingString:@"&state=1&sort=time&dir=desc"];
        NSLog(@"%@", urlStr);
        
        NSURL *url = [NSURL URLWithString:urlStr];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        
        [request startSynchronous];
        NSError *error = [request error];
        // 网络连接成功
        if (!error) {
            NSData *statData = [request responseData];
            XMLParser *xmlParser = [XMLParser sharedInstance];
            NSMutableArray *customerNodes = [[xmlParser parseXMLFromData:statData] objectsForKey:@"BEAN"];
            
            if ([customerNodes count] > 0) {
                _sysList = [[NSMutableArray alloc] initWithCapacity:[customerNodes count]];
                for (NodeData *cstNode in customerNodes) {
                    NSString *sStr;
                    if ([@"0" isEqualToString:[cstNode leafForKey:@"state"]]) {
                        sStr = [NSString stringWithString:@"（已读）"];
                    }
                    else {
                        sStr = [NSString stringWithString:@"（未读）"];
                    }
                    
                    NSString *sDtl;
                    if ([cstNode leafForKey:@"detail"]) {
                        sDtl = [NSString stringWithString:[cstNode leafForKey:@"detail"]];
                    }
                    else {
                        sDtl = [NSString stringWithString:@"无内容！"];
                    }
                    
                    [_sysList addObject:[NSArray arrayWithObjects:sStr, [cstNode leafForKey:@"time"], [cstNode leafForKey:@"title"], sDtl, [cstNode leafForKey:@"id"], nil]];
                    
                    [sStr release];
                    [sDtl release];
                }
                
                [_sysTable reloadData];
                [self ycView];
                [_sysNtcV setHidden:NO];
            }
            else {
                [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:@"无数据！\n" delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
                [av show];
            }
        }
        else {
            [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
            [av show];
        }
    }
}

- (IBAction)revisitMind:(id)sender {
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    // 判断当前是否在项目中
    if (nil == [oad PROJ_ID] || [@"" isEqualToString:[oad PROJ_ID]]) {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"proj_select", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    else {
        NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
        urlStr = [urlStr stringByAppendingString:@"/security/client/getMyVisitNotice/"];
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
            NSData *statData = [request responseData];
            XMLParser *xmlParser = [XMLParser sharedInstance];
            NSMutableArray *customerNodes = [[xmlParser parseXMLFromData:statData] objectsForKey:@"BEAN"];
            
            if ([customerNodes count] > 0) {
                _rcvList = [[NSMutableArray alloc] initWithCapacity:[customerNodes count]];
                for (NodeData *cstNode in customerNodes) {
                    NSString *sDtl;
                    if ([cstNode leafForKey:@"detail"]) {
                        sDtl = [NSString stringWithString:[cstNode leafForKey:@"detail"]];
                    }
                    else {
                        sDtl = [NSString stringWithString:@"无内容！"];
                    }
                    
                    [_rcvList addObject:[Customer initWithID:[cstNode leafForKey:@"clientUuid"] Name:@"" phone:sDtl UpdateTime:[cstNode leafForKey:@"updateTime"] Type:[cstNode leafForKey:@"title"]]];
                    
                    [sDtl release];
                }
                
                [_rcvTable reloadData];
                [self ycView];
                [_reNtcV setHidden:NO];
            }
            else {
                [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:@"无数据！\n" delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
                [av show];
            }
        }
        else {
            [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
            [av show];
        }
    }
}

- (void)ycView
{
    [_myStateV setHidden:YES];
    [_sysNtcV setHidden:YES];
    [_reNtcV setHidden:YES];
}

#pragma mark -
#pragma mark UITableView data source and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int tabCount = 0;
    switch ([tableView tag]) {
        case 250:
            tabCount = [_sysList count];
            
            break;
        case 251:
            tabCount = [_rcvList count];
            
            break;
    }
    
    return tabCount; 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    switch ([tableView tag]) {
        case 250:{
            static NSString *sysID = @"sysID";
            
            cell = [tableView dequeueReusableCellWithIdentifier:sysID];
            if (cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:sysID] autorelease];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            NSArray *sArr = [_sysList objectAtIndex:indexPath.row];
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ - %@", [sArr objectAtIndex:0], [sArr objectAtIndex:1], [sArr objectAtIndex:2]];
            cell.detailTextLabel.text = [sArr objectAtIndex:3];
            
            [cell.textLabel setFont:[UIFont systemFontOfSize:17]];
            [cell.detailTextLabel setTextColor:[UIColor darkTextColor]];
            
            break;
        }
        case 251:{
            static NSString *rcvID = @"rcvID";
            
            cell = [tableView dequeueReusableCellWithIdentifier:rcvID];
            if (cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:rcvID] autorelease];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            Customer *cstm = [_sysList objectAtIndex:indexPath.row];
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ - %@", [cstm name], [cstm updateTime], [cstm type]];
            cell.detailTextLabel.text = [cstm phone];
            
            [cell.textLabel setFont:[UIFont systemFontOfSize:17]];
            [cell.detailTextLabel setTextColor:[UIColor darkTextColor]];
            
            break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([tableView tag]) {
        case 250:{
            NSArray *sArr = [_sysList objectAtIndex:indexPath.row];
            UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
            OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];

            NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
            urlStr = [urlStr stringByAppendingString:@"/security/client/getMyNotice/"];
            urlStr = [urlStr stringByAppendingString:[oad SID]];
            urlStr = [urlStr stringByAppendingString:[@"?sellerUuid=" stringByAppendingString:[oad USER_ID]]];
            urlStr = [urlStr stringByAppendingString:[@"&projectUuid=" stringByAppendingString:[oad PROJ_ID]]];
            urlStr = [urlStr stringByAppendingFormat:@"&id=%@&isRead=0", [sArr objectAtIndex:4]];
            NSLog(@"%@", urlStr);
            
            NSURL *url = [NSURL URLWithString:urlStr];
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            
            [request startSynchronous];
            NSError *error = [request error];
            // 网络连接成功
            if (!error) {
                [_sysList removeObjectAtIndex:indexPath.row];
                [_sysTable reloadData];
                
                if ([_sysList count] <= 0) {
                    [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:@"无数据！\n" delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
                    [av show];
                } 
            }
            else {
                [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
                [av show];
            }
            
            break;
        }
        case 251:{
            break;   
        }
    }
}

@end
