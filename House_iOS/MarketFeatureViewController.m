//
//  MarketFeatureViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-8.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "MarketFeatureViewController.h"

#import "OudsAppDelegate.h"
#import "XMLParser.h"
#import "NodeData.h"
#import "Market.h"
#import "ASIHTTPRequest.h"

@implementation MarketFeatureViewController

@synthesize rivalName = _rivalName;

@synthesize t1bmj = _t1bmj;
@synthesize t1cmj = _t1cmj;
@synthesize t1amj = _t1amj;
@synthesize t2amj = _t2amj;
@synthesize t2bmj = _t2bmj;
@synthesize t2cmj = _t2cmj;
@synthesize t3bmj = _t3bmj;
@synthesize t3amj = _t3amj;
@synthesize t3cmj = _t3cmj;
@synthesize t4bmj = _t4bmj;
@synthesize t1bts = _t1bts;
@synthesize t1cts = _t1cts;
@synthesize t1ats = _t1ats;
@synthesize t2ats = _t2ats;
@synthesize t2bts = _t2bts;
@synthesize t2cts = _t2cts;
@synthesize t3bts = _t3bts;
@synthesize t3ats = _t3ats;
@synthesize t3cts = _t3cts;
@synthesize t4ats = _t4ats;
@synthesize t4cts = _t4cts;
@synthesize t4bts = _t4bts;
@synthesize t1bzb = _t1bzb;
@synthesize t1czb = _t1czb;
@synthesize t1azb = _t1azb;
@synthesize t2azb = _t2azb;
@synthesize t2bzb = _t2bzb;
@synthesize t2czb = _t2czb;
@synthesize t3bzb = _t3bzb;
@synthesize t3azb = _t3azb;
@synthesize t3czb = _t3czb;
@synthesize t4azb = _t4azb;
@synthesize t4czb = _t4czb;
@synthesize t4bzb = _t4bzb;
@synthesize t4amj = _t4amj;
@synthesize t4cmj = _t4cmj;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"户型特点";
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
    
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    Market *market = [Market sharedInstance];
    [_rivalName setText:[market name]];
        
    NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
    urlStr = [urlStr stringByAppendingString:@"/security/rival/getAnalysisList/"];
    urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
    urlStr = [urlStr stringByAppendingString:[@"&rivalUuid=" stringByAppendingString:[market mkID]]];
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
        for (NodeData *marketNode in marketNodes) {
            if ([@"套一" isEqualToString:[marketNode leafForKey:@"modelType"]] && [@"B型" isEqualToString:[marketNode leafForKey:@"type"]]) {
                [_t1bmj setText:[marketNode leafForKey:@"areaBetween"]];
                [_t1bts setText:[marketNode leafForKey:@"totalHouse"]];
                [_t1bzb setText:[marketNode leafForKey:@"inverseProportion"]];
            }
            
            if ([@"套一" isEqualToString:[marketNode leafForKey:@"modelType"]] && [@"A型" isEqualToString:[marketNode leafForKey:@"type"]]) {
                [_t1amj setText:[marketNode leafForKey:@"areaBetween"]];
                [_t1ats setText:[marketNode leafForKey:@"totalHouse"]];
                [_t1azb setText:[marketNode leafForKey:@"inverseProportion"]];
            }
            
            if ([@"套一" isEqualToString:[marketNode leafForKey:@"modelType"]] && [@"C型" isEqualToString:[marketNode leafForKey:@"type"]]) {
                [_t1cmj setText:[marketNode leafForKey:@"areaBetween"]];
                [_t1cts setText:[marketNode leafForKey:@"totalHouse"]];
                [_t1czb setText:[marketNode leafForKey:@"inverseProportion"]];
            }
            
            if ([@"套二" isEqualToString:[marketNode leafForKey:@"modelType"]] && [@"B型" isEqualToString:[marketNode leafForKey:@"type"]]) {
                [_t2bmj setText:[marketNode leafForKey:@"areaBetween"]];
                [_t2bts setText:[marketNode leafForKey:@"totalHouse"]];
                [_t2bzb setText:[marketNode leafForKey:@"inverseProportion"]];
            }
            
            if ([@"套二" isEqualToString:[marketNode leafForKey:@"modelType"]] && [@"A型" isEqualToString:[marketNode leafForKey:@"type"]]) {
                [_t2amj setText:[marketNode leafForKey:@"areaBetween"]];
                [_t2ats setText:[marketNode leafForKey:@"totalHouse"]];
                [_t2azb setText:[marketNode leafForKey:@"inverseProportion"]];
            }
            
            if ([@"套二" isEqualToString:[marketNode leafForKey:@"modelType"]] && [@"C型" isEqualToString:[marketNode leafForKey:@"type"]]) {
                [_t2cmj setText:[marketNode leafForKey:@"areaBetween"]];
                [_t2cts setText:[marketNode leafForKey:@"totalHouse"]];
                [_t2czb setText:[marketNode leafForKey:@"inverseProportion"]];
            }
            
            if ([@"套三" isEqualToString:[marketNode leafForKey:@"modelType"]] && [@"B型" isEqualToString:[marketNode leafForKey:@"type"]]) {
                [_t3bmj setText:[marketNode leafForKey:@"areaBetween"]];
                [_t3bts setText:[marketNode leafForKey:@"totalHouse"]];
                [_t3bzb setText:[marketNode leafForKey:@"inverseProportion"]];
            }
            
            if ([@"套三" isEqualToString:[marketNode leafForKey:@"modelType"]] && [@"A型" isEqualToString:[marketNode leafForKey:@"type"]]) {
                [_t3amj setText:[marketNode leafForKey:@"areaBetween"]];
                [_t3ats setText:[marketNode leafForKey:@"totalHouse"]];
                [_t3azb setText:[marketNode leafForKey:@"inverseProportion"]];
            }
            
            if ([@"套三" isEqualToString:[marketNode leafForKey:@"modelType"]] && [@"C型" isEqualToString:[marketNode leafForKey:@"type"]]) {
                [_t3cmj setText:[marketNode leafForKey:@"areaBetween"]];
                [_t3cts setText:[marketNode leafForKey:@"totalHouse"]];
                [_t3czb setText:[marketNode leafForKey:@"inverseProportion"]];
            }
            
            if ([@"套四" isEqualToString:[marketNode leafForKey:@"modelType"]] && [@"B型" isEqualToString:[marketNode leafForKey:@"type"]]) {
                [_t4bmj setText:[marketNode leafForKey:@"areaBetween"]];
                [_t4bts setText:[marketNode leafForKey:@"totalHouse"]];
                [_t4bzb setText:[marketNode leafForKey:@"inverseProportion"]];
            }
            
            if ([@"套四" isEqualToString:[marketNode leafForKey:@"modelType"]] && [@"A型" isEqualToString:[marketNode leafForKey:@"type"]]) {
                [_t4amj setText:[marketNode leafForKey:@"areaBetween"]];
                [_t4ats setText:[marketNode leafForKey:@"totalHouse"]];
                [_t4azb setText:[marketNode leafForKey:@"inverseProportion"]];
            }
            
            if ([@"套四" isEqualToString:[marketNode leafForKey:@"modelType"]] && [@"C型" isEqualToString:[marketNode leafForKey:@"type"]]) {
                [_t4cmj setText:[marketNode leafForKey:@"areaBetween"]];
                [_t4cts setText:[marketNode leafForKey:@"totalHouse"]];
                [_t4czb setText:[marketNode leafForKey:@"inverseProportion"]];
            }
        }
    }
    else {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
}

