//
//  CustomerFormViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-15.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "CustomerFormViewController.h"

#import "OudsAppDelegate.h"
#import "RedirectViewController.h"

#import "CustomerInfoViewController.h"
#import "CustomerGroupViewController.h"
#import "CustomerIssuedViewController.h"

#import "ValueTableViewController.h"
#import "ASIFormDataRequest.h"

#import "COMMON.h"
#import "Customer.h"
#import "Value.h"

#import "NodeData.h"
#import "XMLParser.h"

@implementation CustomerFormViewController
@synthesize sckfF = _sckfF;
@synthesize jyfyF = _jyfyF;
@synthesize qtfxF = _qtfxF;
@synthesize hfnrF = _hfnrF;
@synthesize whnrF = _whnrF;
@synthesize fknrF = _fknrF;
@synthesize biView = _biView;
@synthesize basicBtn = _basicBtn;
@synthesize navT = _navT;
@synthesize wcjxm = _wcjxm;
@synthesize wcjhx = _wcjhx;

@synthesize hfsj = _hfsj;
@synthesize qtyyfx = _qtyyfx;
@synthesize whmr = _whmr;
@synthesize fknr = _fknr;
@synthesize hffs = _hffs;
@synthesize whjr = _whjr;

@synthesize revisitDesc = _revisitDesc;
@synthesize revisitInfo = _revisitInfo;

@synthesize fkwcj = _fkwcj;
@synthesize xmwcj = _xmwcj;
@synthesize tsyq = _tsyq;
@synthesize cjyy = _cjyy;
@synthesize hxwcj = _hxwcj;
@synthesize jzbz = _jzbz;
@synthesize sfjsjz = _sfjsjz;
@synthesize cxxx = _cxxx;
@synthesize jgjsfw_lf = _jgjsfw_lf;
@synthesize zymd_lf = _zymd_lf;
@synthesize hxlf = _hxlf;
@synthesize mjlf = _mjlf;
@synthesize lcxx = _lcxx;

@synthesize khzxd = _khzxd;
@synthesize zymd = _zymd;
@synthesize smyx = _smyx;
@synthesize zjjsfw = _zjjsfw;
@synthesize mjxq = _mjxq;
@synthesize jgjsfw = _jgjsfw;
@synthesize basicView = _basicView;
@synthesize phoneForm = _phoneForm;
@synthesize visitForm = _visitForm;
@synthesize revisitForm = _revisitForm;
@synthesize serviceForm = _serviceForm;
@synthesize khgzys = _khgzys;
@synthesize jzqy = _jzqy;
@synthesize gzqy = _gzqy;
@synthesize khlb = _khlb;
@synthesize jtsr = _jtsr;
@synthesize cszy = _cszy;
@synthesize jtjg = _jtjg;
@synthesize zflx = _zflx;
@synthesize remark = _remark;
@synthesize zysx = _zysx;
@synthesize zygw = _zygw;
@synthesize hxxq = _hxxq;
@synthesize hztj = _hztj;

@synthesize valueID = _valueID;
@synthesize cField = _cField;
@synthesize cView = _cView;
@synthesize csView = _csView;

@synthesize valueTablePopoverController = _valueTablePopoverController;

@synthesize tabBarController = _tabBarController;
@synthesize username = _username;
@synthesize sellerName = _sellerName;
@synthesize phone1 = _phone1;
@synthesize phone2 = _phone2;
@synthesize phone3 = _phone3;
@synthesize phone2btn = _phone2btn;
@synthesize phone3btn = _phone3btn;
@synthesize advTypeLb = _advTypeLb;
@synthesize phoneViewBtn = _phoneViewBtn;
@synthesize visitViewBtn = _visitViewBtn;
@synthesize revisitViewBtn = _revisitViewBtn;
@synthesize serviceViewBtn = _serviceViewBtn;
@synthesize age = _age;

static BOOL isHidden;

static CustomerFormViewController *sharedInstance = nil;
static NSString *viewType = @"";

+ (CustomerFormViewController *) sharedInstance
{
    if(!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }
    
    return sharedInstance;
}

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
    
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
//    COMMON *comm = [COMMON sharedInstance];
    
    Customer *cstm = [Customer sharedInstance];
    
    if ([@"0" isEqualToString:[cstm isEdit]]) {
        [_sellerName setText:[oad USERNAME]];
    }
    else {
        [_navT setTitle:[NSString stringWithFormat:@"编辑客户：%@", [cstm name]]];
        
        [_username setText:[cstm name]];
        [_phone1 setText:[cstm phone]];
        
        if ([cstm age]) {
            [_age setText:[cstm age]];
        }
        else {
            [_age setText:@""];
        }
        if ([cstm gfmd]) {
            [_khlb setText:[cstm gfmd]]; 
        }
        else {
            [_khlb setText:@""];
        }
        if ([cstm jzqy]) {
            [_jzqy setText:[cstm jzqy]];
        }
        else {
            [_jzqy setText:@""];
        }
        if ([cstm bgqy]) {
            [_gzqy setText:[cstm bgqy]];
        }
        else {
            [_gzqy setText:@""];
        }
        if ([cstm jzz]) {
            [_jtsr setText:[cstm jzz]];
        }
        else {
            [_jtsr setText:@""];
        }
        if ([cstm cszy]) {
            [_cszy setText:[cstm cszy]];
        }
        else {
            [_cszy setText:@""];
        }
        if ([cstm czr]) {
            [_jtjg setText:[cstm czr]];
        }
        else {
            [_jtjg setText:@""];
        }
        if ([cstm jcnl]) {
            [_zflx setText:[cstm jcnl]];
        }
        else {
            [_zflx setText:@""];
        }
        if ([cstm rztj]) {
            [_hztj setText:[cstm rztj]];
        }
        else {
            [_hztj setText:@""];
        }
        if ([cstm hztj]) {
            [_hztj setText:[cstm hztj]];
        }
        else {
            [_hztj setText:@""];
        }
        
        [_sellerName setText:[cstm zygw]];
//        NSLog(@"%@", [cstm zyID]);
//        [_sellerName setValue:[cstm zyID] forKeyPath:@"zyid"];
        
        if ([cstm remark]) {
            [_remark setText:[cstm remark]];
        }
        else {
            [_remark setText:@""];
        }
        
        if ([cstm zysx]) {
            [_zysx setText:[cstm zysx]];
        }
        else {
            [_zysx setText:@""];
        }
        
//        [_username setUserInteractionEnabled:NO];
    }
    
