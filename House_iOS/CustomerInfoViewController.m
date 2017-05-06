//
//  CustomerInfoViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-11-29.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "CustomerInfoViewController.h"

#import "OudsAppDelegate.h"
#import "PlatformViewController.h"

#import "XMLParser.h"
#import "NodeData.h"
#import "Group.h"

#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "COMMON.h"

#import "Customer.h"
#import "CustomerFormViewController.h"
#import "AdvInfo.h"
#import "AdvInfoViewController.h"
#import "Server.h"
#import "ServiceInfoViewController.h"

@implementation CustomerInfoViewController

@synthesize isIssue = _isIssue;

@synthesize meanTable = _meanTable;
@synthesize meanList = _meanList;
@synthesize serTable = _serTable;
@synthesize serList = _serList;
@synthesize tmpCell = _tmpCell;
@synthesize cellNib = _cellNib;
@synthesize text_search = _text_search;

@synthesize advPopoverController = _advPopoverController;
@synthesize basicInfoBtn = _basicInfoBtn;
@synthesize advanceInfoBtn = _advanceInfoBtn;
@synthesize serviceBtn = _serviceBtn;
@synthesize name = _name;
@synthesize sellerName = _sellerName;
@synthesize job = _job;
@synthesize phones = _phones;
@synthesize age = _age;
@synthesize cognizePath = _cognizePath;
@synthesize bideArea = _bideArea;
@synthesize workArea = _workArea;
@synthesize familyEarning = _familyEarning;
@synthesize bideHouseType = _bideHouseType;
@synthesize type = _type;
@synthesize signDesc = _signDesc;
@synthesize bargainState = _bargainState;
@synthesize promoter = _promoter;
@synthesize liver = _liver;
@synthesize remark = _remark;
@synthesize zysx = _zysx;
@synthesize attendBtn = _attendBtn;

@synthesize phoneBtn = _phoneBtn;
@synthesize visitBtn = _visitBtn;
@synthesize selfBtn = _selfBtn;
@synthesize allBtn = _allBtn;
@synthesize nameBtn = _nameBtn;
@synthesize timeBtn = _timeBtn;
@synthesize typeBtn = _typeBtn;
@synthesize statBtn = _statBtn;

@synthesize customerTable = _customerTable;
@synthesize customerList = _customerList;

@synthesize issueLabel = _issueLabel;
@synthesize issueCL = _issueCL;
@synthesize issueC = _issueC;
@synthesize filterView = _filterView;
@synthesize infoView = _infoView;
@synthesize advView = _advView;
@synthesize serView = _serView;

@synthesize customerFormView = _customerFormView;
@synthesize servInfoView = _servInfoView;
@synthesize meanFormView = _meanFormView;

@synthesize advTable = _advTable;
@synthesize advList = _advList;

static NSString *limit = @"100";
static NSMutableString *sort;
static NSNumber *catalog;
static NSMutableString *catalogStr;

static UIButton *cCatalogBtn;
static UIButton *cSortBtn;

static NSString *customerID;
static NSString *cstName;
static NSString *cstAdvID;
static NSString *atd;

static NSString *mID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"客户信息";
        //self.tabBarItem.image = [UIImage imageNamed:@"tab_customer.png"];
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
    
    if ([[self title] isEqualToString:@"客户信息"]) {
        _isIssue = [NSString stringWithString:@"0"];
        
        [_filterView setHidden:NO];
    }
    
    if ([[self title] isEqualToString:@"重点客户"]) {
        _isIssue = [NSString stringWithString:@"1"];
        
        [_issueLabel setHidden:NO];
        [_issueCL setHidden:NO];
        [_issueC setHidden:NO];
    }
    
    [_customerTable setTag:1];
    [_advTable setTag:2];
    [_meanTable setTag:3];
    [_serTable setTag:4];
    
    [_basicInfoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_infoView setHidden:NO];
    
    [sort release];
    sort = [[NSMutableString alloc] initWithString:@"updateTime"];
    catalog = [NSNumber numberWithInt:-1];
    
    [self resetCustomersByCatalog:catalog Sort:sort];
    
    if ([@"1" isEqualToString:_isIssue]) {
        [_issueC setText:[[NSString stringWithFormat:@"%i", [_customerList count]] stringByAppendingString:@"人"]];
    }
    
