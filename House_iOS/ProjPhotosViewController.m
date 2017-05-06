//
//  ProjPhotosViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-9.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "ProjPhotosViewController.h"

#import "OudsAppDelegate.h"
#import "PlatformViewController.h"
#import "ShowImgViewController.h"
#import "ZoomViewController.h"
#import "Photo.h"
#import "ASIHTTPRequest.h"

@implementation ProjPhotosViewController

@synthesize navBtn = _navBtn;

@synthesize nameTab = _nameTab;
@synthesize nameList = _nameList;
@synthesize spL = _spL;

@synthesize preBtn = _preBtn;
@synthesize nextBtn = _nextBtn;

@synthesize zoomView = _zoomView;
@synthesize imgView = _imgView;

@synthesize platformView = _platformView;
@synthesize name = _name;

static int crtImg;
static int picCnt;

static UIImage *image;

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
    // Do any additional setup after loading the view from its nib.
    
    Photo *pht = [Photo sharedInstance];
    _nameList = [[NSMutableArray alloc] initWithArray:[pht pArr]];
    
    [_name setTitle:[pht name]];
    picCnt = [[pht pArr] count];
    
    if ([@"1" isEqualToString:[pht isB]]) {
        [_preBtn setTitle:@"上一页" forState:UIControlStateNormal];
        [_nextBtn setTitle:@"下一页" forState:UIControlStateNormal];
    }
    else {
        [_navBtn setHidden:YES];
        [_nameTab setHidden:YES];
        [_spL setHidden:YES];
        
        _zoomView.frame = CGRectMake(0, 44, 768, 871);
        _imgView.frame = CGRectMake(0, 0, 768, 871);
        _preBtn.frame = CGRectMake(0, 916, 380, 40);
        _nextBtn.frame = CGRectMake(388, 916, 380, 40);
        
        [_preBtn setTitle:@"上一层" forState:UIControlStateNormal];
        [_nextBtn setTitle:@"下一层" forState:UIControlStateNormal];
    }
    
    if ([[pht pArr] count] > 0) {
        crtImg = 0;
        [self getPic];
        
        if (![_nameTab isHidden]) {
            [_nameTab selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
    
    if ([[pht pArr] count] > 1) {
        [_nextBtn setHidden:NO];
    }
}

- (void)getPic
{
    Photo *pht = [Photo sharedInstance];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", [pht path], [[pht pArr] objectAtIndex:crtImg]];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8)];
    NSLog(@"%@", urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request startSynchronous];
    NSError *error = [request error];
    // 网络连接成功
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    if (!error) {
        NSData *projData = [request responseData];
        
        if ([projData length] < 1200000) {
            [_zoomView removeGestureRecognizer:pinchGesture];
            [_zoomView removeGestureRecognizer:panGesture];
//            NSString *oPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//            if (!oPath) {
//                UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
//                
//                [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:@"图片存储本地失败，无法读取本机环境！\n" delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
//                [av show];
//            }
//            else {
//                NSString *oPlist = [oPath stringByAppendingPathComponent:[[pht pArr] objectAtIndex:crtImg]];
//                [projData writeToFile:oPlist atomically:NO];
//            }
            
            image = [[UIImage alloc] initWithData:projData];
//            [projData release];
//            [_imgView sizeToFit];
//            [_imgView reloadInputViews];
            [_imgView setImage:image];
//            [_imgView resignFirstResponder];
//            [_imgView setFrame:CGRectMake(0, 0, 650, 920)];
            [image release];
//            [_zoomView setFrame:CGRectMake(118, 44, 650, 920)];
//            [_zoomView sizeToFit];
            [self addGestureRecognizersToPiece:_zoomView];
//            [_zoomView reloadInputViews];
//            [_zoomView resignFirstResponder];
        }
        else {
            [self preImg:nil];
            
            [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:@"无法浏览！因图片过大，移动终端内存不足！\n" delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
            [av show];
        }
    }
    else {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
}

- (void)viewDidUnload
{
    [self setImgView:nil];
    [self setName:nil];
    
    [self setPreBtn:nil];
    [self setNextBtn:nil];
    [self setZoomView:nil];
    [self setNameTab:nil];
    [self setNameList:nil];
    
    [self setSpL:nil];
    [self setNavBtn:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)platform:(id)sender
{
    // 跳转到工作平台界面
//    _platformView = [PlatformViewController sharedInstance];
    _platformView = [[PlatformViewController alloc] initWithNibName:@"PlatformViewController" bundle:[NSBundle mainBundle]];
//    
//    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate]; 
//    [oad.window setRootViewController:_platformView];
//    [oad.window makeKeyAndVisible];
    [self.view addSubview:_platformView.view];
}

- (IBAction)closeMe:(id)sender {
//    [image release];
//    [_imgView release];
//    [_name release];
//    
//    [_preBtn release];
//    [_nextBtn release];
//    [_zoomView release];
//    
//    [_nameTab release];
//    [_nameList release];
//    
//    [_spL release];
//    [_navBtn release];
    
    [self.view removeFromSuperview];
    [self release];
//    [self dealloc];

}

- (IBAction)showApImg:(id)sender {
//    _showImgView = [[ShowImgViewController alloc] initWithNibName:@"ShowImgViewController" bundle:[NSBundle mainBundle]];
//	[self.view addSubview:_showImgView.view];
    Photo *photo = [Photo sharedInstance];
    [photo setPath:@"ap.png"];
    
//    [self showZoomView];
}

- (IBAction)showBpImg:(id)sender {
    Photo *photo = [Photo sharedInstance];
    [photo setPath:@"bp.png"];
    
//    [self showZoomView];
}

- (IBAction)showCpImg:(id)sender {
    Photo *photo = [Photo sharedInstance];
    [photo setPath:@"cp.png"];
    
//    [self showZoomView];
}

- (IBAction)showDpImg:(id)sender {
    Photo *photo = [Photo sharedInstance];
    [photo setPath:@"dp.png"];
    
//    [self showZoomView];
}

- (void)showZoomView {
//    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
//    _zoomView = [[[ZoomViewController alloc] init] autorelease];
//    _showImgView = [[ShowImgViewController alloc] initWithNibName:@"ShowImgViewController" bundle:[NSBundle mainBundle]];
    //	[self.view addSubview:_showImgView.view];
//    oad.window.rootViewController = _showImgView;
//    [oad.window makeKeyAndVisible];
//    [self.view addSubview:_zoomView.view];
}

- (IBAction)preImg:(id)sender {
    crtImg -= 1;
    
    [_nextBtn setHidden:NO];
    if (0 == crtImg) {
        [_preBtn setHidden:YES];
    }
    
    [self getPic];
    [_nameTab selectRowAtIndexPath:[NSIndexPath indexPathForRow:crtImg inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

- (IBAction)mextImg:(id)sender {
    crtImg += 1;
    
    [_preBtn setHidden:NO];
    if (crtImg == picCnt-1) {
        [_nextBtn setHidden:YES];
    }
    
    [self getPic];
    [_nameTab selectRowAtIndexPath:[NSIndexPath indexPathForRow:crtImg inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

- (void)dealloc {
    [_imgView release];
    [_name release];
    
    [_preBtn release];
    [_nextBtn release];
    [_zoomView release];
    
    [_nameTab release];
    [_nameList release];
    
    [_spL release];
    [_navBtn release];
    
    [super dealloc];
}

#pragma mark -
#pragma mark UITableView data source and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    int tabCount = 0;
//    switch ([tableView tag]) {
//        case 1:
//            tabCount = [_customerList count];
//            
//            break;
//        case 2:
//            tabCount = [_advList count];
//            
//            break;
//        case 3:
//            tabCount = [_meanList count];
//            
//            break;
//        case 4:
//            tabCount = [_serList count];
//            
//            break;
//    }
//    
//    return tabCount;
    return [_nameList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (4 != [tableView tag]) {
//        UITableViewCell *cell;
//        switch ([tableView tag]) {
//            case 1:{
//                static NSString *cstID = @"cstID";
//                
//                cell = [tableView dequeueReusableCellWithIdentifier:cstID];
//                if (cell == nil)
//                {
//                    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cstID] autorelease];
//                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//                }
//                
//                Customer *customer = [_customerList objectAtIndex:indexPath.row];
//                
//                //    NSString *updateTime = [[NSString alloc] initWithString:@""];
//                //	if (nil != [customer updateTime]) {
//                //        updateTime = [updateTime stringByAppendingString:[customer updateTime]];
//                //    }
//                //    cell.textLabel.text = [[customer name] stringByAppendingString:updateTime];
//                
//                cell.textLabel.text = [customer name];
//                cell.detailTextLabel.text = [customer updateTime];
//                
//                break;
//            }
//            case 2:{
//                static NSString *advID = @"advID";
//                
//                cell = [tableView dequeueReusableCellWithIdentifier:advID];
//                if (cell == nil)
//                {
//                    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:advID] autorelease];
//                    cell.accessoryType = UITableViewCellAccessoryNone;
//                }
//                
//                AdvInfo *adv = [_advList objectAtIndex:indexPath.row];
//                
//                cell.textLabel.text = [adv type];
//                cell.detailTextLabel.text = [adv time];
//                
//                break;
//            }
//            case 3:{
//                static NSString *meanID = @"meanID";
//                
//                cell = [tableView dequeueReusableCellWithIdentifier:meanID];
//                if (cell == nil)
//                {
//                    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:meanID] autorelease];
//                    cell.accessoryType = UITableViewCellAccessoryNone;
//                }
//                
//                NSArray *mArr = [_meanList objectAtIndex:indexPath.row];
//                
//                cell.textLabel.text = [mArr objectAtIndex:0];
//                [cell.textLabel setTextColor:[UIColor blueColor]];
//                [cell.textLabel setFont:[UIFont systemFontOfSize:17]];
//                
//                cell.detailTextLabel.text = [mArr objectAtIndex:1];
//                [cell.detailTextLabel setTextColor:[UIColor blackColor]];
//                [cell.detailTextLabel setFont:[UIFont systemFontOfSize:19]];
//                
//                break;
//            }
//        }
//        
//        return cell;
//    }
//    else {
//        static NSString *serID = @"serID";
//        
//        Service *cell = (Service *)[tableView dequeueReusableCellWithIdentifier:serID];
//        
//        if (cell == nil) {
//            [self.cellNib instantiateWithOwner:self options:nil];
//            cell = _tmpCell;
//            self.tmpCell = nil;
//        }
//        
//        NSArray *mArr = [_serList objectAtIndex:indexPath.row];
//        
//        [cell setOrderTime:[mArr objectAtIndex:0]];
//        [cell setHouseDesc:[mArr objectAtIndex:1]];
//        [cell setPayMethod:[mArr objectAtIndex:2]];
//        [cell setBuildingArea:[mArr objectAtIndex:3]];
//        [cell setContractSignDesc:[mArr objectAtIndex:4]];
//        [cell setOrderTotalPrice:[mArr objectAtIndex:5]];
//        
//        return cell;
//    }
    
    static NSString *proID = @"proID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:proID];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proID] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    NSString *imgName = [[[_nameList objectAtIndex:indexPath.row] componentsSeparatedByString:@"."] objectAtIndex:0];
    
    //    NSString *updateTime = [[NSString alloc] initWithString:@""];
    //	if (nil != [customer updateTime]) {
    //        updateTime = [updateTime stringByAppendingString:[customer updateTime]];
    //    }
    //    cell.textLabel.text = [[customer name] stringByAppendingString:updateTime];
    
    [cell.textLabel setText:imgName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    switch ([tableView tag]) {
//        case 1:{
//            Customer *customer = [_customerList objectAtIndex:indexPath.row];
    crtImg = indexPath.row;
    
    [_nextBtn setHidden:NO];
    [_preBtn setHidden:NO];

//            
//            [customerID release];
//            customerID = [[NSString alloc] initWithString:[customer customerID]];
//            
//            Customer *cstm = [Customer sharedInstance];
//            [cstm setCustomerID:customerID];
//            
//            [cstName release];
//            cstName = [[NSString alloc] initWithString:[customer name]];
//            
//            [self setCustomerInfo];
//            [self setAdvInfo];
//            [self setMeanInfo];
//            [self setSerInfo];
//            
//            break;
//        }
    if (0 == crtImg) {
        [_preBtn setHidden:YES];
    }
    
//        case 2:{
//            AdvInfo *adv = [_advList objectAtIndex:indexPath.row];
//            
//            [cstAdvID release];
//            //            cstAdvID = [[NSString alloc] initWithString:[advArr objectAtIndex:0]];
//            
//            AdvInfo *advs = [AdvInfo sharedInstance];
//            
//            [advs setName:cstName];
//            [advs setType:[adv type]];
//            [advs setTime:[adv time]];
//            
//            if ([[adv type] isEqualToString:@"来电"]) {
//                [advs setModeDemand:[adv modeDemand]];
//                [advs setAreaDemand:[adv areaDemand]];
//                [advs setCallPoint:[adv callPoint]];
//                [advs setVisitIntent:[adv visitIntent]];
//                [advs setSellerName:[adv sellerName]];
//            }
//            
    if (crtImg == picCnt-1) {
        [_nextBtn setHidden:YES];
    }
//            if ([[adv type] isEqualToString:@"来访"]) {
//                [advs setIntention:[adv intention]];
//                [advs setTotalAcceptPrice:[adv totalAcceptPrice]];
//                [advs setVisitPoint:[adv visitPoint]];
//                [advs setFirstCase:[adv firstCase]];
//                [advs setBargain:[adv bargain]];
//                [advs setUnbargainElse:[adv unbargainElse]];
//                [advs setSellerName:[adv sellerName]];
//                [advs setWcjhx:[adv wcjhx]];
//                [advs setWcjxm:[adv wcjxm]];
//            }
//            
//            if ([[adv type] isEqualToString:@"回访"]) {
//                [advs setReVisitType:[adv reVisitType]];
//                [advs setReVisitDesc:[adv reVisitDesc]];
//            }
//            
//            if ([[adv type] isEqualToString:@"问候"]) {
//                [advs setFeastDay:[adv feastDay]];
//                [advs setClientUuid:[adv clientUuid]];
//                [advs setContent:[adv content]];
//                [advs setResponse:[adv response]];
//            }
//            
//            AdvInfoViewController *advInfoView = [[[AdvInfoViewController alloc] initWithNibName:@"AdvInfoViewController" bundle:nil] autorelease];
//            advInfoView.delegate = self;
//            
//            self.advPopoverController = [[[UIPopoverController alloc] initWithContentViewController:advInfoView] autorelease];
//            
//            if ([[adv type] isEqualToString:@"来电"]) {
//                [self.advPopoverController setPopoverContentSize: CGSizeMake(400, 500)];
//            }
//            if ([[adv type] isEqualToString:@"来访"]) {
//                [self.advPopoverController setPopoverContentSize:CGSizeMake(400, 640)];
//            }
//            if ([[adv type] isEqualToString:@"回访"]) {
//                [self.advPopoverController setPopoverContentSize:CGSizeMake(400, 500)];
//            }
//            if ([[adv type] isEqualToString:@"问候"]) {
//                [self.advPopoverController setPopoverContentSize:CGSizeMake(400, 650)];
//            }
//            
//            [self.advPopoverController dismissPopoverAnimated:YES];
//            
//            [self.advPopoverController presentPopoverFromRect:[[_advTable cellForRowAtIndexPath:indexPath] frame] inView:self.view permittedArrowDirections:NO animated:YES];
//            
//            break;   
//        }
//        case 3:{
//            NSArray *mArr = [_meanList objectAtIndex:indexPath.row];
//            
//            //            [mID release];
//            mID = [NSString stringWithString:[mArr objectAtIndex:2]];
//            
//            break;
//        }
    [self getPic];
//        case 4:{
//            NSArray *mArr = [_serList objectAtIndex:indexPath.row];
//            
//            Server *serv = [Server sharedInstance];
//            
//            [serv setSID:[mArr objectAtIndex:6]];
//            [serv setOrderTime:[mArr objectAtIndex:0]];
//            [serv setHouseDesc:[mArr objectAtIndex:1]];
//            [serv setPayMethod:[mArr objectAtIndex:2]];
//            [serv setBuildingArea:[mArr objectAtIndex:3]];
//            [serv setContractSignDesc:[mArr objectAtIndex:4]];
//            [serv setOrderTotalPrice:[mArr objectAtIndex:5]];
//            [serv setClientUuid:customerID];
//            
//            _servInfoView = [[ServiceInfoViewController alloc] initWithNibName:@"ServiceInfoViewController" bundle:[NSBundle mainBundle]];
//            [self.view addSubview:_servInfoView.view];
//            
//            //            OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
//            //            [[oad window] addSubview:servInfoView.view]
//            
//            break;
//        }
//    }
}

- (IBAction)navCg:(id)sender {
    if ([@"隐藏导航" isEqualToString:[[_navBtn titleLabel] text]]) {
        [_navBtn setTitle:@"显示导航" forState:UIControlStateNormal];
        
        [_nameTab setHidden:YES];
        [_spL setHidden:YES];
    }
    else {
        [_navBtn setTitle:@"隐藏导航" forState:UIControlStateNormal];
        
        [_nameTab setHidden:NO];
        [_spL setHidden:NO];
    }
}

@end
