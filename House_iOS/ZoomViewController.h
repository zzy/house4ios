//
//  PhotoVC.h
//  Touches
//
//  Created by Zhongyu Zhang on 11-12-21.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZoomViewController : UIViewController <UIGestureRecognizerDelegate>
{ 
	UIPinchGestureRecognizer *pinchGesture;
    UIPanGestureRecognizer *panGesture;
    
    int touchCount;
    UIView *imgForReset;
	CGPoint startTouchPosition; 
}

- (void)addGestureRecognizersToPiece:(UIView *)piece;

@end
