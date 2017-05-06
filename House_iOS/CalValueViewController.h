//
//  CalValueViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-19.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalValueViewController;
@class CustomerFormViewController;

@protocol CalValueViewControllerDelegate

- (void)setChoice:(NSString *)name val:(NSString *)val;
- (void)setPay:(NSString *)name val:(NSString *)val;
- (void)setLearn:(NSString *)name val:(NSString *)val;
- (void)setYh;
- (void)setYh:(NSString *)yhtj zk:(float)zk fx:(float)fx;
- (void)setLl;
- (void)valueTableViewControllerDidFinish:(CalValueViewController *)controller;

@end

@interface CalValueViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (assign, nonatomic) IBOutlet id <CalValueViewControllerDelegate> delegate;

@property (retain, nonatomic) IBOutlet UITableView *calvTable;
@property (nonatomic, retain) NSMutableArray *calvList;

- (IBAction)setZkv:(id)sender;
- (IBAction)setFxv:(id)sender;
- (IBAction)closeYh:(id)sender;
- (void)setDic:(NSString *)val key:(NSString *)key type:(NSString *)type;

@property (retain, nonatomic) IBOutlet UIButton *setZk;
@property (retain, nonatomic) IBOutlet UIButton *setFx;
@property (retain, nonatomic) IBOutlet UILabel *zklabel;
@property (retain, nonatomic) IBOutlet UILabel *fxlabel;

- (NSString *)getLl:(NSString *)llt limit:(NSString *)limit;

@end
