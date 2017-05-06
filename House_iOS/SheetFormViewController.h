//
//  SheetFormViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-11.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SheetFormViewControllerDelegate

- (void)setStateInfo;

@end

@interface SheetFormViewController : UIViewController

@property (assign, nonatomic) IBOutlet id <SheetFormViewControllerDelegate> delegate;

@property (retain, nonatomic) IBOutlet UITextField *time;
@property (retain, nonatomic) IBOutlet UITextField *sign;
@property (retain, nonatomic) IBOutlet UITextField *desc;
@property (retain, nonatomic) IBOutlet UITextField *client;
@property (retain, nonatomic) IBOutlet UITextField *colleague;
@property (retain, nonatomic) IBOutlet UITextField *importantItems;
@property (retain, nonatomic) IBOutlet UITextField *elseCircs;

- (IBAction)submit:(id)sender;
- (IBAction)cancel:(id)sender;

@end
