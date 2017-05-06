//
//  ProjectViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-11-29.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "ProjectViewController.h"

#import "OudsAppDelegate.h"
#import "PlatformViewController.h"

#import "XMLParser.h"
#import "NodeData.h"
#import "ASIHTTPRequest.h"
#import "Building.h"

#import "Photo.h"
#import "ShowPmtViewController.h"

@implementation ProjectViewController

@synthesize zzBtn = _zzBtn;
@synthesize spBtn = _spBtn;
@synthesize ckBtn = _ckBtn;

@synthesize projName = _projName;
@synthesize projAddr = _projAddr;
@synthesize area = _area;
@synthesize totalArea = _totalArea;
@synthesize cubage = _cubage;
@synthesize floorDesc = _floorDesc;
@synthesize carParking = _carParking;
@synthesize areaBetween = _areaBetween;
@synthesize density = _density;
@synthesize greenbelt = _greenbelt;
@synthesize houseCount = _houseCount;
@synthesize carBili = _carBili;
@synthesize buildingTable = _buildingTable;
@synthesize switchButton = _switchButton;
@synthesize buildingList = _buildingList;
@synthesize tmpCell = _tmpCell;
//@synthesize platformView = _platformView;
@synthesize showPmtView = _showPmtView;
@synthesize cellNib = _cellNib;

//static int useType = 0;
static int state = 0;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"项目信息";
        //self.tabBarItem.image = [UIImage imageNamed:@"tab_projct.png"];
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
    
    //获取项目信息数据
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
    urlStr = [urlStr stringByAppendingString:@"/security/project/getProjectList/"];
    urlStr = [urlStr stringByAppendingString:[oad SID]];
    urlStr = [urlStr stringByAppendingString:[@"?id=" stringByAppendingString:[oad PROJ_ID]]];
    NSLog(@"%@", urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request startSynchronous];
    NSError *error = [request error];
    // 网络连接成功
    if (!error) {
        NSData *projData = [request responseData];
        XMLParser *xmlParser = [XMLParser sharedInstance];
        NodeData *projNode = [[xmlParser parseXMLFromData:projData] objectForKey:@"BEAN"];
        
        [_projName setText:[projNode leafForKey:@"name"]];
        [_projAddr setText:[projNode leafForKey:@"address"]];
        [_area setText:[projNode leafForKey:@"useTotalArea"]];
        [_totalArea setText:[projNode leafForKey:@"totalArea"]];
        [_cubage setText:[projNode leafForKey:@"cubage"]];
        [_floorDesc setText:[projNode leafForKey:@"jiTotalArea"]];
        [_carParking setText:[projNode leafForKey:@"carParking"]];
        [_areaBetween setText:[projNode leafForKey:@"buildingTotalArea"]];
        [_density setText:[projNode leafForKey:@"density"]];
        [_greenbelt setText:[projNode leafForKey:@"greenbelt"]];
        [_houseCount setText:[projNode leafForKey:@"houseCount"]];
        [_carBili setText:[projNode leafForKey:@"area"]];
    }
    else {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    
    // 获取楼栋列表数据
    self.buildingTable.rowHeight = 62.0;
    self.cellNib = [UINib nibWithNibName:@"IndividualBasedBuildingCell" bundle:nil];
    [self byZZ:nil];
}

- (void)viewDidUnload
{
    [self setProjName:nil];
    [self setProjAddr:nil];
    [self setArea:nil];
    [self setTotalArea:nil];
    [self setCubage:nil];
    [self setFloorDesc:nil];
    [self setCarParking:nil];
    [self setAreaBetween:nil];
    [self setDensity:nil];
    [self setGreenbelt:nil];
    [self setHouseCount:nil];
    [self setCarBili:nil];
    [self setSwitchButton:nil];
    [self setBuildingTable:nil];
    [self setTmpCell:nil];
    [self setCellNib:nil];
    
    [self setZzBtn:nil];
    [self setSpBtn:nil];
    [self setCkBtn:nil];
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
    [_projName release];
    [_projAddr release];
    [_area release];
    [_totalArea release];
    [_cubage release];
    [_floorDesc release];
    [_carParking release];
    [_areaBetween release];
    [_density release];
    [_greenbelt release];
    [_houseCount release];
    [_carBili release];
    [_cellNib release];
    [_switchButton release];
    [_buildingTable release];
    [_tmpCell release];
    [_zzBtn release];
    [_spBtn release];
    [_ckBtn release];
    [super dealloc];
}

- (IBAction)planPic:(id)sender {
    //获取项目信息数据
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
    urlStr = [urlStr stringByAppendingString:@"/security/project/getProjectPic/"];
    urlStr = [urlStr stringByAppendingString:[oad SID]];
    urlStr = [urlStr stringByAppendingString:[@"?id=" stringByAppendingString:[oad PROJ_ID]]];
    NSLog(@"%@", urlStr);
    
    Photo *photo = [Photo sharedInstance];
    
    [photo setName:[[oad PROJ_NAME] stringByAppendingString:@"项目平面图"]];
    [photo setPath:urlStr];
    
    _showPmtView = [[ShowPmtViewController alloc] initWithNibName:@"ShowPmtViewController" bundle:[NSBundle mainBundle]];
    [self.view addSubview:_showPmtView.view];
}

