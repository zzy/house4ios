//
//  HouseListViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-11-29.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "HouseListViewController.h"

#import "OudsAppDelegate.h"
#import "HouseCell.h"
#import "XMLParser.h"
#import "ASIHTTPRequest.h"
#import "NodeData.h"

#import "Floor.h"
#import "House.h"
#import "CalculatorViewController.h"
#import "Photo.h"

#import "ProjPhotosViewController.h"
#import "Calculator.h"

@implementation HouseListViewController

@synthesize phtsView = _phtsView;
@synthesize calculatorView = _calculatorView;

@synthesize houseDesc = _houseDesc;
@synthesize attentioning = _attentioning;
@synthesize directType = _directType;
@synthesize stateDesc = _stateDesc;
@synthesize modelType = _modelType;
@synthesize buildingArea = _buildingArea;
@synthesize insideArea = _insideArea;
@synthesize unitPrice = _unitPrice;
@synthesize totalPrice = _totalPrice;
@synthesize publicArea = _publicArea;
@synthesize gardenPrice = _gardenPrice;
@synthesize gardenArea = _gardenArea;
@synthesize gardenArea2 = _gardenArea2;
@synthesize refreshBtn = _refreshBtn;

@synthesize floorTable = _floorTable;
@synthesize floorList = _floorList;
@synthesize tmpCell = _tmpCell;
@synthesize cellNib = _cellNib;

@synthesize label_notSale = _label_notSale;
@synthesize label_forSale = _label_forSale;
@synthesize label_inOrder = _label_inOrder;
@synthesize label_contracting = _label_contracting;
@synthesize label_contracted = _label_contracted;
@synthesize label_bNO = _label_bNO;

