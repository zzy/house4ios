//
//  ShowPmtViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-22.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "ShowPmtViewController.h"

#import "PlatformViewController.h"
#import "Photo.h"
#import "ASIHTTPRequest.h"

@implementation ShowPmtViewController

@synthesize name = _name;
@synthesize zoomView = _zoomView;
@synthesize imgView = _imgView;

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
    
    Photo *photo = [Photo sharedInstance];
    [_name setTitle:[photo name]];
    
    NSURL *url = [NSURL URLWithString:[photo path]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request startSynchronous];
    NSError *error = [request error];
    // 网络连接成功
    UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
    if (!error) {
        NSData *projData = [request responseData];
        
        if ([projData length] < 2000000) {        
            UIImage *image = [UIImage imageWithData:projData];
            
            [_imgView setImage:image];
//            [image release];
            [self addGestureRecognizersToPiece:_zoomView];
        }
        else {
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
    [self setZoomView:nil];
    [self setName:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)projectInfo:(id)sender {
//    CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
//	UIView *view = [[UIView alloc] initWithFrame:appFrame];
//	view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
//	self.view = view;
//	[view release];
    [self.view removeFromSuperview];
    [self release];
//    
//    // redirect to 市场情况
//    PlatformViewController *platformView = [PlatformViewController sharedInstance];
//    [platformView house:nil];
}

- (void)dealloc {
    [_imgView release];
    [_zoomView release];
    [_name release];
    
    [super dealloc];
}

@end