//    [_phoneViewBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [_phoneForm setHidden:NO];
    
    [_tsyq setTag:250];
    [_cjyy setTag:251];
    [_qtyyfx setTag:252];
    [_fknr setTag:253];
//    [_wcjhx setTag:254];
//    [_wcjxm setTag:255];
    
//    _remark.frame = CGRectMake(153, 323, 556, 70);
    
    isHidden = YES;
}

- (void)viewDidUnload
{
    [self setUsername:nil];
    [self setAge:nil];
    [self setHztj:nil];
    [self setRemark:nil];
    [self setBasicView:nil];
    [self setJzqy:nil];
    [self setGzqy:nil];
    [self setKhlb:nil];
    [self setJtsr:nil];
    [self setCszy:nil];
    [self setJtjg:nil];
    [self setZflx:nil];
    
    [self setPhoneViewBtn:nil];
    [self setVisitViewBtn:nil];
    [self setRevisitViewBtn:nil];
    [self setServiceViewBtn:nil];
    
    [self setHxxq:nil];
    [self setJgjsfw:nil];
    [self setMjxq:nil];
    [self setSmyx:nil];
    [self setZymd:nil];
    [self setKhzxd:nil];
    [self setZygw:nil];
    
    [self setPhoneForm:nil];
    [self setVisitForm:nil];
    [self setRevisitForm:nil];
    [self setServiceForm:nil];
    
    [self setKhgzys:nil];
    [self setZjjsfw:nil];
    [self setLcxx:nil];
    [self setCxxx:nil];
    [self setSfjsjz:nil];
    [self setJzbz:nil];
    [self setTsyq:nil];
    [self setHxwcj:nil];
    [self setXmwcj:nil];
    [self setFkwcj:nil];
    [self setCjyy:nil];
    [self setJgjsfw_lf:nil];
    [self setZymd_lf:nil];
    [self setHxlf:nil];
    [self setMjlf:nil];
    [self setRevisitDesc:nil];
    [self setRevisitInfo:nil];
    [self setAdvTypeLb:nil];
    
    [self setValueID:nil];
    [self setCField:nil];
    [self setCView:nil];
    [self setCsView:nil];
    
    [self setSellerName:nil];
    [self setPhone1:nil];
    [self setPhone2:nil];
    [self setPhone2btn:nil];
    [self setPhone3:nil];
    [self setPhone3btn:nil];
    [self setWhjr:nil];
    [self setWhmr:nil];
    [self setFknr:nil];
    [self setHffs:nil];
    [self setHfsj:nil];
    [self setQtyyfx:nil];
    [self setWcjxm:nil];
    [self setWcjhx:nil];
    [self setNavT:nil];
    [self setZysx:nil];
    [self setBasicBtn:nil];
    [self setBiView:nil];
    [self setSckfF:nil];
    [self setJyfyF:nil];
    [self setQtfxF:nil];
    [self setHfnrF:nil];
    [self setWhnrF:nil];
    [self setFknrF:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)addPhone2:(id)sender {
    if ([_phone2 isHidden]) {
        [_phone2 setHidden:NO];
        [_phone2btn setTitle:@"-" forState:UIControlStateNormal];
        
        [_phone3btn setHidden:NO];
    }
    else {
        [_phone2 setHidden:YES];
        [_phone2btn setTitle:@"+" forState:UIControlStateNormal];
        
        [_phone3btn setHidden:YES];
        [_phone3 setHidden:YES];
    }
}

- (IBAction)addPhone3:(id)sender {
    if ([_phone3 isHidden]) {
        [_phone3 setHidden:NO];
        [_phone3btn setTitle:@"-" forState:UIControlStateNormal];
    }
    else {
        [_phone3 setHidden:YES];
        [_phone3btn setTitle:@"+" forState:UIControlStateNormal];
    }
}

- (IBAction)customer:(id)sender {
    UIViewController *redirectView = [[[RedirectViewController alloc] init] autorelease];
    CustomerInfoViewController *customerInfoView = [[[CustomerInfoViewController alloc] initWithNibName:@"CustomerInfoViewController" bundle:nil] autorelease];
    CustomerGroupViewController *customerGroupView = [[[CustomerGroupViewController alloc] initWithNibName:@"CustomerGroupViewController" bundle:nil] autorelease];
    UIViewController *customerIssuedView = [[[CustomerInfoViewController alloc] initWithNibName:@"CustomerInfoViewController" bundle:nil] autorelease];
    
    [customerInfoView setTitle:@"客户信息"];
    customerGroupView.delegate = customerInfoView;
    [customerIssuedView setTitle:@"重点客户"];
    
    // 设置客户卡片
    _tabBarController = [[[UITabBarController alloc] init] autorelease];
    
    _tabBarController.viewControllers = [NSArray arrayWithObjects:redirectView, customerInfoView, customerGroupView, customerIssuedView, nil];
    [_tabBarController setSelectedIndex:1];
    
    COMMON *comm = [COMMON sharedInstance];
    [comm def_tbf:[_tabBarController tabBar]];
    
    OudsAppDelegate *oad = [[UIApplication sharedApplication] delegate];
    [oad.window setRootViewController:_tabBarController];
    [oad.window makeKeyAndVisible];
}

- (IBAction)phoneView:(id)sender {
    COMMON *comm = [COMMON sharedInstance];
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    [self clearColor];
    [_phoneViewBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [_advTypeLb setText:[[_phoneViewBtn titleLabel] text]];
    [self hideBtns];
    
    [self hideForm];
    [_phoneForm setHidden:NO];
    _csView = _phoneForm;
    
    [_jgjsfw setText:[comm cur_day]];
    [_zygw setText:[oad USERNAME]];
}

- (IBAction)visitView:(id)sender {
    COMMON *comm = [COMMON sharedInstance];
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    [self clearColor];
    [_visitViewBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [_advTypeLb setText:[[_visitViewBtn titleLabel] text]];
    [self hideBtns];
    
    [self hideForm];
    [_visitForm setHidden:NO];
    _csView = _visitForm;
    
    [_khgzys setText:[comm cur_day]];
    [_sfjsjz setText:[oad USERNAME]];
    
    _sckfF.frame = CGRectMake(167, 126, 577, 74);
    _jyfyF.frame = CGRectMake(167, 204, 577, 74);
    _qtfxF.frame = CGRectMake(167, 282, 577, 74);
//    [self.tsyq.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
//    [_tsyq.layer setBorderColor: [[UIColor grayColor] CGColor]];
//    [_tsyq.layer setBorderWidth: 1.0];
//    [_tsyq.layer setCornerRadius:8.0f];
//    [_tsyq.layer setMasksToBounds:YES];
}

- (IBAction)revisitView:(id)sender {
    COMMON *comm = [COMMON sharedInstance];
    
    [self clearColor];
    [_revisitViewBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [_advTypeLb setText:[[_revisitViewBtn titleLabel] text]];
    [self hideBtns];
    
    [self hideForm];
    [_revisitForm setHidden:NO];
    _csView = _revisitForm;
    
    [_hfsj setText:[comm cur_day]];
    
    _hfnrF.frame = CGRectMake(40, 77, 710, 104);
}

- (IBAction)serviceView:(id)sender {
    [self clearColor];
    [_serviceViewBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [_advTypeLb setText:[[_serviceViewBtn titleLabel] text]];
    [self hideBtns];
    
    [self hideForm];
    [_serviceForm setHidden:NO];
    _csView = _serviceForm;
    
    _whnrF.frame = CGRectMake(40, 87, 710, 87);
    _fknrF.frame = CGRectMake(40, 207, 710, 87);
}

- (IBAction)advSelBtn:(id)sender {
    [_phoneViewBtn setHidden:NO];
    [_visitViewBtn setHidden:NO];
    [_revisitViewBtn setHidden:NO];
    
    Customer *cstm = [Customer sharedInstance];
    if ([@"1" isEqualToString:[cstm isEdit]]) {
        [_serviceViewBtn setHidden:NO];
    }
}

- (void)hideBtns
{
    [_phoneViewBtn setHidden:YES];
    [_visitViewBtn setHidden:YES];
    [_revisitViewBtn setHidden:YES];
    [_serviceViewBtn setHidden:YES];
}

- (void)dealloc {
    [_username release];
    [_age release];
    [_hztj release];
    [_remark release];
    [_basicView release];
    [_jzqy release];
    [_gzqy release];
    [_khlb release];
    [_jtsr release];
    [_cszy release];
    [_jtjg release];
    [_zflx release];
    
    [_phoneViewBtn release];
    [_visitViewBtn release];
    [_revisitViewBtn release];
    [_serviceViewBtn release];
    
    [_hxxq release];
    [_jgjsfw release];
    [_mjxq release];
    [_smyx release];
    [_zymd release];
    [_khzxd release];
    [_zygw release];
    
    [_phoneForm release];
    [_visitForm release];
    [_revisitForm release];
    [_serviceForm release];
    
    [_khgzys release];
    [_zjjsfw release];
    [_lcxx release];
    [_cxxx release];
    [_sfjsjz release];
    [_jzbz release];
    [_tsyq release];
    [_hxwcj release];
    [_xmwcj release];
    [_fkwcj release];
    [_cjyy release];
    [_jgjsfw_lf release];
    [_zymd_lf release];
    [_hxlf release];
    [_mjlf release];
    [_revisitDesc release];
    [_revisitInfo release];
    [_advTypeLb release];
    
//    [_csView release];
//    [_cView release];
//    [_cField release];
    [_valueID release];
    
    [_sellerName release];
    [_phone1 release];
    [_phone2 release];
    [_phone2btn release];
    [_phone3 release];
    [_phone3btn release];
    [_whjr release];
    [_whmr release];
    [_fknr release];
    [_hffs release];
    [_hfsj release];
    [_qtyyfx release];
    [_wcjxm release];
    [_wcjhx release];
    [_navT release];
    [_zysx release];
    [_basicBtn release];
    [_biView release];
    [_sckfF release];
    [_jyfyF release];
    [_qtfxF release];
    [_hfnrF release];
    [_whnrF release];
    [_fknrF release];
    [super dealloc];
}

#pragma mark - Value Table View Controller

- (void)valueTableViewControllerDidFinish:(ValueTableViewController *)controller
{
    [self.valueTablePopoverController dismissPopoverAnimated:YES];
}

- (void)setValue {
    ValueTableViewController *valueTableView = [[[ValueTableViewController alloc] initWithNibName:@"ValueTableViewController" bundle:nil] autorelease];
    valueTableView.delegate = self;
    
    self.valueTablePopoverController = [[[UIPopoverController alloc] initWithContentViewController:valueTableView] autorelease];
    
    Value *val = [Value sharedInstance];
    if ([@"HUO_ZHI_TU_JING" isEqualToString:[val vID]] || 
        [@"KE_HE_ZI_XUN_DIAN_CALL" isEqualToString:[val vID]] || 
        [@"KE_HE_ZI_XUN_DIAN_VISIT" isEqualToString:[val vID]] || 
        [@"WEI_CHENG_JIAO_XING_MU" isEqualToString:[val vID]] || 
        [@"WEI_CHENG_JIAO_HUXING" isEqualToString:[val vID]]) {
        [self.valueTablePopoverController setPopoverContentSize:CGSizeMake(200, 340)];
    }
    else {
        [self.valueTablePopoverController setPopoverContentSize:CGSizeMake(200, 300)];
    }
    
    [self.valueTablePopoverController presentPopoverFromRect:[_cField frame] inView:_cView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark text file methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (250 == [textField tag] || 251 == [textField tag] || 252 == [textField tag] || 253 == [textField tag] || 254 == [textField tag] || 255 == [textField tag]) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        
        if (250 == [textField tag]) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-40, self.view.frame.size.width, self.view.frame.size.height);
        }
        
        if (251 == [textField tag]) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-80, self.view.frame.size.width, self.view.frame.size.height);
        }
        
        if (252 == [textField tag]) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-180, self.view.frame.size.width, self.view.frame.size.height);
        }
        
        if (253 == [textField tag]) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-80, self.view.frame.size.width, self.view.frame.size.height);
        }
        if (254 == [textField tag]) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-220, self.view.frame.size.width, self.view.frame.size.height);
        }
        if (255 == [textField tag]) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-250, self.view.frame.size.width, self.view.frame.size.height);
        }
        
        [UIView commitAnimations];
    
        return YES;
    }
	else {
        return NO;
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField 
{
    if (250 == [textField tag] || 251 == [textField tag] || 252 == [textField tag] || 253 == [textField tag] || 254 == [textField tag] || 255 == [textField tag]) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        
        if (250 == [textField tag]) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+40, self.view.frame.size.width, self.view.frame.size.height);
        }
        
        if (251 == [textField tag]) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+80, self.view.frame.size.width, self.view.frame.size.height);
        }
        
        if (252 == [textField tag]) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+180, self.view.frame.size.width, self.view.frame.size.height);
        }
        
        if (253 == [textField tag]) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+80, self.view.frame.size.width, self.view.frame.size.height);
        }
        if (254 == [textField tag]) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+220, self.view.frame.size.width, self.view.frame.size.height);
        }
        if (255 == [textField tag]) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+250, self.view.frame.size.width, self.view.frame.size.height);
        }
        
        [UIView commitAnimations];
    
        return YES;
    }
	else {
        return NO;
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (250 == [textView tag] || 251 == [textView tag] || 252 == [textView tag] || 253 == [textView tag] || 254 == [textView tag] || 255 == [textView tag]) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        
        if (250 == [textView tag]) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-40, self.view.frame.size.width, self.view.frame.size.height);
        }
        
        if (251 == [textView tag]) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-110, self.view.frame.size.width, self.view.frame.size.height);
        }
        
        if (252 == [textView tag]) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-180, self.view.frame.size.width, self.view.frame.size.height);
        }
        
        if (253 == [textView tag]) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-120, self.view.frame.size.width, self.view.frame.size.height);
        }
        if (254 == [textView tag]) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-220, self.view.frame.size.width, self.view.frame.size.height);
        }
        if (255 == [textView tag]) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-250, self.view.frame.size.width, self.view.frame.size.height);
        }
        
        [UIView commitAnimations];
        
        return YES;
    }
	else {
        return NO;
    }
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (250 == [textView tag] || 251 == [textView tag] || 252 == [textView tag] || 253 == [textView tag] || 254 == [textView tag] || 255 == [textView tag]) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        
        if (250 == [textView tag]) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+40, self.view.frame.size.width, self.view.frame.size.height);
        }
        
        if (251 == [textView tag]) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+110, self.view.frame.size.width, self.view.frame.size.height);
        }
        
        if (252 == [textView tag]) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+180, self.view.frame.size.width, self.view.frame.size.height);
        }
        
        if (253 == [textView tag]) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+120, self.view.frame.size.width, self.view.frame.size.height);
        }
        if (254 == [textView tag]) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+220, self.view.frame.size.width, self.view.frame.size.height);
        }
        if (255 == [textView tag]) {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+250, self.view.frame.size.width, self.view.frame.size.height);
        }
        
        [UIView commitAnimations];
        
        return YES;
    }
	else {
        return NO;
    }
}