@synthesize crtUnit = _crtUnit;
@synthesize button_crtUnit = _button_crtUnit;
@synthesize button_crtHouse = _button_crtHouse;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"房源列表";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [_label_forSale setBackgroundColor:[UIColor greenColor]];
    [_label_contracting setBackgroundColor:[UIColor cyanColor]];
    [_label_contracted setBackgroundColor:[UIColor yellowColor]];
    [_label_notSale setBackgroundColor:[UIColor darkGrayColor]];
    [_label_inOrder setBackgroundColor:[UIColor purpleColor]];
    
    // 获取楼栋列表数据
    self.floorTable.rowHeight = 101.0;
    self.floorTable.separatorColor = [UIColor blueColor];
    self.cellNib = [UINib nibWithNibName:@"IndividualBasedHouseCell2" bundle:nil];
    
    //获取项目信息数据
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    
    if ([oad BLD] && ![@"" isEqualToString:[oad BLD]]) {
        [_label_bNO setText:[[oad BLD] stringByAppendingString:@"号楼"]];
        
        NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
        urlStr = [urlStr stringByAppendingString:@"/security/project/getUnitList/"];
        urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
        urlStr = [urlStr stringByAppendingString:[@"&buildingNo=" stringByAppendingString:[oad BLD]]];
        urlStr = [urlStr stringByAppendingString:[@"&useType=" stringByAppendingString:[oad BLD_TYPE]]];
        NSLog(@"%@", urlStr);
        
        NSURL *url = [NSURL URLWithString:urlStr];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request startSynchronous];
        
        NSError *error = [request error];
        // 网络连接成功
        if (!error) {
            NSData *unitData = [request responseData];
            XMLParser *xmlParser = [XMLParser sharedInstance];
            NSMutableArray *unitNodes = [[xmlParser parseXMLFromData:unitData] objectsForKey:@"BEAN"];
            
            for (int i=0; i < [unitNodes count]; ++i) {
                NodeData *unitNode = [unitNodes objectAtIndex:i];
                NSMutableString *unitNO = [NSMutableString stringWithString:[unitNode leafForKey:@"unitNo"]];
                if ([@"s" isEqualToString:unitNO]) {
                    [unitNO setString:@"商铺"];
                }
                else {
                    [unitNO appendString:@"单元"];
                }
                
                UIButton *button_unit = [[[UIButton alloc] init] autorelease];
                button_unit.frame = CGRectMake(180+90*i+10*i, 40, 90, 40);
                
                button_unit.titleLabel.font = [UIFont systemFontOfSize:20];
                [button_unit setTitle:unitNO forState:UIControlStateNormal];
                [button_unit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                if (0 == i) {
                    [self onClickUnit:button_unit];
                }
                
                [button_unit addTarget:self action:@selector(onClickUnit:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:button_unit];
            }
        }
        else {
            [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
            [av show];
        }
    }
    else {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"请先在项目信息中指定楼栋！\n", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
}

- (void)viewDidUnload
{
    [self setLabel_forSale:nil];
    [self setLabel_notSale:nil];
    [self setLabel_inOrder:nil];
    [self setLabel_contracting:nil];
    [self setLabel_contracted:nil];
    [self setTmpCell:nil];
    [self setFloorTable:nil];
    [self setLabel_bNO:nil];
    [self setHouseDesc:nil];
    [self setAttentioning:nil];
    [self setDirectType:nil];
    [self setStateDesc:nil];
    [self setModelType:nil];
    [self setBuildingArea:nil];
    [self setInsideArea:nil];
    [self setUnitPrice:nil];
    [self setTotalPrice:nil];
    [self setPublicArea:nil];
    
    [self setFloorList:nil];
    [self setCellNib:nil];
    [self setCrtUnit:nil];
    
    [self setRefreshBtn:nil];
    [self setGardenPrice:nil];
    [self setGardenArea2:nil];
    [self setGardenArea:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [_button_crtUnit release];
    [_button_crtHouse release];
    [_label_forSale release];
    [_label_notSale release];
    [_label_inOrder release];
    [_label_contracting release];
    [_label_contracted release];
    [_tmpCell release];
    [_floorTable release];
    [_label_bNO release];
    [_houseDesc release];
    [_attentioning release];
    [_directType release];
    [_stateDesc release];
    [_modelType release];
    [_buildingArea release];
    [_insideArea release];
    [_unitPrice release];
    [_totalPrice release];
    [_publicArea release];
    
    [_floorList release];
    [_cellNib release];
    [_crtUnit release];
    
    [_refreshBtn release];
    [_gardenPrice release];
    [_gardenArea2 release];
    [_gardenArea release];
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
    return [_floorList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *floorID = @"floorID";
    
    HouseCell *cell = (HouseCell *)[tableView dequeueReusableCellWithIdentifier:floorID];
	
	if (cell == nil) {
        [self.cellNib instantiateWithOwner:self options:nil];
        cell = _tmpCell;
        self.tmpCell = nil;
	}
	
	Floor *floor = [_floorList objectAtIndex:indexPath.row];
    
    cell.floorNO = [floor fNO];
    
    NSMutableArray *houses = [floor fRow];
    UIScrollView *floorRow = [[UIScrollView alloc] init];
    floorRow.frame = CGRectMake(64, 0, 704, 100);
    [floorRow setBackgroundColor:[UIColor redColor]];
    
    int houseCount = [houses count];
//    if (5 >= houseCount) {
    for (int i = 0; i < houseCount; ++i) {
        House *house = [houses objectAtIndex:i];
        UIButton *button_house = [[[UIButton alloc] init] autorelease];
        button_house.frame = CGRectMake(135*i, 0, 134, 100);
        
        [button_house setTitle:[house hID] forState:UIControlStateNormal];
        [button_house setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        
        UILabel *label_sep = [[[UILabel alloc] init] autorelease];
        [button_house addSubview:label_sep];
        
        label_sep.frame = CGRectMake(134, 0, 1, 100);
        [label_sep setBackgroundColor:[UIColor blueColor]];
        
        UILabel *label_house = [[[UILabel alloc] init] autorelease];
        [button_house addSubview:label_house];
        
        label_house.frame = CGRectMake(6, 0, 128, 30);
        label_house.font = [UIFont systemFontOfSize:20];
        [label_house setText:[house hNO]];
        [label_house setTextColor:[UIColor blackColor]];
        [label_house setBackgroundColor:[UIColor clearColor]];
        [label_house setFont:[UIFont systemFontOfSize:17]];
        
        UILabel *label_stateDesc = [[[UILabel alloc] init] autorelease];
        [button_house addSubview:label_stateDesc];
        
        label_stateDesc.frame = CGRectMake(44, 60, 90, 30);
        label_stateDesc.font = [UIFont systemFontOfSize:20];
        label_stateDesc.textAlignment = UITextAlignmentRight;
        [label_stateDesc setText:[house stateDesc]];
        [label_stateDesc setBackgroundColor:[UIColor clearColor]];
        
        //2：正在销售，3：拟定合同，4：已签合同, 11：非售, 8：认购
        //  green       cyan     yellow   darkgray purple
        if ([@"2" isEqualToString:[house sellState]]) {
            [label_stateDesc setTextColor:[UIColor greenColor]];
        }
        if ([@"3" isEqualToString:[house sellState]]) {
            [label_stateDesc setTextColor:[UIColor cyanColor]];
        }
        if ([@"4" isEqualToString:[house sellState]]) {
            [label_stateDesc setTextColor:[UIColor yellowColor]];
        }
        if ([@"11" isEqualToString:[house sellState]]) {
            [label_stateDesc setTextColor:[UIColor darkGrayColor]];
        }
        if ([@"8" isEqualToString:[house sellState]]) {
            [label_stateDesc setTextColor:[UIColor purpleColor]];
        }
        
        [button_house addTarget:self action:@selector(onClickHouse:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.house = button_house;

    }
//    }
//    else {
//        
//    }
    
	return cell;
}

- (void)onClickUnit:(UIButton *)sender
{
    NSMutableString *unitNO;
    if (sender) {
        unitNO = [[NSMutableString alloc] initWithString:[[sender titleLabel] text]];
        
        if ([unitNO isEqualToString:@"商铺"]) {
            [unitNO setString:@"s"];
        }
        else {
            [unitNO setString:[[unitNO componentsSeparatedByString:@"单元"] objectAtIndex:0]];
//            [unitNO setString:[unitNO substringToIndex:1]];
        }
    }
    
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
    urlStr = [urlStr stringByAppendingString:@"/security/project/getHouseFrameList/"];
    urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
    urlStr = [urlStr stringByAppendingString:[@"&support=0&buildingNo=" stringByAppendingString:[oad BLD]]];
    
    if (sender) {
        urlStr = [urlStr stringByAppendingString:[@"&unitNo=" stringByAppendingString:unitNO]];
    }
    else {
        urlStr = [urlStr stringByAppendingString:[@"&unitNo=" stringByAppendingString:_crtUnit]];
    }
    
    urlStr = [urlStr stringByAppendingString:[@"&useType=" stringByAppendingString:[oad BLD_TYPE]]];
//    urlStr = [urlStr stringByAppendingString:@"&sort=floor_count&dir=desc"];
    NSLog(@"%@", urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    
    NSError *error = [request error];
    // 网络连接成功
    if (!error) {
        NSData *floorData = [request responseData];
        XMLParser *xmlParser = [XMLParser sharedInstance];
        NSMutableArray *floorNodes = [[xmlParser parseXMLFromData:floorData] objectsForKey:@"floor"];
        
        _floorList = [[NSMutableArray alloc] initWithCapacity:[floorNodes count]];
        for (NodeData *floorNode in floorNodes) {
            NSMutableArray *houseNodes = [floorNode objectsForKey:@"house"];
            
            int htc = [houseNodes count];
            
            int hc = 5;
            int multi = htc/hc;
            int mod = htc%hc;
            if (0 < mod)
                multi += 1;
            
            for (int i=0; i < multi; ++i) {
                NSMutableArray *houseArr = [[[NSMutableArray alloc] init] autorelease];
                
                int la = hc;
                if (htc < (i+1)*hc)
                    la = mod;
                
                for (int j=0; j < la; j++) {
                    NodeData *houseNode = [houseNodes objectAtIndex:i*hc+j];
                    [houseArr addObject:[House initWithID:[houseNode leafForKey:@"id"] hNO:[houseNode leafForKey:@"houseNo"] sellState:[houseNode leafForKey:@"sellState"] stateDesc:[houseNode leafForKey:@"stateDesc"]]];
                }
                
                NSString *fNO;
                if (0 == i)
                    fNO = [NSString stringWithString:[floorNode leafForKey:@"floorNoDesc"]];
                else
                    fNO = [NSString stringWithString:@""];
                
                [_floorList addObject:[Floor initWithNO:fNO hRow:houseArr]];
                
                [fNO release];
            }
        }
        
        [_floorTable reloadData];
    }
    else {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    
    if (sender) {    
        [_button_crtUnit setBackgroundColor:[UIColor whiteColor]];
        [sender setBackgroundColor:[UIColor cyanColor]]; 
        
        _crtUnit = unitNO;
        _button_crtUnit = [sender retain];
    }
}

- (void)onClickHouse:(UIButton *)sender
{
    NSString *hID = [NSString stringWithString:[[sender titleLabel] text]];
    
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
    urlStr = [urlStr stringByAppendingString:@"/security/project/getHouseList/"];
    urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
    urlStr = [urlStr stringByAppendingString:[@"&buildingNo=" stringByAppendingString:[oad BLD]]];
    urlStr = [urlStr stringByAppendingString:[@"&unitNo=" stringByAppendingString:_crtUnit]];
    urlStr = [urlStr stringByAppendingString:[@"&id=" stringByAppendingString:hID]];
    NSLog(@"%@", urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    
    NSError *error = [request error];
    // 网络连接成功
    if (!error) {
        NSData *houseData = [request responseData];
        XMLParser *xmlParser = [XMLParser sharedInstance];
        NodeData *houseNode = [[xmlParser parseXMLFromData:houseData] objectForKey:@"BEAN"];
        
        NSString *houseDesc = [[[NSString alloc] initWithString:[houseNode leafForKey:@"houseDesc"]] autorelease];
        NSString *publicArea = [[[NSString alloc] initWithString:[houseNode leafForKey:@"publicArea"]] autorelease];
        NSString *insideArea = [[[NSString alloc] initWithString:[houseNode leafForKey:@"insideArea"]] autorelease];
        NSString *unitPrice = [[[NSString alloc] initWithString:[houseNode leafForKey:@"unitPrice"]] autorelease];
        NSString *gardenPrice = [[[NSString alloc] initWithString:[houseNode leafForKey:@"gardenPrice"]] autorelease];
        NSString *totalPrice = [[[NSString alloc] initWithString:[houseNode leafForKey:@"totalPrice"]] autorelease];
        NSString *gardenArea = [[[NSString alloc] initWithString:[houseNode leafForKey:@"gardenArea"]] autorelease];
        NSString *gardenArea2 = [[[NSString alloc] initWithString:[houseNode leafForKey:@"gardenArea2"]] autorelease];
        
        int tip = [[houseNode leafForKey:@"attentioning"] intValue];
        tip += 1;
        
        [_houseDesc setText:houseDesc];
        [_attentioning setText:[[@"当前有" stringByAppendingString:[NSString stringWithFormat:@"%i", tip]] stringByAppendingString:@"人关注此房"]];
        [_directType setText:[houseNode leafForKey:@"type"]];
        [_stateDesc setText:[houseNode leafForKey:@"stateDesc"]];
        [_modelType setText:[houseNode leafForKey:@"modelType"]];
        [_buildingArea setText:[[houseNode leafForKey:@"buildingArea"] stringByAppendingString:@"平方米"]];
        [_insideArea setText:[insideArea stringByAppendingString:@"平方米"]];
        [_unitPrice setText:[unitPrice stringByAppendingString:@"元"]];
        [_totalPrice setText:[NSString stringWithFormat:@"%.2f%@", [totalPrice floatValue], @"元"]]; // + [gardenPrice floatValue]
        [_publicArea setText:[publicArea stringByAppendingString:@"平方米"]];
        [_gardenArea setText:[gardenArea stringByAppendingString:@"平方米"]];
        [_gardenArea2 setText:[gardenArea2 stringByAppendingString:@"平方米"]];
        [_gardenPrice setText:[gardenPrice stringByAppendingString:@"元"]];
        
        House *house = [House sharedInstance];
        [house setHDesc:houseDesc];
        [house setHArea:[houseNode leafForKey:@"buildingArea"]];
//        [house setHArea:[NSString stringWithFormat:@"%.2f", [publicArea floatValue] + [insideArea floatValue] + [gardenArea floatValue] + [gardenArea2 floatValue]]];
        [house setUnitPrice:unitPrice];
        [house setTotalPrice:[NSString stringWithFormat:@"%.2f", [totalPrice floatValue]]]; // + [gardenPrice floatValue]
        
        [self attendHouse:hID];
        
        if ([houseNode leafForKey:@"floorModeType"] && ![@"" isEqualToString:[houseNode leafForKey:@"floorModeType"]]) {
            NSString *pics = [[NSString alloc] initWithString:[houseNode leafForKey:@"floorModeType"]];
            
            Photo *pht = [Photo sharedInstance];
            
            [pht setIsB:@"0"];
            [pht setName:houseDesc];
            [pht setPath:[NSString stringWithFormat:@"%@%@%@%@", [oad SERVER], @"/security/project/getProjectHousePic/", [oad SID_PROJ], @"&type=1&src="]];
            
            NSArray *tmpArr = [pics componentsSeparatedByString:@","];
            [pics release];
            
            NSMutableArray *pArr = [[NSMutableArray alloc] init];
            for (int i=0; i<[tmpArr count]; ++i) {
                NSString *pic = [[NSString stringWithString:[tmpArr objectAtIndex:i]] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
                
                if (![@"" isEqualToString:pic]) {
                    [pArr addObject:[[NSString alloc] initWithString:pic]];
                }
                [pic release];
            }
            
            [pht setPArr:[NSArray arrayWithArray:pArr]];
            [pArr release];
        }
    }
    else {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    
    [_button_crtHouse setBackgroundColor:[UIColor whiteColor]];
    [sender setBackgroundColor:[UIColor lightGrayColor]];
    
    _button_crtHouse = [sender retain];
}

- (void)attendHouse:(NSString *)hID
{
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
    urlStr = [urlStr stringByAppendingString:@"/security/project/getHouseList/"];
    urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
    urlStr = [urlStr stringByAppendingString:[@"&add=true&id=" stringByAppendingString:hID]];
    NSLog(@"%@", urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    
    NSError *error = [request error];
    if (error) {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
}

- (IBAction)refreshHouse:(id)sender {
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    
    if ([oad BLD] && ![@"" isEqualToString:[oad BLD]]) {
        [self onClickUnit:nil];
        
//        NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
//        urlStr = [urlStr stringByAppendingString:@"/security/project/getHouseFrameList/"];
//        urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
//        urlStr = [urlStr stringByAppendingString:[@"&buildingNo=" stringByAppendingString:[oad BLD]]];
//        urlStr = [urlStr stringByAppendingString:[@"&unitNo=" stringByAppendingString:_crtUnit]];
//        NSLog(@"%@", urlStr);
//        
//        NSURL *url = [NSURL URLWithString:urlStr];
//        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//        [request startSynchronous];
//        
//        NSError *error = [request error];
//        // 网络连接成功
//        if (!error) {
//            NSData *floorData = [request responseData];
//            XMLParser *xmlParser = [XMLParser sharedInstance];
//            NSMutableArray *floorNodes = [[xmlParser parseXMLFromData:floorData] objectsForKey:@"floor"];
//            
//            _floorList = [[NSMutableArray alloc] initWithCapacity:[floorNodes count]];
//            for (NodeData *floorNode in floorNodes) {
//                NSMutableArray *houseNodes = [floorNode objectsForKey:@"house"];
//                
//                NSMutableArray *houseArr = [[[NSMutableArray alloc] init] autorelease];
//                for (NodeData *houseNode in houseNodes) {
//                    [houseArr addObject:[House initWithID:[houseNode leafForKey:@"id"] hNO:[houseNode leafForKey:@"houseNo"] sellState:[houseNode leafForKey:@"sellState"] stateDesc:[houseNode leafForKey:@"stateDesc"]]];
//                }
//                
//                [_floorList addObject:[Floor initWithNO:[floorNode leafForKey:@"floorNo"] hRow:houseArr]];
//            }
//            
//            [_floorTable reloadData];
//        }
//        else {
//            [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
//            [av show];
//        }
    }
    else {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"请先在项目信息中指定楼栋！\n", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
}

- (IBAction)searchBySellState:(id)sender {
    NSMutableString *sellState = [[NSMutableString alloc] initWithString:[[sender titleLabel] text]];
    
    //2：正在销售，3：拟定合同，4：已签合同, 11：非售, 8：认购
    if ([sellState isEqualToString:@"可售"]) {
        [sellState setString:@"&sellState=2"];
    }
    if ([sellState isEqualToString:@"拟定合同"]) {
        [sellState setString:@"&sellState=3"];
    }
    if ([sellState isEqualToString:@"已签合同"]) {
        [sellState setString:@"&sellState=4"];
    }
    if ([sellState isEqualToString:@"非售"]) {
        [sellState setString:@"&sellState=11"];
    }
    if ([sellState isEqualToString:@"已定房"]) {
        [sellState setString:@"&sellState=8"];
    }
    
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
    urlStr = [urlStr stringByAppendingString:@"/security/project/getHouseFrameList/"];
    urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
    urlStr = [urlStr stringByAppendingString:[@"&support=0&buildingNo=" stringByAppendingString:[oad BLD]]];
    urlStr = [urlStr stringByAppendingString:[@"&unitNo=" stringByAppendingString:_crtUnit]];
    urlStr = [urlStr stringByAppendingString:[@"&useType=" stringByAppendingString:[oad BLD_TYPE]]];
    urlStr = [urlStr stringByAppendingString:sellState];
    NSLog(@"%@", urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    
    NSError *error = [request error];
    // 网络连接成功
    if (!error) {
        NSData *floorData = [request responseData];
        XMLParser *xmlParser = [XMLParser sharedInstance];
        NSMutableArray *floorNodes = [[xmlParser parseXMLFromData:floorData] objectsForKey:@"floor"];
        
        _floorList = [[NSMutableArray alloc] initWithCapacity:[floorNodes count]];
        for (NodeData *floorNode in floorNodes) {
            NSMutableArray *houseNodes = [floorNode objectsForKey:@"house"];
            
            if (0 < [houseNodes count]) {
                NSMutableArray *houseArr = [[[NSMutableArray alloc] init] autorelease];
                for (NodeData *houseNode in houseNodes) {
                    [houseArr addObject:[House initWithID:[houseNode leafForKey:@"id"] hNO:[houseNode leafForKey:@"houseNo"] sellState:[houseNode leafForKey:@"sellState"] stateDesc:[houseNode leafForKey:@"stateDesc"]]];
                }
                
                [_floorList addObject:[Floor initWithNO:[floorNode leafForKey:@"floorNoDesc"] hRow:houseArr]];
            }
        }
        
        [_floorTable reloadData];
    }
    else {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
}

- (IBAction)housePic:(id)sender {
    if (_button_crtHouse) {
        Photo *pht = [Photo sharedInstance];
        if ([pht pArr] && [[pht pArr] count] > 0) {
            _phtsView = [[ProjPhotosViewController alloc] initWithNibName:@"ProjPhotosViewController" bundle:[NSBundle mainBundle]];
            
            [self.view addSubview:_phtsView.view];
        }
        else {
            UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
            [av initWithTitle:@"房源信息" message:@"此房源无户型图\n" delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
            [av show];
        }
    }
    else {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
        [av initWithTitle:@"房源信息" message:@"请先选择房源！\n" delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];   
    }
}

- (IBAction)calculator:(id)sender {
    Calculator *cal = [Calculator sharedInstance];
    [cal setFromHouse:@"1"];
    
    _calculatorView = [[CalculatorViewController alloc] initWithNibName:@"CalculatorViewController" bundle:nil];
    
    [self.view.window setRootViewController:_calculatorView];
    [self.view.window makeKeyAndVisible];
}

@end
