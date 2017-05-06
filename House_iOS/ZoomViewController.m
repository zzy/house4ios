//
//  ZoomViewController.m
//  Touches
//
//  Created by Zhongyu Zhang on 11-12-21.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "ZoomViewController.h"

#import <QuartzCore/QuartzCore.h>

@implementation ZoomViewController

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

- (void)viewDidUnload
{
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
//    [imgView release];
    [super dealloc];
}

- (void)addGestureRecognizersToPiece:(UIView *)piece
{
    pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scalePiece:)];
    [pinchGesture setDelegate:self];
    [piece addGestureRecognizer:pinchGesture];
    [pinchGesture release];
    
    panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPiece:)];
    [panGesture setMaximumNumberOfTouches:2];
    [panGesture setDelegate:self];
    [piece addGestureRecognizer:panGesture];
    [panGesture release];
}

- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = gestureRecognizer.view;
        
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        
        piece.center = locationInSuperview;
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)panPiece:(UIPanGestureRecognizer *)gestureRecognizer
{
    UIView *piece = [gestureRecognizer view];
    
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gestureRecognizer translationInView:[piece superview]];
        
//        NSLog(@"%f; %f; \n %f; %f \n %f; %f", translation.x, translation.y, [piece center].x + translation.x, [piece center].y + translation.y, [piece center].x, [piece center].y);
        
        CGFloat xr = [piece center].x + translation.x;
        CGFloat yr = [piece center].y + translation.y;
        
        if (xr < 200) {
            xr = 200;
        }
        if (xr > 700) {
            xr = 700;
        }
        if (yr < 150) {
            yr = 150;
        }
        if (yr > 900) {
            yr = 900;
        }
//        if (translation.x > [piece frame].size.width/2 - 50) {
//            xr = [piece frame].size.width/2 - 50;
//        }
//        if (translation.y > [piece frame].size.height/2 - 50) {
//            yr = [piece frame].size.height/2 - 50;
//        }
        
        [piece setCenter:CGPointMake(xr, yr)];
        [gestureRecognizer setTranslation:CGPointZero inView:[piece superview]];
    }
}

- (void)scalePiece:(UIPinchGestureRecognizer *)gestureRecognizer
{
//    UIView *piece = [gestureRecognizer view];
//    NSLog(@"111111%f", [piece frame].size.width);
//    if ([piece frame].size.width >=100 || [piece frame].size.width <= 3000) {
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    UIView *piece = [gestureRecognizer view];
    CGFloat scale = [gestureRecognizer scale];
    
    if ([piece frame].size.height < 345.0) {
        scale = 345.0/[piece frame].size.height;
    }
    if ([piece frame].size.height > 3450.0) {
        scale = 3450.0/[piece frame].size.height;
    }
        
//    NSLog(@"%f", scale);
//    if ([gestureRecognizer scale] < 0.2) {
//        scale = 0.2;
//    }
        
//    UIView *piece2 = [gestureRecognizer view];
//    NSLog(@"222222%f", [piece2 frame].size.width);
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        [gestureRecognizer view].transform = CGAffineTransformScale([[gestureRecognizer view] transform], scale, scale);
        [gestureRecognizer setScale:1];
    }
//    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer.view != otherGestureRecognizer.view)
        return NO;
    
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] || [otherGestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]])
        return NO;
    
    return YES;
}

@end
