//
//  CalValueViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-19.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import "CalValueViewController.h"

#import "Value.h"
#import "Calculator.h"

#import "ASIHTTPRequest.h"
#import "OudsAppDelegate.h"
#import "XMLParser.h"
#import "NodeData.h"

@implementation CalValueViewController

@synthesize delegate = _delegate;

@synthesize calvTable = _calvTable;
@synthesize calvList = _calvList;
@synthesize setZk = _setZk;
@synthesize setFx = _setFx;
@synthesize zklabel = _zklabel;
@synthesize fxlabel = _fxlabel;

static NSMutableDictionary *yhDic;
static NSString *yhtj;

static float yhzk = 0;
static float yhfx = 0;

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
    
    _calvList = [[NSMutableArray alloc] init];
    Calculator *cal = [Calculator sharedInstance];
    
    if ([@"-1" isEqualToString:[cal type]]) {
        OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
        
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
            NSData *valueData = [request responseData];
            XMLParser *xmlParser = [XMLParser sharedInstance];
            
            NSMutableArray *valueNodes = [[xmlParser parseXMLFromData:valueData] objectsForKey:@"BEAN"];
            for (NodeData *valueNode in valueNodes) {
                if (valueNode && [valueNode leafForKey:@"title"] && ![@"" isEqualToString:[valueNode leafForKey:@"title"]]) {
                    NSString *updateTime = [[[NSString alloc] initWithString:[valueNode leafForKey:@"time"]] autorelease];
                    if (10 <= [updateTime length]) {
                        updateTime = [updateTime substringToIndex:10];
                    }
                    
//                    valueList = [[NSMutableArray alloc] initWithArray:[valueStr componentsSeparatedByString:@"、"]];
                    
                    [_calvList addObject:[NSArray arrayWithObjects:[valueNode leafForKey:@"id"], [NSString stringWithFormat:@"%@ %@", [valueNode leafForKey:@"title"], updateTime], [valueNode leafForKey:@"type"], [valueNode leafForKey:@"price"], nil]];
                }
            }
        }
        else {
            UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
            [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
            [av show];
        }
        
        [self setZkv:nil];
        yhDic = [[NSMutableDictionary alloc] init];
    }
    
    if ([@"0" isEqualToString:[cal type]]) {
        [_calvList addObject:[NSArray arrayWithObjects:@"0", @"等额本金", nil]];
        [_calvList addObject:[NSArray arrayWithObjects:@"1", @"等额本息", nil]];
    }
    
    if ([@"1" isEqualToString:[cal type]]) {
        [_calvList addObject:[NSArray arrayWithObjects:@"0", @"商业贷款", nil]];
        [_calvList addObject:[NSArray arrayWithObjects:@"1", @"公积金贷款", nil]];
    }
    
    yhzk = 0;
    yhfx = 0;
}

- (void)viewDidUnload
{
    [self setCalvTable:nil];
    [self setCalvList:nil];
    
    [self setSetZk:nil];
    [self setSetFx:nil];
    [self setZkv:nil];
    [self setFxv:nil];
    [self setZklabel:nil];
    [self setFxlabel:nil];
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
    [_calvTable release];
    [_calvList release];
    
    [_setZk release];
    [_setFx release];
    
    [_zklabel release];
    [_fxlabel release];
    [super dealloc];
}

