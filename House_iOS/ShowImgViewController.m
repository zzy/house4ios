//
//  ShowImgViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-12.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "ShowImgViewController.h"

#import "ProjPhotosViewController.h"
#import "Photo.h"

#import "ASIHTTPRequest.h"

@implementation ShowImgViewController

@synthesize zoomView = _zoomView;
@synthesize imgView = _imgView;

@synthesize projPhotosView = _projPhotosView;

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
    
    Photo *photo = [Photo sharedInstance];
    
    NSURL *url = [NSURL URLWithString:[photo path]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request startSynchronous];
    NSError *error = [request error];
    // 网络连接成功
    if (!error) {
        NSData *projData = [request responseData];
        
        UIImage *image = [[UIImage imageWithData:projData] autorelease];
        
        [_imgView setImage:image];
        [self addGestureRecognizersToPiece:_zoomView];
    }
    else {
        UIAlertView *av = [[[UIAlertView alloc] init] autorelease];
        [av initWithTitle:NSLocalizedString(@"sys_info", nil) message:NSLocalizedString(@"network_exception", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"i_know", nil) otherButtonTitles:nil];
        [av show];
    }
}

- (void)viewDidUnload
{
    [self setZoomView:nil];
    [self setImgView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)projPhotos:(id)sender {
    _projPhotosView = [[ProjPhotosViewController alloc] init];
    [self.view addSubview:_projPhotosView.view];
}

- (void)dealloc {
    [_zoomView release];
    [_imgView release];
    [super dealloc];
}
@end