- (IBAction)setAgeValue:(id)sender 
{
    [self textFieldShouldBeginEditing:_age];
    
    Value *val = [Value sharedInstance];
    [val setVID:@"NIAN_LING_JIE_GOU"];
    
    _cField = _age;
    _cView = _basicView;
    
    [self setValue];
}

- (IBAction)setHztjValue:(id)sender {
    [self textFieldShouldBeginEditing:_hztj];
    
    Value *val = [Value sharedInstance];
    [val setVID:@"HUO_ZHI_TU_JING"];
    
    _cField = _hztj;
    _cView = _basicView;
    
    [self setValue];
}

- (IBAction)setJzqyValue:(id)sender {
    [self textFieldShouldBeginEditing:_jzqy];
    
    Value *val = [Value sharedInstance];
    [val setVID:@"JU_ZHU_QU_YU"];
    
    _cField = _jzqy;
    _cView = _basicView;
    
    [self setValue];
}

- (IBAction)setGzqyValue:(id)sender {
    [self textFieldShouldBeginEditing:_gzqy];
    
    Value *val = [Value sharedInstance];
    [val setVID:@"GONG_ZUO_QU_YU"];
    
    _cField = _gzqy;
    _cView = _basicView;
    
    [self setValue];
}

- (IBAction)setKhlbValue:(id)sender {
    [self textFieldShouldBeginEditing:_khlb];
    
    Value *val = [Value sharedInstance];
    [val setVID:@"ZHI_YE_MU_DI"];
    
    _cField = _khlb;
    _cView = _basicView;
    
    [self setValue];
}

