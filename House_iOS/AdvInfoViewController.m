//
//  AdvInfoViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-9.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import "AdvInfoViewController.h"

#import "AdvInfo.h"

@implementation AdvInfoViewController

@synthesize wcjhx = _wcjhx;
@synthesize wcjxm = _wcjxm;
@synthesize cV = _cV;
@synthesize policy = _policy;

@synthesize delegate = _delegate;
@synthesize advTitle = _advTitle;
@synthesize time = _time;
@synthesize modeDemand = _modeDemand;
@synthesize areaDemand = _areaDemand;
@synthesize callPoint = _callPoint;
@synthesize visitIntent = _visitIntent;
@synthesize sellerName = _sellerName;
@synthesize phoneV = _phoneV;
@synthesize visitV = _visitV;
@synthesize intention = _intention;
@synthesize totalAcceptPrice = _totalAcceptPrice;
@synthesize visitPoint = _visitPoint;
@synthesize firstCase = _firstCase;
@synthesize bargain = _bargain;
@synthesize unbargainElse = _unbargainElse;
@synthesize sellerNameV = _sellerNameV;
@synthesize revisitV = _revisitV;
@synthesize reVisitType = _reVisitType;
@synthesize reVisitDesc = _reVisitDesc;
@synthesize hiV = _hiV;
@synthesize feastDay = _feastDay;
@synthesize clientUuid = _clientUuid;
@synthesize content = _content;
@synthesize response = _response;

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

//- (void)loadView
//{
//    CGRect appFrame = CGRectMake(184, 450, 400, 300);
//	UIView *view = [[UIView alloc] initWithFrame:appFrame];
//	self.view = view;
//	[view release];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AdvInfo *adv = [AdvInfo sharedInstance];
    
    [_advTitle setTitle:[NSString stringWithFormat:@"%@ %@%@", [adv name], [adv type], @"信息"]];
    [_time setText:[adv time]];
    
    if ([[adv type] isEqualToString:@"来电"]) {
        [_modeDemand setText:[adv modeDemand]];
        [_areaDemand setText:[adv areaDemand]];;
        [_callPoint setText:[adv callPoint]];
        [_visitIntent setText:[adv visitIntent]];
        [_sellerName setText:[adv sellerName]];
        
        [_phoneV setHidden:NO];
    }
    
    if ([[adv type] isEqualToString:@"来访"]) {
        [_intention setText:[adv intention]];
        [_totalAcceptPrice setText:[adv totalAcceptPrice]]; // stringByAppendingString:@"万元"]];
        [_visitPoint setText:[adv visitPoint]];
        [_firstCase setText:[adv firstCase]];
        [_bargain setText:[adv bargain]];
        [_unbargainElse setText:[adv unbargainElse]];
        [_sellerNameV setText:[adv sellerName]];
        [_wcjhx setText:[adv wcjhx]];
        [_wcjxm setText:[adv wcjxm]];
        
        [_visitV setHidden:NO];
    }
    
    if ([[adv type] isEqualToString:@"回访"]) {
        [_reVisitType setText:[adv reVisitType]];
        [_reVisitDesc setText:[adv reVisitDesc]];
        
        [_revisitV setHidden:NO];
    }
    
    if ([[adv type] isEqualToString:@"问候"]) {
        [_feastDay setText:[adv feastDay]];
        [_clientUuid setText:[adv clientUuid]];
        [_content setText:[adv content]];
        [_response setText:[adv response]];
        
        [_hiV setHidden:NO];
    }
    
    if ([[adv type] isEqualToString:@"策略"]) {
        [_policy setText:[adv content]];
        
        [_cV setHidden:NO];
    }
    
    self.view.frame = CGRectMake(186, 450, 400, 300);
}

- (void)viewDidUnload
{
    [self setAdvTitle:nil];
    
    [self setTime:nil];
    [self setModeDemand:nil];
    [self setAreaDemand:nil];
    [self setCallPoint:nil];
    [self setVisitIntent:nil];
    [self setSellerName:nil];
    [self setPhoneV:nil];
    [self setVisitV:nil];
    [self setIntention:nil];
    [self setTotalAcceptPrice:nil];
    [self setVisitPoint:nil];
    [self setFirstCase:nil];
    [self setBargain:nil];
    [self setUnbargainElse:nil];
    [self setSellerNameV:nil];
    [self setRevisitV:nil];
    [self setReVisitType:nil];
    [self setReVisitDesc:nil];
    [self setHiV:nil];
    [self setFeastDay:nil];
    [self setClientUuid:nil];
    [self setContent:nil];
    [self setResponse:nil];
    [self setWcjhx:nil];
    [self setWcjxm:nil];
    [self setPolicy:nil];
    [self setCV:nil];
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
    [_advTitle release];
    
    [_time release];
    [_modeDemand release];
    [_areaDemand release];
    [_callPoint release];
    [_visitIntent release];
    [_sellerName release];
    [_phoneV release];
    [_visitV release];
    [_intention release];
    [_totalAcceptPrice release];
    [_visitPoint release];
    [_firstCase release];
    [_bargain release];
    [_unbargainElse release];
    [_sellerNameV release];
    [_revisitV release];
    [_reVisitType release];
    [_reVisitDesc release];
    [_hiV release];
    [_feastDay release];
    [_clientUuid release];
    [_content release];
    [_response release];
    [_wcjhx release];
    [_wcjxm release];
    [_policy release];
    [_cV release];
    [super dealloc];
}

- (IBAction)close:(id)sender {
    [self.delegate advViewControllerDidFinish:self];
}

@end
