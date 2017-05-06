//
//  ViewController.h
//  PhotoPanDemo
//
//  Created by Zhongyu Zhang on 11-12-20.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScaleViewController : UIViewController <UIGestureRecognizerDelegate> {
    UIImageView *imageView;
    CGFloat lastScale;
    UIView *holderView;
}

-(void)scale:(id)sender;
//-(void)moveToX:(CGFloat)x ToY:(CGFloat)y;

@end