- (IBAction)setJtsrValue:(id)sender {
    [self textFieldShouldBeginEditing:_jtsr];
    
    Value *val = [Value sharedInstance];
    [val setVID:@"TONG_ZHU_REN_KOU"];
    
    _cField = _jtsr;
    _cView = _basicView;
    
    [self setValue];
}

- (IBAction)setCszyValue:(id)sender {
    [self textFieldShouldBeginEditing:_cszy];
    
    Value *val = [Value sharedInstance];
    [val setVID:@"CONG_SHI_ZHI_YE"];
    
    _cField = _cszy;
    _cView = _basicView;
    
    [self setValue];
}

- (IBAction)setJtjgValue:(id)sender {
    [self textFieldShouldBeginEditing:_jtjg];
    
    Value *val = [Value sharedInstance];
    [val setVID:@"CHU_ZI_REN"];
    
    _cField = _jtjg;
    _cView = _basicView;
    
    [self setValue];
}

- (IBAction)setZflxValue:(id)sender {
    [self textFieldShouldBeginEditing:_zflx];
    
    Value *val = [Value sharedInstance];
    [val setVID:@"JUE_CE_NENG_LI"];
    
    _cField = _zflx;
    _cView = _basicView;
    
    [self setValue];
}

- (IBAction)sethxxqValue:(id)sender {
    [self textFieldShouldBeginEditing:_hxxq];
     
    Value *val = [Value sharedInstance];
    [val setVID:@"HU_XING_XU_QIU"];
    
    _cField = _hxxq;
    _cView = _phoneForm;
    
    [self setValue];
}

