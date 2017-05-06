//
//  MarketSysViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-8.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "MarketSysViewController.h"

#import "OudsAppDelegate.h"
#import "XMLParser.h"
#import "NodeData.h"
#import "Market.h"
#import "ASIHTTPRequest.h"

@implementation MarketSysViewController

@synthesize projName = _projName;
@synthesize ageFrame = _ageFrame;
@synthesize buyUse = _buyUse;
@synthesize work = _work;
@synthesize clientFrom = _clientFrom;
@synthesize summarize = _summarize;
@synthesize sellSay = _sellSay;
@synthesize sellAd = _sellAd;
@synthesize spreadPackaging = _spreadPackaging;
@synthesize spreadSell = _spreadSell;
@synthesize spreadAd = _spreadAd;
@synthesize itemGood = _itemGood;
@synthesize itemBad = _itemBad;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"分析评价";
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
    NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
    urlStr = [urlStr stringByAppendingString:@"/security/rival/getRivalList/"];
    urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
    urlStr = [urlStr stringByAppendingString:[@"&id=" stringByAppendingString:[market mkID]]];
    NSLog(@"%@", urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request startSynchronous];
    NSError *error = [request error];
    // 网络连接成功
    if (!error) {
        NSData *marketData = [request responseData];
        XMLParser *xmlParser = [XMLParser sharedInstance];
        NodeData *marketNode = [[xmlParser parseXMLFromData:marketData] objectForKey:@"BEAN"];
        
        [_projName setText:[marketNode leafForKey:@"name"]];
        [_ageFrame setText:[marketNode leafForKey:@"type"]];
        [_buyUse setText:[marketNode leafForKey:@"modelArea"]];
        [_work setText:[marketNode leafForKey:@"publicApportion"]];
        [_clientFrom setText:[marketNode leafForKey:@"managerPrice"]];
        [_summarize setText:[marketNode leafForKey:@"summarize"]];
        [_sellSay setText:[marketNode leafForKey:@"openingTime"]];
        [_sellAd setText:[marketNode leafForKey:@"handTime"]];
        [_spreadPackaging setText:[marketNode leafForKey:@"area"]];
        [_spreadSell setText:[marketNode leafForKey:@"totalArea"]];
        [_spreadAd setText:[marketNode leafForKey:@"countHouse"]];
        [_itemGood setText:[marketNode leafForKey:@"cubage"]];
        [_itemBad setText:[marketNode leafForKey:@"density"]];
    }
    else {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
}

- (void)viewDidUnload
{
    [self setProjName:nil];
    [self setAgeFrame:nil];
    [self setBuyUse:nil];
    [self setWork:nil];
    [self setClientFrom:nil];
    [self setSummarize:nil];
    [self setSellSay:nil];
    [self setSellAd:nil];
    [self setSpreadPackaging:nil];
    [self setSpreadSell:nil];
    [self setSpreadAd:nil];
    [self setItemGood:nil];
    [self setItemBad:nil];
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
    [_ageFrame release];
    [_buyUse release];
    [_work release];
    [_clientFrom release];
    [_summarize release];
    [_sellSay release];
    [_sellAd release];
    [_spreadPackaging release];
    [_spreadSell release];
    [_spreadAd release];
    [_itemGood release];
    [_itemBad release];
    
    [super dealloc];
}
@end
