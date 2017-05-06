//
//  ShowImgViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-12.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZoomViewController.h"

@class ProjPhotosViewController;

@interface ShowImgViewController : ZoomViewController

@property (nonatomic, retain) ProjPhotosViewController *projPhotosView;

- (IBAction)projPhotos:(id)sender;

@property (retain, nonatomic) IBOutlet UIView *zoomView;
@property (retain, nonatomic) IBOutlet UIImageView *imgView;

@end
