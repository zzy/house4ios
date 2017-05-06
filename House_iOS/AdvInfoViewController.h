//
//  AdvInfoViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-9.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AdvInfoViewController;

@protocol AdvInfoViewControllerDelegate

- (void)advViewControllerDidFinish:(AdvInfoViewController *)controller;

@end

@interface AdvInfoViewController : UIViewController

@property (assign, nonatomic) IBOutlet id <AdvInfoViewControllerDelegate> delegate;

@property (retain, nonatomic) IBOutlet UINavigationItem *advTitle;
@property (retain, nonatomic) IBOutlet UILabel *time;

@property (retain, nonatomic) IBOutlet UIView *phoneV;
@property (retain, nonatomic) IBOutlet UILabel *modeDemand;
@property (retain, nonatomic) IBOutlet UILabel *areaDemand;
@property (retain, nonatomic) IBOutlet UILabel *callPoint;
@property (retain, nonatomic) IBOutlet UILabel *visitIntent;
@property (retain, nonatomic) IBOutlet UILabel *sellerName;


@property (retain, nonatomic) IBOutlet UIView *visitV;
@property (retain, nonatomic) IBOutlet UILabel *intention;
@property (retain, nonatomic) IBOutlet UILabel *totalAcceptPrice;
@property (retain, nonatomic) IBOutlet UILabel *visitPoint;
@property (retain, nonatomic) IBOutlet UITextView *firstCase;
@property (retain, nonatomic) IBOutlet UITextView *bargain;
@property (retain, nonatomic) IBOutlet UITextView *unbargainElse;
@property (retain, nonatomic) IBOutlet UILabel *sellerNameV;

@property (retain, nonatomic) IBOutlet UIView *revisitV;
@property (retain, nonatomic) IBOutlet UILabel *reVisitType;
@property (retain, nonatomic) IBOutlet UITextView *reVisitDesc;

@property (retain, nonatomic) IBOutlet UIView *hiV;
@property (retain, nonatomic) IBOutlet UILabel *feastDay;
@property (retain, nonatomic) IBOutlet UILabel *clientUuid;
@property (retain, nonatomic) IBOutlet UITextView *content;
@property (retain, nonatomic) IBOutlet UITextView *response;

- (IBAction)close:(id)sender;

@property (retain, nonatomic) IBOutlet UILabel *wcjhx;
@property (retain, nonatomic) IBOutlet UILabel *wcjxm;

@property (retain, nonatomic) IBOutlet UIView *cV;
@property (retain, nonatomic) IBOutlet UITextView *policy;

@end