- (void)viewDidUnload
{
    [self setRivalName:nil];
    
    [self setT1bmj:nil];
    [self setT1cmj:nil];
    [self setT1amj:nil];
    [self setT2amj:nil];
    [self setT2bmj:nil];
    [self setT2cmj:nil];
    [self setT3bmj:nil];
    [self setT3amj:nil];
    [self setT3cmj:nil];
    [self setT4amj:nil];
    [self setT4bmj:nil];
    [self setT4cmj:nil];
    
    [self setT1bts:nil];
    [self setT1cts:nil];
    [self setT1ats:nil];
    [self setT2ats:nil];
    [self setT2bts:nil];
    [self setT2cts:nil];
    [self setT3bts:nil];
    [self setT3ats:nil];
    [self setT3cts:nil];
    [self setT4ats:nil];
    [self setT4cts:nil];
    [self setT4bts:nil];
    [self setT1bzb:nil];
    [self setT1czb:nil];
    [self setT1azb:nil];
    [self setT2azb:nil];
    [self setT2bzb:nil];
    [self setT2czb:nil];
    [self setT3bzb:nil];
    [self setT3azb:nil];
    [self setT3czb:nil];
    [self setT4azb:nil];
    [self setT4czb:nil];
    [self setT4bzb:nil];
    
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
    [_rivalName release];
    
    [_t1bmj release];
    [_t1cmj release];
    [_t1amj release];
    [_t2amj release];
    [_t2bmj release];
    [_t2cmj release];
    [_t3bmj release];
    [_t3amj release];
    [_t3cmj release];
    [_t4amj release];
    [_t4bmj release];
    [_t4cmj release];
    
    [_t1bts release];
    [_t1cts release];
    [_t1ats release];
    [_t2ats release];
    [_t2bts release];
    [_t2cts release];
    [_t3bts release];
    [_t3ats release];
    [_t3cts release];
    [_t4ats release];
    [_t4cts release];
    [_t4bts release];
    [_t1bzb release];
    [_t1czb release];
    [_t1azb release];
    [_t2azb release];
    [_t2bzb release];
    [_t2czb release];
    [_t3bzb release];
    [_t3azb release];
    [_t3czb release];
    [_t4azb release];
    [_t4czb release];
    [_t4bzb release];
    
    [super dealloc];
}
@end
