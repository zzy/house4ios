//
//  CalculatorViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-12.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "CalculatorViewController.h"

#import "ToolsViewController.h"
#import "House.h"

#import "OudsAppDelegate.h"
#import "NodeData.h"
#import "ASIHTTPRequest.h"
#import "XMLParser.h"

#import "PlatformViewController.h"
#import "Calculator.h"

@implementation CalculatorViewController

@synthesize zkyxj = _zkyxj;
@synthesize zkyxjv = _zkyxjv;
@synthesize mTable = _mTable;
@synthesize mList = _mList;

@synthesize cField = _cField;
@synthesize cView = _cView;

@synthesize calvPopoverController = _calvPopoverController;

@synthesize housePrice = _housePrice;
@synthesize totalPrice = _totalPrice;
@synthesize arangePrice = _arangePrice;
@synthesize pay = _pay;
@synthesize perCredit = _perCredit;
@synthesize accrual = _accrual;
@synthesize perPay = _perPay;

@synthesize toolsView = _toolsView;
@synthesize houseDesc = _houseDesc;
@synthesize houseArea = _houseArea;
@synthesize unitPrice = _unitPrice;
@synthesize lendPrice = _lendPrice;
@synthesize lendLimit = _lendLimit;
@synthesize upProportion = _upProportion;
@synthesize payMethod = _payMethod;
@synthesize payType = _payType;
@synthesize basicRate = _basicRate;
@synthesize interestRate = _interestRate;
@synthesize yhfs = _yhfs;

static NSString *choice;
static NSString *payWay;
static NSString *learn;

static float yhzk = 0;
static float yhfx = 0;

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
    
    Calculator *cal = [Calculator sharedInstance];
    if ([@"1" isEqualToString:[cal fromHouse]]) {
        House *house = [House sharedInstance];
        [_houseDesc setText:[house hDesc]];
        [_houseArea setText:[house hArea]];
        [_unitPrice setText:[house unitPrice]];
        [_totalPrice setText:[house totalPrice]];
    }
    
    yhzk = 0;
    yhfx = 0;
}