//    if ([_customerList count] > 0) {
//        Customer *customer = [_customerList objectAtIndex:0];
//        
//        [customerID release];
//        customerID = [[NSString alloc] initWithString:[customer customerID]];
//        
//        Customer *cstm = [Customer sharedInstance];
//        [cstm setCustomerID:customerID];
//        
//        [cstName release];
//        cstName = [[NSString alloc] initWithString:[customer name]];
//        
//        [self setCustomerInfo];
//    }
    
    if ([_customerList count] > 0) {
        [self refreshCstmInfo:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
    
    cCatalogBtn = _selfBtn;
    cSortBtn = _timeBtn;
    
    [cCatalogBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cSortBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
//    [_remark setContentSize:CGSizeMake(300, 200)];
    
    self.serTable.rowHeight = 62.0;
    self.cellNib = [UINib nibWithNibName:@"IndividualBasedServiceCell2" bundle:nil];
}

- (void)viewDidUnload
{
    [self setPhoneBtn:nil];
    [self setVisitBtn:nil];
    [self setSelfBtn:nil];
    [self setAllBtn:nil];
    [self setNameBtn:nil];
    [self setTimeBtn:nil];
    [self setTypeBtn:nil];
    [self setStatBtn:nil];
    [self setCustomerTable:nil];
    [self setName:nil];
    [self setJob:nil];
    [self setPhones:nil];
    [self setAge:nil];
    [self setCognizePath:nil];
    [self setBideArea:nil];
    [self setWorkArea:nil];
    [self setFamilyEarning:nil];
    [self setBideHouseType:nil];
    [self setType:nil];
    [self setSignDesc:nil];
    [self setBargainState:nil];
    [self setBasicInfoBtn:nil];
    [self setAdvanceInfoBtn:nil];
    [self setRemark:nil];
    [self setInfoView:nil];
    [self setAdvTable:nil];
    [self setAdvList:nil];
    [self setMeanList:nil];
    [self setServiceBtn:nil];
    [self setAdvView:nil];
    [self setMeanTable:nil];
    [self setSerView:nil];
    [self setSerTable:nil];
    [self setSerList:nil];
    
    [self setTmpCell:nil];
    [self setCellNib:nil];
    
    [self setText_search:nil];
    [self setFilterView:nil];
    [self setIssueLabel:nil];
    [self setIssueCL:nil];
    [self setIssueC:nil];
    [self setSellerName:nil];
    [self setPromoter:nil];
    [self setLiver:nil];
    [self setAttendBtn:nil];
    [self setZysx:nil];
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
    int tabCount = 0;
    switch ([tableView tag]) {
        case 1:
            tabCount = [_customerList count];
            
            break;
        case 2:
            tabCount = [_advList count];
            
            break;
        case 3:
            tabCount = [_meanList count];
            
            break;
        case 4:
            tabCount = [_serList count];
            
            break;
    }
    
    return tabCount; 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (4 != [tableView tag]) {
        UITableViewCell *cell;
        switch ([tableView tag]) {
            case 1:{
                static NSString *cstID = @"cstID";
                
                cell = [tableView dequeueReusableCellWithIdentifier:cstID];
                if (cell == nil)
                {
                    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cstID] autorelease];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                
                Customer *customer = [_customerList objectAtIndex:indexPath.row];
                
            //    NSString *updateTime = [[NSString alloc] initWithString:@""];
            //	if (nil != [customer updateTime]) {
            //        updateTime = [updateTime stringByAppendingString:[customer updateTime]];
            //    }
            //    cell.textLabel.text = [[customer name] stringByAppendingString:updateTime];
                
                cell.textLabel.text = [customer name];
                cell.detailTextLabel.text = [customer updateTime];
                
                break;
            }
            case 2:{
                static NSString *advID = @"advID";
                
                cell = [tableView dequeueReusableCellWithIdentifier:advID];
                if (cell == nil)
                {
                    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:advID] autorelease];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                
                AdvInfo *adv = [_advList objectAtIndex:indexPath.row];
                
                cell.textLabel.text = [adv type];
                cell.detailTextLabel.text = [adv time];
                
                break;
            }
            case 3:{
                static NSString *meanID = @"meanID";
                
                cell = [tableView dequeueReusableCellWithIdentifier:meanID];
                if (cell == nil)
                {
                    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:meanID] autorelease];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                
                NSArray *mArr = [_meanList objectAtIndex:indexPath.row];
                
                cell.textLabel.text = [mArr objectAtIndex:0];
                [cell.textLabel setTextColor:[UIColor blueColor]];
                [cell.textLabel setFont:[UIFont systemFontOfSize:17]];
                
                cell.detailTextLabel.text = [mArr objectAtIndex:1];
                [cell.detailTextLabel setTextColor:[UIColor blackColor]];
                [cell.detailTextLabel setFont:[UIFont systemFontOfSize:19]];
                
                break;
            }
        }
        
        return cell;
    }
    else {
        static NSString *serID = @"serID";
        
        Service *cell = (Service *)[tableView dequeueReusableCellWithIdentifier:serID];
        
        if (cell == nil) {
            [self.cellNib instantiateWithOwner:self options:nil];
            cell = _tmpCell;
            self.tmpCell = nil;
        }
        
        NSArray *mArr = [_serList objectAtIndex:indexPath.row];
        
        [cell setOrderTime:[mArr objectAtIndex:0]];
        [cell setHouseDesc:[mArr objectAtIndex:1]];
        [cell setPayMethod:[mArr objectAtIndex:2]];
        [cell setBuildingArea:[mArr objectAtIndex:3]];
        [cell setContractSignDesc:[mArr objectAtIndex:4]];
        [cell setOrderTotalPrice:[mArr objectAtIndex:5]];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([tableView tag]) {
        case 1:{
            Customer *customer = [_customerList objectAtIndex:indexPath.row];
            
            [customerID release];
            customerID = [[NSString alloc] initWithString:[customer customerID]];
            
            Customer *cstm = [Customer sharedInstance];
            [cstm setCustomerID:customerID];
            
            [cstName release];
            cstName = [[NSString alloc] initWithString:[customer name]];
            
            [self setCustomerInfo];
            [self setAdvInfo];
            [self setMeanInfo];
            [self setSerInfo];
            
            break;
        }
        case 2:{
            AdvInfo *adv = [_advList objectAtIndex:indexPath.row];
            
            [cstAdvID release];
//            cstAdvID = [[NSString alloc] initWithString:[advArr objectAtIndex:0]];
            
            AdvInfo *advs = [AdvInfo sharedInstance];
            
            [advs setName:cstName];
            [advs setType:[adv type]];
            [advs setTime:[adv time]];
            
            if ([[adv type] isEqualToString:@"来电"]) {
                [advs setModeDemand:[adv modeDemand]];
                [advs setAreaDemand:[adv areaDemand]];
                [advs setCallPoint:[adv callPoint]];
                [advs setVisitIntent:[adv visitIntent]];
                [advs setSellerName:[adv sellerName]];
            }
            
            if ([[adv type] isEqualToString:@"来访"]) {
                [advs setIntention:[adv intention]];
                [advs setTotalAcceptPrice:[adv totalAcceptPrice]];
                [advs setVisitPoint:[adv visitPoint]];
                [advs setFirstCase:[adv firstCase]];
                [advs setBargain:[adv bargain]];
                [advs setUnbargainElse:[adv unbargainElse]];
                [advs setSellerName:[adv sellerName]];
                [advs setWcjhx:[adv wcjhx]];
                [advs setWcjxm:[adv wcjxm]];
            }
            
            if ([[adv type] isEqualToString:@"回访"]) {
                [advs setReVisitType:[adv reVisitType]];
                [advs setReVisitDesc:[adv reVisitDesc]];
            }
            
            if ([[adv type] isEqualToString:@"问候"]) {
                [advs setFeastDay:[adv feastDay]];
                [advs setClientUuid:[adv clientUuid]];
                [advs setContent:[adv content]];
                [advs setResponse:[adv response]];
            }
            
            AdvInfoViewController *advInfoView = [[[AdvInfoViewController alloc] initWithNibName:@"AdvInfoViewController" bundle:nil] autorelease];
            advInfoView.delegate = self;
            
            self.advPopoverController = [[[UIPopoverController alloc] initWithContentViewController:advInfoView] autorelease];
            
            if ([[adv type] isEqualToString:@"来电"]) {
                [self.advPopoverController setPopoverContentSize: CGSizeMake(560, 500)];
            }
            if ([[adv type] isEqualToString:@"来访"]) {
                [self.advPopoverController setPopoverContentSize:CGSizeMake(560, 870)];
            }
            if ([[adv type] isEqualToString:@"回访"]) {
                [self.advPopoverController setPopoverContentSize:CGSizeMake(560, 500)];
            }
            if ([[adv type] isEqualToString:@"问候"]) {
                [self.advPopoverController setPopoverContentSize:CGSizeMake(560, 650)];
            }
            
            [self.advPopoverController dismissPopoverAnimated:YES];
  
            [self.advPopoverController presentPopoverFromRect:[[_advTable cellForRowAtIndexPath:indexPath] frame] inView:self.view permittedArrowDirections:NO animated:YES];
            
            break;   
        }
        case 3:{
            NSArray *mArr = [_meanList objectAtIndex:indexPath.row];

//            [mID release];
            mID = [NSString stringWithString:[mArr objectAtIndex:2]];
            
//            [cstAdvID release];
//            cstAdvID = [[NSString alloc] initWithString:[advArr objectAtIndex:0]];
            
            AdvInfo *advs = [AdvInfo sharedInstance];
            
            [advs setName:@"采用策略"];
            [advs setType:@"策略"];
            [advs setTime:[mArr objectAtIndex:0]];
            [advs setContent:[mArr objectAtIndex:1]];
            
            AdvInfoViewController *advInfoView = [[[AdvInfoViewController alloc] initWithNibName:@"AdvInfoViewController" bundle:nil] autorelease];
            advInfoView.delegate = self;
            
            self.advPopoverController = [[[UIPopoverController alloc] initWithContentViewController:advInfoView] autorelease];
            
            [self.advPopoverController setPopoverContentSize:CGSizeMake(560, 500)];
            [self.advPopoverController dismissPopoverAnimated:YES];
            
            [self.advPopoverController presentPopoverFromRect:[[_meanTable cellForRowAtIndexPath:indexPath] frame] inView:self.view permittedArrowDirections:NO animated:YES];
            
            break;
        }
        case 4:{
            NSArray *mArr = [_serList objectAtIndex:indexPath.row];
            
            Server *serv = [Server sharedInstance];
            
            [serv setSID:[mArr objectAtIndex:6]];
            [serv setOrderTime:[mArr objectAtIndex:0]];
            [serv setHouseDesc:[mArr objectAtIndex:1]];
            [serv setPayMethod:[mArr objectAtIndex:2]];
            [serv setBuildingArea:[mArr objectAtIndex:3]];
            [serv setContractSignDesc:[mArr objectAtIndex:4]];
            [serv setOrderTotalPrice:[mArr objectAtIndex:5]];
            [serv setClientUuid:customerID];
            
            _servInfoView = [[ServiceInfoViewController alloc] initWithNibName:@"ServiceInfoViewController" bundle:[NSBundle mainBundle]];
            [self.view addSubview:_servInfoView.view];
            
//            OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
//            [[oad window] addSubview:servInfoView.view]
            
            break;
        }
    }
}