- (IBAction)switchBuildings:(id)sender {
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    if ([oad SID] && [oad PROJ_ID] && 
        ![@"" isEqualToString:[oad SID]] && 
        ![@"" isEqualToString:[oad PROJ_ID]]) {
        // 房源切换按钮命名
        // 获取楼栋列表数据
        NSString *buttonText = [[_switchButton titleLabel] text];
        if ([buttonText isEqualToString:NSLocalizedString(@"all_buildings", nil)]) {
            [_switchButton setTitle:NSLocalizedString(@"sale_buildings", nil) forState:UIControlStateNormal];
            // 全部楼栋
            state = 0;
            [self buildingListByStateType];
        }
        else {
            [_switchButton setTitle:NSLocalizedString(@"all_buildings", nil) forState:UIControlStateNormal];
            // 正在销售楼栋
            state = 2;
            [self buildingListByStateType];
        }
        
        [_buildingTable reloadData];
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

// 楼栋列表刷新
- (void)buildingListByStateType
{
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
    urlStr = [urlStr stringByAppendingString:@"/security/project/getBuildingList/"];
    urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
    if (0 != state) {
        urlStr = [urlStr stringByAppendingFormat:@"&state=%i", state];
    }
    urlStr = [urlStr stringByAppendingFormat:@"&useType=%@", [oad BLD_TYPE]];
    urlStr = [urlStr stringByAppendingString:@"&sort=building_no&dir=ASC"];
    NSLog(@"%@", urlStr);

    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];

    [request startSynchronous];
    NSError *error = [request error];
    // 网络连接成功
    if (!error) {
        NSData *buildingData = [request responseData];
        XMLParser *xmlParser = [XMLParser sharedInstance];
        NSMutableArray *buildingNodes = [[xmlParser parseXMLFromData:buildingData] objectsForKey:@"BEAN"];
        _buildingList = [[NSMutableArray alloc] initWithCapacity:[buildingNodes count]];
        for (NodeData *buildingNode in buildingNodes) {
            
            [_buildingList addObject:[Building initWithNO:[buildingNode leafForKey:@"buildingNo"] hCount:[buildingNode leafForKey:@"houseCount"] sCount:[buildingNode leafForKey:@"sellingCount"] lic:[buildingNode leafForKey:@"licence"] state:[buildingNode leafForKey:@"state"] stateDesc:[buildingNode leafForKey:@"sellStateDesc"]]];
        }
        
    }
    else {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
//    }
}

- (void)reColor
{
    [_ckBtn setBackgroundColor:[UIColor clearColor]];
    [_spBtn setBackgroundColor:[UIColor clearColor]];
    [_zzBtn setBackgroundColor:[UIColor clearColor]];
}

- (IBAction)byZZ:(id)sender {
    [self reColor];
    [_zzBtn setBackgroundColor:[UIColor purpleColor]];
    
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    [oad setBLD_TYPE:[NSString stringWithString:@"0"]];
    [self buildingListByStateType];
    [_buildingTable reloadData];
}

- (IBAction)bySP:(id)sender {
    [self reColor];
    [_spBtn setBackgroundColor:[UIColor purpleColor]];
    
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    [oad setBLD_TYPE:[NSString stringWithString:@"1"]];
    [self buildingListByStateType];
    [_buildingTable reloadData];
}

- (IBAction)byCK:(id)sender {
    [self reColor];
    [_ckBtn setBackgroundColor:[UIColor purpleColor]];
    
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    [oad setBLD_TYPE:[NSString stringWithString:@"2"]];
    [self buildingListByStateType];
    [_buildingTable reloadData];
}

#pragma mark -
#pragma mark UITableView data source and delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_buildingList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *buildingID = @"buildingID";
    
    BuildingCell *cell = (BuildingCell *)[tableView dequeueReusableCellWithIdentifier:buildingID];
	
	if (cell == nil) {
        [self.cellNib instantiateWithOwner:self options:nil];
        cell = _tmpCell;
        self.tmpCell = nil;
	}
	
	Building *building = [_buildingList objectAtIndex:indexPath.row];
    
    cell.bNO = [building bNO];
    cell.houseCount = [building houseCount];
    cell.sellCount = [building sellCount];
    cell.licence = [building licence];
    cell.state = [building stateDesc];
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Building *building = [_buildingList objectAtIndex:indexPath.row];
    
//    if ([@"2" isEqualToString:[building state]]) {
        OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
        [oad setBLD:[building bNO]];
        
    //    _platformView = [PlatformViewController sharedInstance];
    //    _platformView = [[PlatformViewController alloc] initWithNibName:@"PlatformViewController" bundle:[NSBundle mainBundle]];
        PlatformViewController *platformView = [PlatformViewController sharedInstance];
        [platformView house:@"houses"];
//    }
//    else {
//        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
//        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:[[building stateDesc] stringByAppendingString:@"，禁止浏览！\n"] delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
//        [av show];
//    }
}

@end