- (void)viewDidUnload
{
    [self setHouseDesc:nil];
    [self setHouseArea:nil];
    [self setUnitPrice:nil];
    [self setHousePrice:nil];
    [self setLendPrice:nil];
    [self setLendLimit:nil];
    [self setUpProportion:nil];
    [self setPayMethod:nil];
    [self setPayType:nil];
    [self setBasicRate:nil];
    [self setInterestRate:nil];
    [self setArangePrice:nil];
    [self setPay:nil];
    [self setPerCredit:nil];
    [self setAccrual:nil];
    [self setPerPay:nil];
    [self setTotalPrice:nil];
    [self setYhfs:nil];
    [self setZkyxj:nil];
    [self setZkyxjv:nil];
    [self setMTable:nil];
    [self setMList:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)houses:(id)sender {
    PlatformViewController *platformView = [PlatformViewController sharedInstance];
    [platformView house:@"houses"];
}

- (IBAction)tools:(id)sender {
    _toolsView = [[ToolsViewController alloc] initWithNibName:@"ToolsViewController" bundle:[NSBundle mainBundle]];
    [self.view addSubview:_toolsView.view];
}

- (IBAction)getPayMethod:(id)sender {
    [self textFieldShouldBeginEditing:_payMethod];
    
    Calculator *cal = [Calculator sharedInstance];
    [cal setType:@"0"];
    
    _cField = _payMethod;
    
    [self setValue];
}

- (IBAction)getPayType:(id)sender {
    if ([_lendLimit text] && ![@"" isEqualToString:[_lendLimit text]] && 
        [_upProportion text] && ![@"" isEqualToString:[_upProportion text]]) {
        [self textFieldShouldBeginEditing:_payType];
        
        Calculator *cal = [Calculator sharedInstance];
        [cal setType:@"1"];
        [cal setLendLimit:[_lendLimit text]];
        
        _cField = _payType;
        
        [self setValue];
    }
    else {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:@"请先输入贷款年限、上浮比例！\n" delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
}

- (IBAction)yhfsValue:(id)sender {
    [self textFieldShouldBeginEditing:_yhfs];
    
    Calculator *cal = [Calculator sharedInstance];
    [cal setType:@"-1"];
    
    _cField = _yhfs;
    
    [self setValue];
}

- (IBAction)doCalculator:(id)sender {
    // 获取用户输入
    
    NSString *hArea;
    if (_houseArea.text) {
        hArea = [[[NSString alloc] initWithString:[_houseArea.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]] autorelease];
    }
    else {
        hArea = [[[NSString alloc] initWithString:@""] autorelease];    
    }
    
    NSString *tPrice;
    if (_totalPrice.text) {
        tPrice = [[[NSString alloc] initWithString:[_totalPrice.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]] autorelease];
    }
    else {
        tPrice = [[[NSString alloc] initWithString:@""] autorelease];
    }
    
    NSString *lPrice;
    if (_lendPrice.text) {
        lPrice = [[[NSString alloc] initWithString:[_lendPrice.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]] autorelease];
    }
    else {
        lPrice = [[[NSString alloc] initWithString:@""] autorelease];
    }
    
    NSString *lLimit;
    if (_lendLimit.text) {
        lLimit = [[[NSString alloc] initWithString:[_lendLimit.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]] autorelease];
    }
    else {
        lLimit = [[[NSString alloc] initWithString:@""] autorelease];
    }
    
    NSString *pMethod;
    if (_payMethod.text) {
        pMethod= [[[NSString alloc] initWithString:[_payMethod.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] autorelease];
    }
    else {
        pMethod = [[[NSString alloc] initWithString:@""] autorelease];
    }
    
    NSString *iRate;
    if (_interestRate.text) {
        iRate = [[[NSString alloc] initWithString:[_interestRate.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]] autorelease];
    }
    else {
        iRate = [[[NSString alloc] initWithString:@"0"] autorelease];
    }
    
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
    urlStr = [urlStr stringByAppendingString:@"/public/calculator/?"];
    // 输入不能为空
    if (![@"" isEqualToString:hArea]) {
        urlStr = [urlStr stringByAppendingString:[@"houseArea=" stringByAppendingString:[hArea stringByAppendingString:@"&"]]];
    }
    if (![@"" isEqualToString:tPrice]) {
        urlStr = [urlStr stringByAppendingString:[@"housePrice=" stringByAppendingString:[tPrice stringByAppendingString:@"&"]]];
    }
    if (![@"" isEqualToString:lPrice]) {
        urlStr = [urlStr stringByAppendingString:[@"lendPrice=" stringByAppendingString:[lPrice stringByAppendingString:@"&"]]];
    }
    if (![@"" isEqualToString:lLimit]) {
        urlStr = [urlStr stringByAppendingString:[@"lendLimit=" stringByAppendingString:[lLimit stringByAppendingString:@"&"]]];
    }
    if (![@"" isEqualToString:pMethod]) {
        urlStr = [urlStr stringByAppendingString:[@"payMethod=" stringByAppendingString:[payWay stringByAppendingString:@"&"]]];
    }
    if (![@"" isEqualToString:iRate]) {
        urlStr = [urlStr stringByAppendingString:[@"interestRate=" stringByAppendingFormat:@"%f&", [iRate floatValue]/100]];
    }
    if (choice) {
        urlStr = [urlStr stringByAppendingString:[@"pri=" stringByAppendingFormat:@"%@&", choice]];
    }
    urlStr = [urlStr stringByAppendingFormat:@"agio=%f&cash=%f&", yhzk, yhfx];
    
    NSLog(@"%@", urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request startSynchronous];
    NSError *error = [request error];
    // 网络连接成功
    if (!error) {
        NSData *calData = [request responseData];
        XMLParser *xmlParser = [XMLParser sharedInstance];
        NodeData *calNode = [xmlParser parseXMLFromData:calData];
        
        NSString *msg = [calNode leafForKey:@"message"];
        // 登录成功
        if (!msg) {
            NSMutableArray *projNodes = [[xmlParser parseXMLFromData:calData] objectsForKey:@"BEAN"];
            
            calNode = [projNodes objectAtIndex:0];;
            [_housePrice setText:[calNode leafForKey:@"housePrice"]];
            [_arangePrice setText:[calNode leafForKey:@"price"]];
            [_pay setText:[calNode leafForKey:@"pay"]];
            [_perCredit setText:[NSString stringWithFormat:@"%.2f%%", ([[_lendPrice text] floatValue]/[[calNode leafForKey:@"housePrice"] floatValue])*100]];
            [_accrual setText:[calNode leafForKey:@"accrual"]];
            [_perPay setText:[calNode leafForKey:@"perPay"]];
            
            _mList = [[NSMutableArray alloc] initWithCapacity:[projNodes count]];
            for (NodeData *projNode in projNodes) {
                if ([projNode leafForKey:@"descp"]) {
                    [_mList addObject:[NSArray arrayWithObjects:[projNode leafForKey:@"descp"], [projNode leafForKey:@"perPay"], nil]];
                }
            }
            [_mTable reloadData];
        }
        else {
            [av initWithTitle:@"计算器提示" message:msg delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
            [av show];
        }
    }
    else {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }

}

- (IBAction)payMonth:(id)sender {
}

- (void)dealloc {
    [_houseDesc release];
    [_houseArea release];
    [_unitPrice release];
    [_housePrice release];
    [_lendPrice release];
    [_lendLimit release];
    [_upProportion release];
    [_payMethod release];
    [_payType release];
    [_basicRate release];
    [_interestRate release];
    [_arangePrice release];
    [_pay release];
    [_perCredit release];
    [_accrual release];
    [_perPay release];
    [_totalPrice release];
    [_yhfs release];
    
    [_zkyxj release];
    [_zkyxjv release];
    [_mTable release];
    [_mList release];
    
    [super dealloc];
}

#pragma mark text file methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}

- (void)setChoice:(NSString *)name val:(NSString *)val
{
    choice = val;
    [_zkyxjv setText:name];
    
    [_zkyxj setHidden:NO];
    [_zkyxjv setHidden:NO];
}

- (void)setPay:(NSString *)name val:(NSString *)val
{
    payWay = val;
    [_cField setText:name];
}

- (void)setLearn:(NSString *)name val:(NSString *)val
{
    learn = val;
    [_cField setText:name];
    
    [_basicRate setText:[NSString stringWithFormat:@"%.2f%%", [val floatValue]*100]];
//    [_interestRate setText:[NSString stringWithFormat:@"%.2f%%", [val floatValue]*100+[[_upProportion text] floatValue]]];
    [_interestRate setText:[NSString stringWithFormat:@"%.2f%%", [val floatValue]*100*(1+[[_upProportion text] floatValue]/100)]];
}

- (void)setYh
{
    
}

- (void)setYh:(NSString *)yhtj zk:(float)zk fx:(float)fx
{
    yhzk = zk;
    yhfx = fx;
    [_yhfs setText:yhtj];
}

- (void)setLl
{
    
}

- (void)valueTableViewControllerDidFinish:(CalValueViewController *)controller
{
    [_calvPopoverController dismissPopoverAnimated:YES];
}

- (void)setValue {
    CalValueViewController *valueTableView = [[[CalValueViewController alloc] initWithNibName:@"CalValueViewController" bundle:nil] autorelease];
    valueTableView.delegate = self;
    
    self.calvPopoverController = [[[UIPopoverController alloc] initWithContentViewController:valueTableView] autorelease];
    
    Calculator *cal = [Calculator sharedInstance];
    if ([@"0" isEqualToString:[cal type]] || [@"1" isEqualToString:[cal type]]) {
        [self.calvPopoverController setPopoverContentSize:CGSizeMake(150, 88)];
    }
    else {
        [self.calvPopoverController setPopoverContentSize:CGSizeMake(500, 320)];
    }
    
    [self.calvPopoverController presentPopoverFromRect:[_cField frame] inView:[self view] permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark -
#pragma mark UITableView data source and delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_mList count];
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
	static NSString *monthID = @"monthID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:monthID];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:monthID] autorelease];
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
	NSArray *mArr = [_mList objectAtIndex:indexPath.row];
	cell.textLabel.text = [mArr objectAtIndex:0];
    cell.detailTextLabel.text = [[mArr objectAtIndex:1] stringByAppendingString:@"元"];
    
	return cell;
}

@end
