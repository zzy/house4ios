//
//  ProjPhotosViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-9.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlatformViewController;
@class ShowImgViewController;
@class ZoomViewController;

@interface ProjectPhotosViewController : UIViewController

@property (nonatomic, retain) PlatformViewController *platformView;
@property (nonatomic, retain) ShowImgViewController *showImgView;
@property (nonatomic, retain) ZoomViewController *zoomView;

- (IBAction)platform:(id)sender;

- (IBAction)showApImg:(id)sender;
- (IBAction)showBpImg:(id)sender;
- (IBAction)showCpImg:(id)sender;
- (IBAction)showDpImg:(id)sender;

- (void)showZoomView;

@end