- (IBAction)setJgjsfwValue:(id)sender {
    [self textFieldShouldBeginEditing:_jgjsfw];
     
    Value *val = [Value sharedInstance];
    [val setVID:@"JIA_GE_JIE_SHOU_FAN_WEI"];
    
    _cField = _jgjsfw;
    _cView = _phoneForm;
    
    [self setValue];
}

- (IBAction)setMjxqValue:(id)sender {
    [self textFieldShouldBeginEditing:_mjxq];
     
    Value *val = [Value sharedInstance];
    [val setVID:@"MIAN_JI_XU_QIU"];
    
    _cField = _mjxq;
    _cView = _phoneForm;
    
    [self setValue];
}

- (IBAction)setSmyxValue:(id)sender {
    [self textFieldShouldBeginEditing:_smyx];
     
    Value *val = [Value sharedInstance];
    [val setVID:@"SHANG_MEN_YI_XIANG"];
    
    _cField = _smyx;
    _cView = _phoneForm;
    
    [self setValue];
}

- (IBAction)setZymdValue:(id)sender {
    [self textFieldShouldBeginEditing:_zymd];
     
    Value *val = [Value sharedInstance];
    [val setVID:@"ZHI_YE_MU_DI"];
    
    _cField = _zymd;
    _cView = _phoneForm;
    
    [self setValue];
}

- (IBAction)setKhzxdValue:(id)sender {
    [self textFieldShouldBeginEditing:_khzxd];
     
    Value *val = [Value sharedInstance];
    [val setVID:@"KE_HE_ZI_XUN_DIAN_CALL"];
    
    _cField = _khzxd;
    _cView = _phoneForm;
    
    [self setValue];
}

- (IBAction)setKhgzysValue:(id)sender {
    [self textFieldShouldBeginEditing:_khgzys];
     
    Value *val = [Value sharedInstance];
    [val setVID:@"SAN_GE_WEN_TI"];
    
    _cField = _khgzys;
    _cView = _visitForm;
    
    [self setValue];
}

- (IBAction)setLcxxValue:(id)sender {
    [self textFieldShouldBeginEditing:_lcxx];
     
    Value *val = [Value sharedInstance];
    [val setVID:@"MIAN_JI"];
    
    _cField = _lcxx;
    _cView = _visitForm;
    
    [self setValue];
}

- (IBAction)setCxxxValue:(id)sender {
    [self textFieldShouldBeginEditing:_cxxx];
     
    Value *val = [Value sharedInstance];
    [val setVID:@"CHAO_XIANG"];
    
    _cField = _cxxx;
    _cView = _visitForm;
    
    [self setValue];
}

- (IBAction)setSfjsjzValue:(id)sender {
    [self textFieldShouldBeginEditing:_sfjsjz];
     
    Value *val = [Value sharedInstance];
    [val setVID:@"SHI_FOU_JIE_SHOU_JING_ZHUANG"];
    
    _cField = _sfjsjz;
    _cView = _visitForm;
    
    [self setValue];
}

