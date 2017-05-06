//
//  AgeTableViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-16.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "ValueTableViewController.h"

#import "OudsAppDelegate.h"
#import "ASIHTTPRequest.h"
#import "NodeData.h"
#import "XMLParser.h"

#import "CustomerFormViewController.h"
#import "Value.h"

@implementation ValueTableViewController

@synthesize delegate = _delegate;
@synthesize customerFormView = _customerFormView;
@synthesize valueList = _valueList;

static NSString *vID;
static NSMutableDictionary *vDic;
static NSString *vv;

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
    
    Value *val = [Value sharedInstance];
    vID = [val vID];
    
//    if ([@"HUO_ZHI_TU_JING" isEqualToString:vID]) {
//        [tableView setMultipleTouchEnabled:YES];
//        //        tableView setse
//    }
    
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
    urlStr = [urlStr stringByAppendingString:@"/public/sys/getSys/"];
    urlStr = [urlStr stringByAppendingString:[@"?name=" stringByAppendingString:vID]];
    
    NSLog(@"%@", urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request startSynchronous];
    NSError *error = [request error];
    // 网络连接成功
    if (!error) {
        NSData *valueData = [request responseData];
        XMLParser *xmlParser = [XMLParser sharedInstance];
        
        NodeData *valueNode = [[xmlParser parseXMLFromData:valueData] objectForKey:@"BEAN"];
        if (valueNode && [valueNode leafForKey:@"val"]) {
            NSString *valueStr = [[NSString alloc] initWithString:[valueNode leafForKey:@"val"]];
            
            _valueList = [[NSMutableArray alloc] initWithArray:[valueStr componentsSeparatedByString:@"、"]];
        }
    }
    else {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    
    vDic = [[NSMutableDictionary alloc] init];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark UITableView data source and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    return [_valueList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *valueID = @"valueID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:valueID];
    
    if ([@"HUO_ZHI_TU_JING" isEqualToString:vID] || 
        [@"KE_HE_ZI_XUN_DIAN_CALL" isEqualToString:vID] || 
        [@"KE_HE_ZI_XUN_DIAN_VISIT" isEqualToString:vID] ||
        [@"WEI_CHENG_JIAO_XING_MU" isEqualToString:vID] ||
        [@"WEI_CHENG_JIAO_HUXING" isEqualToString:vID]) {
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:valueID] autorelease];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        [tableView setFrame:CGRectMake(-80, 0, tableView.frame.size.width+80, tableView.frame.size.height)];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    else {
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:valueID] autorelease];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    NSString *value = [_valueList objectAtIndex:indexPath.row];
    if ([@"HUO_ZHI_TU_JING" isEqualToString:vID] || 
        [@"KE_HE_ZI_XUN_DIAN_CALL" isEqualToString:vID] || 
        [@"KE_HE_ZI_XUN_DIAN_VISIT" isEqualToString:vID] ||
        [@"WEI_CHENG_JIAO_XING_MU" isEqualToString:vID] ||
        [@"WEI_CHENG_JIAO_HUXING" isEqualToString:vID]) {
        [cell.textLabel setText:@"√"];
        [cell.detailTextLabel setText:value];
        
        
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        }
    else {
        cell.textLabel.text = value; //project.name;
    }
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *value = [_valueList objectAtIndex:indexPath.row];
    if ([@"HUO_ZHI_TU_JING" isEqualToString:vID] || 
        [@"KE_HE_ZI_XUN_DIAN_CALL" isEqualToString:vID] || 
        [@"KE_HE_ZI_XUN_DIAN_VISIT" isEqualToString:vID] ||
        [@"WEI_CHENG_JIAO_XING_MU" isEqualToString:vID] ||
        [@"WEI_CHENG_JIAO_HUXING" isEqualToString:vID]) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if ([UIColor redColor] == [[cell textLabel] textColor]) {
            [cell.textLabel setTextColor:[UIColor whiteColor]];
            
            [self setDic:value key:[NSString stringWithFormat:@"v%i", indexPath.row] type:@"0"];
        }
        else {
            [cell.textLabel setTextColor:[UIColor redColor]];
            
            [self setDic:value key:[NSString stringWithFormat:@"v%i", indexPath.row] type:@"1"];
        }
    }
    else {
    //    _customerFormView = [CustomerFormViewController sharedInstance];
        [self.delegate setValue:value];
    //    [[_customerFormView cField] setText:value];
        
        [self.delegate valueTableViewControllerDidFinish:self];
    }
}

- (void)dealloc {
    [_valueList release];
    
    [super dealloc];
}

- (IBAction)doChoose:(id)sender {
    vv = [[NSString alloc] initWithString:@""];
    
    for (NSString *key in [vDic allKeys]) {
        if (![@"" isEqualToString:[vDic valueForKey:key]]) {
            vv = [vv stringByAppendingFormat:@"%@、", [vDic valueForKey:key]];
        }
    }
    
    [self.delegate setValue:vv];
    
    [self.delegate valueTableViewControllerDidFinish:self];
}

- (void)setDic:(NSString *)val key:(NSString *)key type:(NSString *)type
{
    if ([@"1" isEqualToString:type]) {
        [vDic setObject:val forKey:key];
    }
    else {
        if ([vDic objectForKey:key]) {
            [vDic removeObjectForKey:key];
        }
    }
}

@end