- (void)dealloc {
    [_phoneBtn release];
    [_visitBtn release];
    [_selfBtn release];
    [_allBtn release];
    [_nameBtn release];
    [_timeBtn release];
    [_typeBtn release];
    [_statBtn release];
    [_customerTable release];
    [_advPopoverController release];
    [_name release];
    [_job release];
    [_phones release];
    [_age release];
    [_cognizePath release];
    [_bideArea release];
    [_workArea release];
    [_familyEarning release];
    [_bideHouseType release];
    [_type release];
    [_signDesc release];
    [_bargainState release];
    [_basicInfoBtn release];
    [_advanceInfoBtn release];
    [_remark release];
    [_infoView release];
    [_advTable release];
    [_advList release];
    
    [_serviceBtn release];
    [_advView release];
    [_meanTable release];
    [_meanList release];
    
    [_serView release];
    [_serTable release];
    [_serList release];
    
    [_tmpCell release];
    [_cellNib release];
    
    [_text_search release];
    [_filterView release];
    [_issueLabel release];
    [_issueCL release];
    [_issueC release];
    [_sellerName release];
    [_promoter release];
    [_liver release];
    [_attendBtn release];
    [_zysx release];
    [super dealloc];
}

- (IBAction)byPhone:(id)sender {
    catalog = [NSNumber numberWithInt:1];
    [self resetCustomersByCatalog:catalog Sort:sort];
    
    cCatalogBtn = _phoneBtn;
    [self reloadViewCatalogBtn:cCatalogBtn SortBtn:cSortBtn];
}