- (IBAction)setJzbzValue:(id)sender {
    [self textFieldShouldBeginEditing:_jzbz];
     
    Value *val = [Value sharedInstance];
    [val setVID:@"JING_ZHUANG_BIAO_ZHUN"];
    
    _cField = _jzbz;
    _cView = _visitForm;
    
    [self setValue];
}

- (IBAction)setHxwcjValue:(id)sender {
    [self textFieldShouldBeginEditing:_hxwcj];
     
    Value *val = [Value sharedInstance];
    [val setVID:@"WEI_CHENG_JIAO_HUXING"];
    
    _cField = _hxwcj;
    _cView = _visitForm;
    
    [self setValue];
}

- (IBAction)setXmwcjValue:(id)sender {
    [self textFieldShouldBeginEditing:_xmwcj];
     
    Value *val = [Value sharedInstance];
    [val setVID:@"WEI_CHENG_JIAO_XING_MU"];
    
    _cField = _xmwcj;
    _cView = _visitForm;
    
    [self setValue];
}

- (IBAction)setFkwcjValue:(id)sender {
    [self textFieldShouldBeginEditing:_fkwcj];
     
    Value *val = [Value sharedInstance];
    [val setVID:@"WEI_CHENG_JIAO_FU_KUAN"];
    
    _cField = _fkwcj;
    _cView = _visitForm;
    
    [self setValue];
}

- (IBAction)setZjjsfwValue:(id)sender {
    [self textFieldShouldBeginEditing:_zjjsfw];
     
    Value *val = [Value sharedInstance];
    [val setVID:@"ZONG_JIA_JIE_SHOU_FAN_WEI"];
    
    _cField = _zjjsfw;
    _cView = _visitForm;
    
    [self setValue];
}

- (IBAction)setJgjsfw_lfValue:(id)sender {
    [self textFieldShouldBeginEditing:_jgjsfw_lf];
     
    Value *val = [Value sharedInstance];
    [val setVID:@"KE_HE_ZI_XUN_DIAN_VISIT"];
    
    _cField = _jgjsfw_lf;
    _cView = _visitForm;
    
    [self setValue];
}

- (IBAction)setZymd_lfValue:(id)sender {
    [self textFieldShouldBeginEditing:_zymd_lf];
     
    Value *val = [Value sharedInstance];
    [val setVID:@"ZHI_YE_MU_DI"];
    
    _cField = _zymd_lf;
    _cView = _visitForm;
    
    [self setValue];
}

- (IBAction)setHxlfValue:(id)sender {
    [self textFieldShouldBeginEditing:_hxlf];
     
    Value *val = [Value sharedInstance];
    [val setVID:@"HU_XING"];
    
    _cField = _hxlf;
    _cView = _visitForm;
    
    [self setValue];
}

- (IBAction)setMjlfValue:(id)sender {
    [self textFieldShouldBeginEditing:_mjlf];
     
    Value *val = [Value sharedInstance];
    [val setVID:@"MIAN_JI_XU_QIU"];
    
    _cField = _mjlf;
    _cView = _visitForm;
    
    [self setValue];
}

