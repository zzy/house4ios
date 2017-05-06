//
//  ShowPmtViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-22.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZoomViewController.h"

@interface ShowPmtViewController : ZoomViewController

- (IBAction)projectInfo:(id)sender;
@property (retain, nonatomic) IBOutlet UINavigationItem *name;

@property (retain, nonatomic) IBOutlet UIView *zoomView;
@property (retain, nonatomic) IBOutlet UIImageView *imgView;

@end