- (IBAction)byVisit:(id)sender {
    catalog = [NSNumber numberWithInt:2];
    [self resetCustomersByCatalog:catalog Sort:sort];
    
    cCatalogBtn = _visitBtn;
    [self reloadViewCatalogBtn:cCatalogBtn SortBtn:cSortBtn];
}

- (IBAction)bySelf:(id)sender {
    catalog = [NSNumber numberWithInt:-1];
    [self resetCustomersByCatalog:catalog Sort:sort];
    
    cCatalogBtn = _selfBtn;
    [self reloadViewCatalogBtn:cCatalogBtn SortBtn:cSortBtn];
}

- (IBAction)byAll:(id)sender {
    catalog = [NSNumber numberWithInt:0];
    [self resetCustomersByCatalog:catalog Sort:sort];
    
    cCatalogBtn = _allBtn;
    [self reloadViewCatalogBtn:cCatalogBtn SortBtn:cSortBtn];
}

- (IBAction)byName:(id)sender {
    [sort release];
    sort = [[NSMutableString alloc] initWithString:@"name"];
    [self resetCustomersByCatalog:catalog Sort:sort];
    
    cSortBtn = _nameBtn;
    [self reloadViewCatalogBtn:cCatalogBtn SortBtn:cSortBtn];
}

- (IBAction)byTime:(id)sender {
    [sort release];
    sort = [[NSMutableString alloc] initWithString:@"updateTime"];
    [self resetCustomersByCatalog:catalog Sort:sort];
    
    cSortBtn = _timeBtn;
    [self reloadViewCatalogBtn:cCatalogBtn SortBtn:cSortBtn];
}

- (IBAction)byType:(id)sender {
    [sort release];
    sort = [[NSMutableString alloc] initWithString:@"type"];
    [self resetCustomersByCatalog:catalog Sort:sort];
    
    cSortBtn = _typeBtn;
    [self reloadViewCatalogBtn:cCatalogBtn SortBtn:cSortBtn];
}

- (IBAction)byStat:(id)sender {
    [sort release];
    sort = [[NSMutableString alloc] initWithString:@"state"];
    [self resetCustomersByCatalog:catalog Sort:sort];
    
    cSortBtn = _statBtn;
    [self reloadViewCatalogBtn:cCatalogBtn SortBtn:cSortBtn];
}

