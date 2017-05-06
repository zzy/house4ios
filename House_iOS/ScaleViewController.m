//
//  ViewController.m
//  PhotoPanDemo
//
//  Created by Zhongyu Zhang on 11-12-20.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "ScaleViewController.h"

@implementation ScaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *rootView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
    [rootView setScrollEnabled:TRUE];
    rootView.backgroundColor = [UIColor whiteColor];
    self.view = rootView;
    UIImage *image = [UIImage imageNamed:@"ap.png"];
    holderView = [[UIView alloc] initWithFrame:CGRectMake(100, 0, image.size.width, image.size.height)];
    imageView = [[UIImageView alloc] initWithFrame:[holderView frame]];
    [imageView setImage:image];
    [holderView addSubview:imageView];
    //拧的手势
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] 
                                                 initWithTarget:self action:@selector(scale:)];
    [pinchRecognizer setDelegate:self];
    [holderView addGestureRecognizer:pinchRecognizer];
    [rootView addSubview:holderView];
    [rootView release];
}

-(void)scale:(id)sender {
    [self.view bringSubviewToFront:[(UIPinchGestureRecognizer*)sender view]];
    //当手指离开屏幕时,将lastscale设置为1.0
    if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        lastScale = 1.0;
        return;
    }
    CGFloat scale = 1.0 - (lastScale - [(UIPinchGestureRecognizer*)sender scale]);
    CGAffineTransform currentTransform = [(UIPinchGestureRecognizer*)sender view].transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    [[(UIPinchGestureRecognizer*)sender view] setTransform:newTransform];
    lastScale = [(UIPinchGestureRecognizer*)sender scale];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return ![gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

@end