-(void) clearColor
{
    [_phoneViewBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_visitViewBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_revisitViewBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_serviceViewBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

-(void) hideForm
{
    [_phoneForm setHidden:YES];
    [_visitForm setHidden:YES];
    [_revisitForm setHidden:YES];
    [_serviceForm setHidden:YES];
}

- (IBAction)setWhjrValue:(id)sender {
    [self textFieldShouldBeginEditing:_whjr];
    
    Value *val = [Value sharedInstance];
    [val setVID:@"WEN_HOU_JIE_RI"];
    
    _cField = _whjr;
    _cView = _serviceForm;
    
    [self setValue];
}

- (IBAction)setHffsValue:(id)sender {
    [self textFieldShouldBeginEditing:_hffs];
    
    Value *val = [Value sharedInstance];
    [val setVID:@"HUI_FANG_FANG_SHI"];
    
    _cField = _hffs;
    _cView = _revisitForm;
    
    [self setValue];
}

- (void)setValue:(NSString *)val
{
    [_cField setText:val];
}

- (IBAction)submit:(id)sender {
    //获取项目信息数据
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    OudsAppDelegate *oad = (OudsAppDelegate *) [[UIApplication sharedApplication] delegate];
    Customer *cstm = [Customer sharedInstance];
    
    NSString *urlStr = [[[NSString alloc] initWithString:[oad SERVER]] autorelease];
    
    if (_csView == _serviceForm) {
        urlStr = [urlStr stringByAppendingString:@"/security/client/addClientRegard/"];
    }
    else {
        urlStr = [urlStr stringByAppendingString:@"/security/client/bookInClient/"];
    }
    
    urlStr = [urlStr stringByAppendingString:[oad SID_PROJ]];
    //        urlStr = [urlStr stringByAppendingString:[@"&sheetUuid=" stringByAppendingString:sID]];
    //        urlStr = [urlStr stringByAppendingString:[@"&id=" stringByAppendingString:mID]];
    NSLog(@"%@", urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setStringEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", [oad PROJ_ID]);
    [request setPostValue:[oad PROJ_ID] forKey:@"projectUuid"];
//    [request appendPostData:[[NSString stringWithFormat:@"projectUuid=%@", [oad PROJ_ID]] dataUsingEncoding:NSUTF8StringEncoding]];
    
//    if ([@"0" isEqualToString:[cstm isEdit]]) {
    if (!(![_username text] || [@"" isEqualToString:[_username text]] || 
          ![_phone1 text] || [@"" isEqualToString:[_phone1 text]])) {
        
        if (!isHidden) {
            if ((![_age text] || [@"" isEqualToString:[_age text]] ||
             ![_khlb text] || [@"" isEqualToString:[_khlb text]] ||
             ![_jzqy text] || [@"" isEqualToString:[_jzqy text]] || 
             ![_gzqy text] || [@"" isEqualToString:[_gzqy text]] || 
             ![_jtsr text] || [@"" isEqualToString:[_jtsr text]] || 
             ![_cszy text] || [@"" isEqualToString:[_cszy text]] || 
             ![_jtjg text] || [@"" isEqualToString:[_jtjg text]] || 
             ![_zflx text] || [@"" isEqualToString:[_zflx text]] || 
             ![_hztj text] || [@"" isEqualToString:[_hztj text]])) {
                [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"除重要事项、备注外，均为必填项，请完整填写！\n", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
                [av show];
                
                return;
            }
        }
        
        if ([@"1" isEqualToString:[cstm isEdit]]) {
            [request setPostValue:[cstm customerID] forKey:@"id"];
        }
        
        NSString *phones = [[[NSString alloc] initWithString:[_phone1 text]] autorelease];
        if (![@"" isEqualToString:[_phone2 text]]) {
            phones = [phones stringByAppendingFormat:@", %@", [_phone2 text]];
        }
        if (![@"" isEqualToString:[_phone3 text]]) {
            phones = [phones stringByAppendingFormat:@", %@", [_phone3 text]];
        }
            
        [request setPostValue:[COMMON iso8859str:[_username text]] forKey:@"name"];
        [request setPostValue:[COMMON iso8859str:phones] forKey:@"bookinPhone"];
        [request setPostValue:[COMMON iso8859str:[_age text]] forKey:@"age"];
        [request setPostValue:[COMMON iso8859str:[_khlb text]] forKey:@"purpose"];
        [request setPostValue:[COMMON iso8859str:[_jzqy text]] forKey:@"liveArea"];
        [request setPostValue:[COMMON iso8859str:[_gzqy text]] forKey:@"workArea"];
        [request setPostValue:[COMMON iso8859str:[_jtsr text]] forKey:@"liver"];
        [request setPostValue:[COMMON iso8859str:[_cszy text]] forKey:@"work"];
        [request setPostValue:[COMMON iso8859str:[_jtjg text]] forKey:@"promoter"];
        [request setPostValue:[COMMON iso8859str:[_zflx text]] forKey:@"decision"];
        [request setPostValue:[COMMON iso8859str:[_hztj text]] forKey:@"cognizePath"];
//        [request appendPostData:[[NSString stringWithFormat:@"cognizePath=%@", [_hztj text]] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setPostValue:[oad USER_ID] forKey:@"sellerUuid"];
        [request setPostValue:[COMMON iso8859str:[_remark text]] forKey:@"remark"];
        [request setPostValue:[COMMON iso8859str:[_zysx text]] forKey:@"impRemark"];
        
        if (_csView) {
            if (_csView == _phoneForm) {
                NSLog(@"%@", @"增加来电信息");
                [request setPostValue:@"0" forKey:@"isCall"];
                
                if (!(![_hxxq text] || [@"" isEqualToString:[_hxxq text]] || 
                      ![_khzxd text] || [@"" isEqualToString:[_khzxd text]] || 
                      ![_smyx text] || [@"" isEqualToString:[_smyx text]] || 
                      ![_mjxq text] || [@"" isEqualToString:[_mjxq text]])) {
                    [request setPostValue:[oad USER_ID] forKey:@"sellerUuid"];
                    [request setPostValue:[COMMON iso8859str:[_hxxq text]] forKey:@"modeDemand"];
                    [request setPostValue:[COMMON iso8859str:[_khzxd text]] forKey:@"callPoint"];
                    [request setPostValue:[COMMON iso8859str:[_smyx text]] forKey:@"visitIntent"];
                    [request setPostValue:[COMMON iso8859str:[_mjxq text]] forKey:@"areaDemand"];
                    [request setPostValue:[_jgjsfw text] forKey:@"time"];
                }
                else {
                    [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"请完整填写来电信息！\n", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
                    [av show];
                    
                    return;
                }
            }
            
            if (_csView == _visitForm) {
                NSLog(@"%@", @"增加来访信息");
                [request setPostValue:@"1" forKey:@"isCall"];
                
                if (!(![_zymd_lf text] || [@"" isEqualToString:[_zymd_lf text]] || 
                      ![_jgjsfw_lf text] || [@"" isEqualToString:[_jgjsfw_lf text]] || 
                      ![_zjjsfw text] || [@"" isEqualToString:[_zjjsfw text]] || 
                      ![_tsyq text] || [@"" isEqualToString:[_tsyq text]])) {
                    [request setPostValue:[oad USER_ID] forKey:@"sellerUuid"];
                    [request setPostValue:[COMMON iso8859str:[_zymd_lf text]] forKey:@"intention"];
                    [request setPostValue:[COMMON iso8859str:[_tsyq text]] forKey:@"firstCase"];
                    [request setPostValue:[COMMON iso8859str:[_cjyy text]] forKey:@"bargain"];
                    [request setPostValue:[COMMON iso8859str:[_qtyyfx text]] forKey:@"unbargainElse"];
                    [request setPostValue:[COMMON iso8859str:[_wcjhx text]] forKey:@"unbargainMode"];
                    [request setPostValue:[COMMON iso8859str:[_wcjxm text]] forKey:@"unbargainItem"];
                    [request setPostValue:[_khgzys text] forKey:@"time"];
                    [request setPostValue:[COMMON iso8859str:[_zjjsfw text]] forKey:@"totalAcceptPrice"];
                    [request setPostValue:[COMMON iso8859str:[_jgjsfw_lf text]] forKey:@"visitPoint"];
                }
                else {
                    [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"请完整填写来访信息！\n", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
                    [av show];
                    
                    return;
                }
            }
            
            if (_csView == _revisitForm) {
                NSLog(@"%@", @"增加回访信息");
                [request setPostValue:@"2" forKey:@"isCall"];
                
                if (!(![_revisitDesc text] || [@"" isEqualToString:[_revisitDesc text]] || 
                      ![_hffs text] || [@"" isEqualToString:[_hffs text]])) {
                    [request setPostValue:[COMMON iso8859str:[_revisitDesc text]] forKey:@"reVisitDesc"];
                    [request setPostValue:[_hfsj text] forKey:@"time"];
                    [request setPostValue:[COMMON iso8859str:[_hffs text]] forKey:@"reVisitType"];
                }
                else {
                    [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"请完整填写回访信息！\n", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
                    [av show]; 
                    
                    return;
                }
            }
            
            if (_csView == _serviceForm) {
                NSLog(@"%@", @"增加问侯信息");
                [request setPostValue:@"4" forKey:@"isCall"];
                
                if (!(![_whmr text] || [@"" isEqualToString:[_whmr text]] || 
                      ![_whjr text] || [@"" isEqualToString:[_whjr text]])) {
                    [request setPostValue:[COMMON iso8859str:[_whmr text]] forKey:@"content"];
                    [request setPostValue:[COMMON iso8859str:[_fknr text]] forKey:@"response"];
                    [request setPostValue:[COMMON iso8859str:[_whjr text]] forKey:@"feastDay"];
                    [request setPostValue:[oad USER_ID] forKey:@"sellerUuid"];
                    [request setPostValue:[cstm customerID] forKey:@"clientUuid"];
                    [request setPostValue:[oad PROJ_ID] forKey:@"projectUuid"];
                }
                else {
                    [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"请完整填写问侯信息！\n", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
                    [av show];  
                    
                    return;
                }
            }
        }
        else {
            [request setPostValue:@"3" forKey:@"isCall"];
        }        
        
        [request startSynchronous];
        NSError *error = [request error];
        // 网络连接成功
        if (!error) {
            NSData *loginData = [request responseData];
            XMLParser *xmlParser = [XMLParser sharedInstance];
            NodeData *loginNode = [xmlParser parseXMLFromData:loginData];
            
            if (loginNode) {
                [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:[[loginNode leafForKey:@"message"] stringByAppendingString:@"\n"] delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
                [av show];
                
                if ([@"0" isEqualToString:[loginNode leafForKey:@"state"]]){
                    [self customer:nil];
                }
            }
            else {
                [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:@"未知错误，请联系管理员！\n" delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
                [av show];
            }
        }
        else {
            [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
            [av show];
        }
    }
    else {
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"请填写姓名、电话！\n", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];  
    }
}

- (IBAction)setWcjhxV:(id)sender {
    [self textFieldShouldBeginEditing:_wcjhx];
    
    Value *val = [Value sharedInstance];
    [val setVID:@"WEI_CHENG_JIAO_HUXING"];
    
    _cField = _wcjhx;
    _cView = _visitForm;
    
    [self setValue];
}

- (IBAction)setWcjxmV:(id)sender {
    [self textFieldShouldBeginEditing:_wcjxm];
    
    Value *val = [Value sharedInstance];
    [val setVID:@"WEI_CHENG_JIAO_XING_MU"];
    
    _cField = _wcjxm;
    _cView = _phoneForm;
    
    [self setValue];
}

- (void)xzrq
{
    //UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) ? @"\n\n\n\n\n\n\n\n\n" : @"\n\n\n\n\n\n\n\n\n\n\n" ;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"选择日期", nil];
    [actionSheet sizeToFit];
    
    actionSheet.tag = 51;
    [actionSheet showInView:self.view.window];
    //[actionSheet showFromTabBar:(UITabBar *)self.tabBarController.view];
    UIDatePicker *datePicker =[[[UIDatePicker alloc] init] autorelease];
    [datePicker sizeToFit];
//    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:NSLocalizedString(@"LocaleIdentifier", @"")];
    
    datePicker.tag = 101;
    datePicker.datePickerMode = 1;
    [actionSheet addSubview:datePicker];
    
    [actionSheet release];    
}

- (IBAction)setLdsjValue:(id)sender {
    _cField = _jgjsfw;
    _cView = _phoneForm;
    
    [self xzrq];
}

- (IBAction)setLfsjValue:(id)sender {
    _cField = _khgzys;
    _cView = _visitForm;
    
    [self xzrq];
}

- (IBAction)setHfsjValue:(id)sender {
    _cField = _hfsj;
    _cView = _revisitForm;
    
    [self xzrq];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{    
    switch (actionSheet.tag ) {
        case 51:
        {    
            UIDatePicker *datePicker = (UIDatePicker *)[actionSheet viewWithTag:101];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            
            _cField.text  =[formatter stringFromDate:datePicker.date];
            
            [formatter release];
        }    
            break;                    
            
        default:
            break;
    }    
}

- (IBAction)showBasic:(id)sender {
    // [@"显示基本信息" isEqualToString:[[sender titleLabel] text]
    if ([_biView isHidden]) {
        [_biView setHidden:NO];
        isHidden = NO;
        
        [(UIButton *)sender setTitle:@"隐藏基本信息" forState:UIControlStateNormal];
    }
    else {
        [_biView setHidden:YES];
        isHidden = YES;
        
        [(UIButton *)sender setTitle:@"显示基本信息" forState:UIControlStateNormal];
    }
}

@end