- (void)resetCustomersByCatalog:(NSNumber *)catalog Sort:(NSString *)sort {
    if ([[NSNumber numberWithInt:0] isEqualToNumber:catalog] == YES) {
        catalogStr = [NSMutableString stringWithString:@""];
    }
    if ([[NSNumber numberWithInt:-1] isEqualToNumber:catalog] == YES) {
        catalogStr = [NSMutableString stringWithString:@"&isSearchAll=0"];
    }
    if ([[NSNumber numberWithInt:1] isEqualToNumber:catalog] == YES) {
        catalogStr = [NSMutableString stringWithString:@"&isSearchAll=0&searchCall=0"];
    }
    if ([[NSNumber numberWithInt:2] isEqualToNumber:catalog] == YES) {
        catalogStr = [NSMutableString stringWithString:@"&isSearchAll=0&searchVisit=0"];
    }
    
    sort = [@"&sort=" stringByAppendingString:sort];
    
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
    
    if ([@"1" isEqualToString:_isIssue]) {
        urlStr = [urlStr stringByAppendingString:@"/security/client/getClientList/"];
    }
    else {
        urlStr = [urlStr stringByAppendingString:@"/security/client/getClientListByNameOrPhone/"];
    }
    
    urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
    urlStr = [urlStr stringByAppendingString:[@"&sellerUuid=" stringByAppendingString:[oad USER_ID]]];
    if ([@"1" isEqualToString:_isIssue]) {
        urlStr = [urlStr stringByAppendingString:[@"&attention=" stringByAppendingString:@"0"]];
    }
    else {
        urlStr = [urlStr stringByAppendingString:[catalogStr stringByAppendingString:sort]];
    }
    urlStr = [urlStr stringByAppendingString:[@"&limit=" stringByAppendingString:limit]];
    
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
        
        _customerList = [[NSMutableArray alloc] initWithCapacity:[customerNodes count]];
        for (NodeData *customerNode in customerNodes) {
            NSString *updateTime = [[[NSString alloc] initWithString:[customerNode leafForKey:@"updateTime"]] autorelease];
            if (10 <= [updateTime length]) {
                updateTime = [updateTime substringToIndex:10];
            }
            
            [_customerList addObject:[Customer initWithID:[customerNode leafForKey:@"id"] Name:[customerNode leafForKey:@"name"] phone:[customerNode leafForKey:@"phone"] UpdateTime:updateTime Type:[customerNode leafForKey:@"type"]]];
            //            [updateTime release];
        }
    }
    else {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    
}

