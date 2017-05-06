//
//  MeanFormViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-11.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MeanFormViewControllerDelegate

- (void)setMeanInfo;

@end

@interface MeanFormViewController : UIViewController

@property (assign, nonatomic) IBOutlet id <MeanFormViewControllerDelegate> delegate;

@property (retain, nonatomic) IBOutlet UITextField *time;
@property (retain, nonatomic) IBOutlet UITextView *policy;

- (IBAction)submit:(id)sender;
- (IBAction)cancel:(id)sender;

- (const char *)printBytes:(NSString *)str encoding:(NSStringEncoding)enc;

@end


