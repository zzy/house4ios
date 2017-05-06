//
//  MarketBasicViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-8.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "MarketBasicViewController.h"

#import "OudsAppDelegate.h"
#import "XMLParser.h"
#import "NodeData.h"
#import "ASIHTTPRequest.h"

@implementation MarketBasicViewController

@synthesize type = _type;
@synthesize modelArea = _modelArea;
@synthesize publicApportion = _publicApportion;
@synthesize managerPrice = _managerPrice;
@synthesize fitment = _fitment;
@synthesize openingTime = _openingTime;
@synthesize handTime = _handTime;
@synthesize area = _area;
@synthesize totalArea = _totalArea;
@synthesize countHouse = _countHouse;
@synthesize cubage = _cubage;
@synthesize density = _density;
@synthesize virescence = _virescence;
@synthesize parking = _parking;
@synthesize time = _time;
@synthesize mainModel = _mainModel;
@synthesize priceBetween = _priceBetween;
@synthesize averagePrice = _averagePrice;
@synthesize projectPlan = _projectPlan;
@synthesize sellMeans = _sellMeans;
@synthesize buildDesign = _buildDesign;
@synthesize sightDesign = _sightDesign;
@synthesize manager = _manager;
@synthesize sellProxy = _sellProxy;
@synthesize ad = _ad;
@synthesize makeModel = _makeModel;

@synthesize projName = _projName;
//@synthesize market = _market;

- (void) transferMarket:(MarketViewController *)currentView
{
//    _market = [currentView market];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"基本信息";
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
    
//    self transferMarket:<#(MarketViewController *)#>
    
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
        [_type setText:[marketNode leafForKey:@"type"]];
        [_modelArea setText:[marketNode leafForKey:@"modelArea"]];
        [_publicApportion setText:[marketNode leafForKey:@"publicApportion"]];
        [_managerPrice setText:[marketNode leafForKey:@"managerPrice"]];
        [_fitment setText:[marketNode leafForKey:@"fitment"]];
        [_openingTime setText:[marketNode leafForKey:@"openingTime"]];
        [_handTime setText:[marketNode leafForKey:@"handTime"]];
        [_area setText:[marketNode leafForKey:@"area"]];
        [_totalArea setText:[marketNode leafForKey:@"totalArea"]];
        [_countHouse setText:[marketNode leafForKey:@"countHouse"]];
        [_cubage setText:[marketNode leafForKey:@"cubage"]];
        [_density setText:[marketNode leafForKey:@"density"]];
        [_virescence setText:[marketNode leafForKey:@"virescence"]];
        [_parking setText:[marketNode leafForKey:@"parking"]];
        [_time setText:[marketNode leafForKey:@"time"]];
        [_mainModel setText:[marketNode leafForKey:@"mainModel"]];
        [_priceBetween setText:[marketNode leafForKey:@"priceBetween"]];
        [_averagePrice setText:[marketNode leafForKey:@"averagePrice"]];
        [_projectPlan setText:[marketNode leafForKey:@"projectPlan"]];
        [_sellMeans setText:[marketNode leafForKey:@"sellMeans"]];
        [_buildDesign setText:[marketNode leafForKey:@"buildDesign"]];
        [_sightDesign setText:[marketNode leafForKey:@"sightDesign"]];
        [_manager setText:[marketNode leafForKey:@"manager"]];
        [_sellProxy setText:[marketNode leafForKey:@"sellProxy"]];
        [_ad setText:[marketNode leafForKey:@"ad"]];
        [_makeModel setText:[marketNode leafForKey:@"makeModel"]];
    }
    else {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
    
}

- (void)viewDidUnload
{
    [self setProjName:nil];
    [self setType:nil];
    [self setModelArea:nil];
    [self setPublicApportion:nil];
    [self setManagerPrice:nil];
    [self setFitment:nil];
    [self setOpeningTime:nil];
    [self setHandTime:nil];
    [self setArea:nil];
    [self setTotalArea:nil];
    [self setCountHouse:nil];
    [self setCubage:nil];
    [self setDensity:nil];
    [self setVirescence:nil];
    [self setParking:nil];
    [self setTime:nil];
    [self setMainModel:nil];
    [self setPriceBetween:nil];
    [self setAveragePrice:nil];
    [self setProjectPlan:nil];
    [self setSellMeans:nil];
    [self setBuildDesign:nil];
    [self setSightDesign:nil];
    [self setManager:nil];
    [self setSellProxy:nil];
    [self setAd:nil];
    [self setMakeModel:nil];
    
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
//    [_market release];
    
    [_type release];
    [_modelArea release];
    [_publicApportion release];
    [_managerPrice release];
    [_fitment release];
    [_openingTime release];
    [_handTime release];
    [_area release];
    [_totalArea release];
    [_countHouse release];
    [_cubage release];
    [_density release];
    [_virescence release];
    [_parking release];
    [_time release];
    [_mainModel release];
    [_priceBetween release];
    [_averagePrice release];
    [_projectPlan release];
    [_sellMeans release];
    [_buildDesign release];
    [_sightDesign release];
    [_manager release];
    [_sellProxy release];
    [_ad release];
    [_makeModel release];
    
    [super dealloc];
}

@end