- (void)reloadViewCatalogBtn:(UIButton *)catalogBtn SortBtn:(UIButton *)sortBtn {
    [_customerTable reloadData];
    
    [_phoneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_visitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_selfBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_nameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_statBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [catalogBtn  setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [sortBtn  setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

- (IBAction)getBasicInfo:(id)sender {
    [self hideView];
    [_infoView setHidden:NO];
    
    if (customerID) {
        [self setCustomerInfo];
    }
    else {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"empty_data", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    
    [self clearColor];
    [_basicInfoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

- (IBAction)getAdvanceInfo:(id)sender {
    [self hideView];
    [_advView setHidden:NO];
    
    if (customerID) {
        [self setAdvInfo];
        [self setMeanInfo];
    }
    else {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"empty_data", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    
    [self clearColor];
    [_advanceInfoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

- (IBAction)getServices:(id)sender {
    [self hideView];
    [_serView setHidden:NO];
    
    if (customerID) {
        [self setSerInfo];
    }
    else {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"empty_data", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    
    [self clearColor];
    [_serviceBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

- (IBAction)attendCstm:(id)sender {
    
    //获取项目信息数据
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
    urlStr = [urlStr stringByAppendingString:@"/security/client/updateClient/"];
    urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
    //        urlStr = [urlStr stringByAppendingString:[@"&sheetUuid=" stringByAppendingString:sID]];
    //        urlStr = [urlStr stringByAppendingString:[@"&id=" stringByAppendingString:mID]];
    NSLog(@"%@", urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
//        [request setPostValue:[oad PROJ_ID] forKey:@"projectUuid"];
//        [request setPostValue:[oad USER_ID] forKey:@"sellerUuid"];
    [request setPostValue:customerID forKey:@"id"];
    
    NSString *atdStr;
    if ([@"1" isEqualToString:atd]) {
        [request setPostValue:@"0" forKey:@"attention"];
        atd = [NSString stringWithString:@"0"];
        atdStr = [NSString stringWithString:@""];
    }
    else {
        [request setPostValue:@"1" forKey:@"attention"];
        atd = [NSString stringWithString:@"1"];
        atdStr = [NSString stringWithString:@"取消"];
    }
    
    [request startSynchronous];
    NSError *error = [request error];
    // 网络连接成功
    if (!error) {
        [self resetCustomersByCatalog:catalog Sort:sort];
        [_customerTable reloadData];
        
        [_issueC setText:[[NSString stringWithFormat:@"%i", [_customerList count]] stringByAppendingString:@"人"]];
        [self rfsAtdBtn];
        
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:[NSString stringWithFormat:@"对客户 %@ %@关注成功！\n", cstName, atdStr] delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
        [atdStr release];
        
        if ([@"0" isEqualToString:atd]) {
            PlatformViewController *platformView = [PlatformViewController sharedInstance];
            [platformView customer:@"issue"];
        }
        else {
            if ([@"1" isEqualToString:_isIssue]) {
                [self.tabBarController setSelectedIndex:1];
            }
        }
    }
    else {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
}

- (void)setCustomerInfo {
    //获取项目信息数据
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
    urlStr = [urlStr stringByAppendingString:@"/security/client/getClientList/"];
    urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
    urlStr = [urlStr stringByAppendingString:[@"&id=" stringByAppendingString:customerID]];
    NSLog(@"%@", urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request startSynchronous];
    NSError *error = [request error];
    // 网络连接成功
    if (!error) {
        NSData *customerData = [request responseData];
        XMLParser *xmlParser = [XMLParser sharedInstance];
        NodeData *customerNode = [[xmlParser parseXMLFromData:customerData] objectForKey:@"BEAN"];
                
        [_name setText:[customerNode leafForKey:@"name"]];
        [_sellerName setText:[customerNode leafForKey:@"sellerName"]];
        [_job setText:[customerNode leafForKey:@"work"]];
        [_phones setText:[customerNode leafForKey:@"phone"]];
        [_age setText:[customerNode leafForKey:@"age"]];
        [_cognizePath setText:[customerNode leafForKey:@"cognizePath"]];
        [_bideArea setText:[customerNode leafForKey:@"liveArea"]];
        [_workArea setText:[customerNode leafForKey:@"workArea"]];
        [_familyEarning setText:[customerNode leafForKey:@"purpose"]];
        [_bideHouseType setText:[customerNode leafForKey:@"decision"]];
        [_type setText:[customerNode leafForKey:@"type"]];
        [_signDesc setText:[customerNode leafForKey:@"signDesc"]];
        [_bargainState setText:[customerNode leafForKey:@"state"]];
        [_promoter setText:[customerNode leafForKey:@"promoter"]];
        [_liver setText:[customerNode leafForKey:@"liver"]];
        [_remark setText:[customerNode leafForKey:@"remark"]];
        [_zysx setText:[customerNode leafForKey:@"impRemark"]];
        
        Customer *cstm = [Customer sharedInstance];
        
        [cstm setCustomerID:customerID];
        [cstm setName:[_name text]];
        [cstm setPhone:[_phones text]];
        [cstm setType:[_type text]];
        [cstm setAge:[_age text]];
        [cstm setGfmd:[_familyEarning text]];
        [cstm setJzqy:[_bideArea text]];
        [cstm setJzz:[_liver text]];
        [cstm setBgqy:[_workArea text]];
        [cstm setCszy:[_job text]];
        [cstm setCzr:[_promoter text]];
        [cstm setJcnl:[_bideHouseType text]];
        [cstm setHztj:[_cognizePath text]];
        [cstm setRztj:[_cognizePath text]];
        [cstm setZygw:[_sellerName text]];
        [cstm setZyID:[customerNode leafForKey:@"sellerUuid"]];
        [cstm setRemark:[_remark text]];
        [cstm setZysx:[_zysx text]];
        
        atd = [NSString stringWithString:[customerNode leafForKey:@"attention"]];
        [self rfsAtdBtn];
    }
    else {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
}

- (void)setAdvInfo {
    //获取项目信息数据
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
    urlStr = [urlStr stringByAppendingString:@"/security/client/getHighInfoList/"];
    urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
    urlStr = [urlStr stringByAppendingString:[@"&clientUuid=" stringByAppendingString:customerID]];
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
        
        _advList = [[NSMutableArray alloc] initWithCapacity:[customerNodes count]];
        for (NodeData *cstNode in customerNodes) {
            if (cstNode && [cstNode leafForKey:@"isCall"] && [cstNode leafForKey:@"time"]) {
                NSString *isCall = [cstNode leafForKey:@"isCall"];
                
                NSString *myTime = [[[NSString alloc] initWithString:[cstNode leafForKey:@"time"]] autorelease];
                if (10 <= [myTime length]) {
                    myTime = [myTime substringToIndex:10];
                }
                
                NSString *isCallStr;
                if ([@"0" isEqualToString:isCall]) {
                    isCallStr = [[[NSString alloc] initWithString:@"来电"] autorelease];
                    
                    [_advList addObject:[AdvInfo initWithType:isCallStr Time:myTime ModeDemand:[cstNode leafForKey:@"modeDemand"] AreaDemand:[cstNode leafForKey:@"areaDemand"] CallPoint:[cstNode leafForKey:@"callPoint"] VisitIntent:[cstNode leafForKey:@"visitIntent"] SellerName:[cstNode leafForKey:@"sellerName"]]];
                }
                
                if ([@"1" isEqualToString:isCall]) {
                    isCallStr = [[[NSString alloc] initWithString:@"来访"] autorelease];
                    
                    [_advList addObject:[AdvInfo initWithType:isCallStr Time:myTime intention:[cstNode leafForKey:@"intention"] totalAcceptPrice:[cstNode leafForKey:@"totalAcceptPrice"] visitPoint:[cstNode leafForKey:@"visitPoint"] firstCase:[cstNode leafForKey:@"firstCase"] bargain:[cstNode leafForKey:@"bargain"] unbargainElse:[cstNode leafForKey:@"unbargainElse"] wcjhx:[cstNode leafForKey:@"unbargainMode"] wcjxm:[cstNode leafForKey:@"unbargainItem"] SellerName:[cstNode leafForKey:@"sellerName"]]];
                }
                
                if ([@"2" isEqualToString:isCall]) {
                    isCallStr = [[[NSString alloc] initWithString:@"回访"] autorelease];
                    
                    [_advList addObject:[AdvInfo initWithType:isCallStr Time:myTime reVisitType:[cstNode leafForKey:@"reVisitType"] reVisitDesc:[cstNode leafForKey:@"reVisitDesc"]]];
                }
                
                if ([@"4" isEqualToString:isCall]) {
                    isCallStr = [[[NSString alloc] initWithString:@"问候"] autorelease];
                    
                    [_advList addObject:[AdvInfo initWithType:isCallStr Time:myTime feastDay:[cstNode leafForKey:@"feastDay"] clientUuid:[cstNode leafForKey:@"clientUuid"] content:[cstNode leafForKey:@"content"] response:[cstNode leafForKey:@"response"]]];
                }
                
//                else { // if ([@"3" isEqualToString:isCall])
//                    isCallStr = [[[NSString alloc] initWithString:@"基本信息"] autorelease];
//                }
            }
        }
        
        [_advTable reloadData];
    }
    else {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
}

- (void)setMeanInfo {
    //获取项目信息数据
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
    urlStr = [urlStr stringByAppendingString:@"/security/client/getClientTacticList/"];
    urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
//    urlStr = [urlStr stringByAppendingString:[@"&sellerUuid=" stringByAppendingString:[oad USER_ID]]];
    urlStr = [urlStr stringByAppendingString:[@"&clientUuid=" stringByAppendingString:customerID]];
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
        
        _meanList = [[NSMutableArray alloc] initWithCapacity:[customerNodes count]];
        for (NodeData *cstNode in customerNodes) {
            if (cstNode && [cstNode leafForKey:@"policy"] && [cstNode leafForKey:@"time"]) {                
                [_meanList addObject:[NSArray arrayWithObjects:[cstNode leafForKey:@"time"], [cstNode leafForKey:@"policy"], [cstNode leafForKey:@"id"], nil]];
            }
        }
        
        [_meanTable reloadData];
    }
    else {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
}

- (void)setSerInfo {
    //获取项目信息数据
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
    urlStr = [urlStr stringByAppendingString:@"/security/client/getClientBargainList/"];
    urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
    urlStr = [urlStr stringByAppendingString:[@"&sellerUuid=" stringByAppendingString:[oad USER_ID]]];
    urlStr = [urlStr stringByAppendingString:[@"&clientUuid=" stringByAppendingString:customerID]];
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
        
        _serList = [[NSMutableArray alloc] initWithCapacity:[customerNodes count]];
        for (NodeData *cstNode in customerNodes) {
            if (cstNode && [cstNode leafForKey:@"id"] && [cstNode leafForKey:@"houseDesc"] && [cstNode leafForKey:@"orderTime"]) {
                
                NSString *payMethodCn = [[NSString alloc] init];
                if ([@"0" isEqualToString:[cstNode leafForKey:@"payMethod"]]) {
                    payMethodCn = [NSString stringWithString:@"一次性"];
                }
                else if ([@"1" isEqualToString:[cstNode leafForKey:@"payMethod"]]) {
                    payMethodCn = [NSString stringWithString:@"按揭"];
                }
                else if ([@"2" isEqualToString:[cstNode leafForKey:@"payMethod"]]) {
                    payMethodCn = [NSString stringWithString:@"分期"];
                }
                else {
                    payMethodCn = [NSString stringWithString:@"未知"];
                }
                
                NSString *contractSignDescCn = [[NSString alloc] init];
                if ([@"0" isEqualToString:[cstNode leafForKey:@"contractSignDesc"]]) {
                    contractSignDescCn = [NSString stringWithString:@"已签约合同"];
                }
                else if ([@"1" isEqualToString:[cstNode leafForKey:@"contractSignDesc"]]) {
                    contractSignDescCn = [NSString stringWithString:@"未签约合同"];
                }
                else if ([@"2" isEqualToString:[cstNode leafForKey:@"contractSignDesc"]]) {
                    contractSignDescCn = [NSString stringWithString:@"已经拟定合同"];
                }
                else {
                    contractSignDescCn = [NSString stringWithString:@"未知"];
                }
                                
                [_serList addObject:[NSArray arrayWithObjects:[cstNode leafForKey:@"orderTime"], [cstNode leafForKey:@"houseDesc"], payMethodCn, [cstNode leafForKey:@"buildingArea"], contractSignDescCn, [cstNode leafForKey:@"orderTotalPrice"], [cstNode leafForKey:@"id"], nil]];
                
                [payMethodCn release];
                [contractSignDescCn release];
            }
        }
        
        [_serTable reloadData];
    }
    else {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
}

- (IBAction)newCustomerForm:(id)sender {
    Customer *cstm = [Customer sharedInstance];
    [cstm setIsEdit:@"0"];
    
    _customerFormView = [[[CustomerFormViewController alloc] initWithNibName:@"CustomerFormViewController" bundle:nil] autorelease];
    [self.view.window setRootViewController:_customerFormView];
}

- (IBAction)editCustomerForm:(id)sender {
    if (customerID) {
        Customer *cstm = [Customer sharedInstance];
        [cstm setIsEdit:@"1"];
        
        _customerFormView = [[[CustomerFormViewController alloc] initWithNibName:@"CustomerFormViewController" bundle:nil] autorelease];
        [self.view.window setRootViewController:_customerFormView];
    }
    else {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"请先指定要编辑的客户！\n", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
}

- (void)advViewControllerDidFinish:(AdvInfoViewController *)controller
{
    [self.advPopoverController dismissPopoverAnimated:YES];
//    [_advPopoverController release];
}

-(void) clearColor
{
    [_basicInfoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_advanceInfoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_serviceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

-(void) hideView
{
    [_infoView setHidden:YES];
    [_advView setHidden:YES];
    [_serView setHidden:YES];
}

- (IBAction)searchCstm:(id)sender {
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
    urlStr = [urlStr stringByAppendingString:@"/security/client/getClientListByNameOrPhone/"];
    urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
    urlStr = [urlStr stringByAppendingString:[@"&sellerUuid=" stringByAppendingString:[oad USER_ID]]];
    urlStr = [urlStr stringByAppendingString:[@"&searchValue=" stringByAppendingString:[_text_search text]]];
    
    if ([@"1" isEqualToString:_isIssue]) {
        urlStr = [urlStr stringByAppendingString:[@"&attention=" stringByAppendingString:@"0"]];
    }
    
    urlStr = [urlStr stringByAppendingString:[@"&limit=" stringByAppendingString:limit]];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8)];
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
        
        _customerList = [[NSMutableArray alloc] initWithCapacity:[customerNodes count]];
        for (NodeData *customerNode in customerNodes) {
            NSString *updateTime = [[[NSString alloc] initWithString:[customerNode leafForKey:@"updateTime"]] autorelease];
            if (10 <= [updateTime length]) {
                updateTime = [updateTime substringToIndex:10];
            }
            
            [_customerList addObject:[Customer initWithID:[customerNode leafForKey:@"id"] Name:[customerNode leafForKey:@"name"] phone:[customerNode leafForKey:@"phone"] UpdateTime:updateTime Type:[customerNode leafForKey:@"type"]]];
            //            [updateTime release];
        }
        
        [_customerTable reloadData];
    }
    else {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
}

- (IBAction)clearSearch:(id)sender {
    [_text_search setText:@""];
}

- (IBAction)addMean:(id)sender {
    if (customerID) {
        _meanFormView = [[MeanFormViewController alloc] initWithNibName:@"MeanFormViewController" bundle:[NSBundle mainBundle]];
        [_meanFormView setDelegate:self];
        
        [self.view addSubview:_meanFormView.view];
    }
    else {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"请先指定客户！\n", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
}

- (IBAction)delMean:(id)sender {
    //获取项目信息数据
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    if (mID) {
        OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
        
        NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
        urlStr = [urlStr stringByAppendingString:@"/security/client/delClientTactic/"];
        urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
//        urlStr = [urlStr stringByAppendingString:[@"&sellerUuid=" stringByAppendingString:[oad USER_ID]]];
//        urlStr = [urlStr stringByAppendingString:[@"&clientUuid=" stringByAppendingString:[serv clientUuid]]];
//        urlStr = [urlStr stringByAppendingString:[@"&sheetUuid=" stringByAppendingString:sID]];
        NSLog(@"%@", urlStr);
        
        NSURL *url = [NSURL URLWithString:urlStr];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        
        [request setPostValue:mID forKey:@"id"];
        
        [request startSynchronous];
        NSError *error = [request error];
        // 网络连接成功
        if (!error) {
            [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"成功删除！\n", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
            [av show];
            
            mID = nil;
            
            [self setMeanInfo];
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

- (void)setGrpCstm:(NSMutableArray *)cstmList index:(NSIndexPath *)indexPath
{
    _customerList = cstmList;
    
    [_customerTable reloadData];
    
    [self refreshCstmInfo:indexPath];
}

- (void)refreshCstmInfo:(NSIndexPath *)indexPath
{
    Customer *customer = [_customerList objectAtIndex:[indexPath row]];
    
    [customerID release];
    customerID = [[NSString alloc] initWithString:[customer customerID]];
    
    Customer *cstm = [Customer sharedInstance];
    [cstm setCustomerID:customerID];
    
    [cstName release];
    cstName = [[NSString alloc] initWithString:[customer name]];
    
    [self setCustomerInfo];
    
    [_customerTable selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

- (void)rfsAtdBtn
{
    if ([@"1" isEqualToString:atd]) {
        [_attendBtn setTitle:@"加关注" forState:UIControlStateNormal];
        [_attendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_attendBtn setBackgroundColor:[UIColor cyanColor]];
    }
    else {
        [_attendBtn setTitle:@"不关注" forState:UIControlStateNormal];
        [_attendBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_attendBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    [_attendBtn setHidden:NO];
}

@end