#pragma mark -
#pragma mark UITableView data source and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    return [_calvList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *calvID = @"calvID";
    
	Calculator *cal = [Calculator sharedInstance];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:calvID];
	if ([@"-1" isEqualToString:[cal type]]) {
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:calvID] autorelease];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        [tableView setFrame:CGRectMake(-80, 0, tableView.frame.size.width+80, tableView.frame.size.height)];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    else {
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:calvID] autorelease];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
	NSArray *calArr = [_calvList objectAtIndex:indexPath.row];
    
    if ([@"-1" isEqualToString:[cal type]]) {
        [cell.textLabel setText:@"√"];
        [cell.detailTextLabel setText:[calArr objectAtIndex:1]];
        
        
        [cell.textLabel setTextColor:[UIColor whiteColor]];
    }
    else {
        [cell.textLabel setText:[calArr objectAtIndex:1]];
        [cell.detailTextLabel setText:[calArr objectAtIndex:0]];
    //    [cell.detailTextLabel setHidden:YES];
    }
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    _customerFormView = [CustomerFormViewController sharedInstance];
    NSArray *calArr = [_calvList objectAtIndex:indexPath.row];
    
    Calculator *cal = [Calculator sharedInstance];
    if ([@"-1" isEqualToString:[cal type]]) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if ([UIColor redColor] == [[cell textLabel] textColor]) {
            [cell.textLabel setTextColor:[UIColor whiteColor]];
        }
        else {
            [cell.textLabel setTextColor:[UIColor redColor]];
        }
        
        if ([UIColor redColor] == [[cell textLabel] textColor]) {
            if ([@"0" isEqualToString:[calArr objectAtIndex:2]]) {
                yhzk += [[calArr objectAtIndex:3] floatValue];
            }
            else {
                yhfx += [[calArr objectAtIndex:3] floatValue];
            }
            
            [self setDic:[calArr objectAtIndex:1] key:[calArr objectAtIndex:0] type:@"1"];
        }
        else {
            if ([@"0" isEqualToString:[calArr objectAtIndex:2]]) {
                yhzk -= [[calArr objectAtIndex:3] floatValue];
            }
            else {
                yhfx -= [[calArr objectAtIndex:3] floatValue];
            }
            
            [self setDic:[calArr objectAtIndex:1] key:[calArr objectAtIndex:0] type:@"0"];
        }
    }
    else {
        if ([@"0" isEqualToString:[cal type]]) {
            [self.delegate setPay:[calArr objectAtIndex:1] val:[calArr objectAtIndex:0]];
        }
        
        if ([@"1" isEqualToString:[cal type]]) {
            [self.delegate setLearn:[calArr objectAtIndex:1] val:[self getLl:[calArr objectAtIndex:0] limit:[cal lendLimit]]];
        }
        
        [self.delegate valueTableViewControllerDidFinish:self];
    }
}

- (IBAction)setZkv:(id)sender {
    [_setFx setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_setZk setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [self.delegate setChoice:[_zklabel text] val:@"0"];
}

- (IBAction)setFxv:(id)sender {
    [_setZk setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_setFx setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [self.delegate setChoice:[_fxlabel text] val:@"1"];
}

- (IBAction)closeYh:(id)sender {
    yhtj = [[NSString alloc] initWithString:@""];
    
    for (NSString *key in [yhDic allKeys]) {
        yhtj = [yhtj stringByAppendingFormat:@"%@;", [yhDic valueForKey:key]];
    }
    
    [self.delegate setYh:yhtj zk:yhzk fx:yhfx];
    
    [self.delegate valueTableViewControllerDidFinish:self];
}

- (void)setDic:(NSString *)val key:(NSString *)key type:(NSString *)type
{
    if ([@"1" isEqualToString:type]) {
        [yhDic setObject:val forKey:key];
    }
    else {
        if ([yhDic objectForKey:key]) {
            [yhDic removeObjectForKey:key];
        }
    }
}

- (NSString *)getLl:(NSString *)llt limit:(NSString *)limit
{
    NSString *rate = [[[NSString alloc] initWithString:@"0"] autorelease];
    
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
    
    if ([@"1" isEqualToString:llt]) {
        urlStr = [urlStr stringByAppendingString:@"/public/calculator/accumulationFund_baseInterestRate/"];
    }
    else {
        urlStr = [urlStr stringByAppendingString:@"/public/calculator/business_baseInterestRate/"];
    }
    
    urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
    urlStr = [urlStr stringByAppendingFormat:@"&lendLimit=%@", limit];
    NSLog(@"%@", urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request startSynchronous];
    NSError *error = [request error];
    // 网络连接成功
    if (!error) {
        NSData *valueData = [request responseData];
        XMLParser *xmlParser = [XMLParser sharedInstance];
        
        rate = [NSString stringWithString:[[xmlParser parseXMLFromData:valueData] leafForKey:@"message"]];
    }
    else {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    
    return rate;
}
                             
@end
