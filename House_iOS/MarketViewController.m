//
//  MarketViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-11-29.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "MarketViewController.h"

#import "OudsAppDelegate.h"
#import "XMLParser.h"
#import "NodeData.h"
#import "Market.h"
#import "ASIHTTPRequest.h"

#import "RedirectViewController.h"
#import "Redirect2MarketViewController.h"
#import "MarketBasicViewController.h"
#import "MarketFeatureViewController.h"
#import "MarketSysViewController.h"

#import "COMMON.h"

@implementation MarketViewController

@synthesize marketList = _marketList;
@synthesize marketTabBarController = _marketTabBarController;

//@synthesize market = _market;
static Market *market;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"市场分析";
        //self.tabBarItem.image = [UIImage imageNamed:@"tab_market.png"];
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
    urlStr = [urlStr stringByAppendingString:@"/security/rival/getRivalList/"];
    urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
    NSLog(@"%@", urlStr);

    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];

    [request startSynchronous];
    NSError *error = [request error];
    // 网络连接成功
    if (!error) {
        NSData *marketData = [request responseData];
        XMLParser *xmlParser = [XMLParser sharedInstance];
        NSMutableArray *marketNodes = [[xmlParser parseXMLFromData:marketData] objectsForKey:@"BEAN"];
        _marketList = [[NSMutableArray alloc] initWithCapacity:[marketNodes count]];
        for (NodeData *marketNode in marketNodes) {
            
            NSString *developer;
            if (![marketNode leafForKey:@"developer"]) {
                developer = [NSString stringWithString:@""];
            }
            else {
                developer = [NSString stringWithString:[marketNode leafForKey:@"developer"]];
            }
            
            NSString *address;
            if (![marketNode leafForKey:@"address"]) {
                address = [NSString stringWithString:@""];
            }
            else {
                address = [NSString stringWithString:[marketNode leafForKey:@"address"]];
            }
            
            [_marketList addObject:[Market initWithID:[marketNode leafForKey:@"id"] Name:[marketNode leafForKey:@"name"] Address:address Developer:developer]];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_marketList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *marketID = @"marketID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:marketID];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:marketID] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	market = [_marketList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [@"项目名称：" stringByAppendingString:[market name]];
    cell.detailTextLabel.text = [[[[@"项目地址：" stringByAppendingString:[market address]] stringByAppendingString:@"      "] stringByAppendingString:@"开发商："] stringByAppendingString:[market developer]];
    cell.detailTextLabel.textColor = [UIColor blueColor];
    
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    market = [Market sharedInstance];
    
    [market setMkID:[[_marketList objectAtIndex:indexPath.row] mkID]];
    [market setName:[[_marketList objectAtIndex:indexPath.row] name]];

    UIViewController *redirectView = [[[RedirectViewController alloc] init] autorelease];
    UIViewController *redirect2MarketView = [[[Redirect2MarketViewController alloc] init] autorelease];
    UIViewController *marketBasicView = [[[MarketBasicViewController alloc] initWithNibName:@"MarketBasicViewController" bundle:nil] autorelease];
    UIViewController *marketFeatureView = [[[MarketFeatureViewController alloc] initWithNibName:@"MarketFeatureViewController" bundle:nil] autorelease];
    UIViewController *marketSysView = [[[MarketSysViewController alloc] initWithNibName:@"MarketSysViewController" bundle:nil] autorelease];
    
    // 设置客户卡片
    _marketTabBarController = [[[UITabBarController alloc] init] autorelease];
    
    _marketTabBarController.viewControllers = [NSArray arrayWithObjects:redirectView, redirect2MarketView, marketBasicView, marketFeatureView, marketSysView, nil];
    [_marketTabBarController setSelectedIndex:2];
    
    COMMON *comm = [COMMON sharedInstance];
    [comm def_tbf:[_marketTabBarController tabBar]];
    
    OudsAppDelegate *oad = [[UIApplication sharedApplication] delegate]; 
    [oad.window setRootViewController:_marketTabBarController];
    [oad.window makeKeyAndVisible];
}

@end
