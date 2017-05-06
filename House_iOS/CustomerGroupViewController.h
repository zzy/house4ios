//
//  CustomerGroupViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-11-29.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomerGroupViewControllerDelegate

- (void)setGrpCstm:(NSMutableArray *)cstmList index:(NSIndexPath *)indexPath;

@end

@interface CustomerGroupViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) IBOutlet id <CustomerGroupViewControllerDelegate> delegate;

@property (retain, nonatomic) IBOutlet UITableView *groupTable;
@property (nonatomic, retain) NSMutableArray *groupList;

@property (retain, nonatomic) IBOutlet UITableView *cltTable;
@property (nonatomic, retain) NSMutableArray *cltList;

- (void)refreshClients:(NSString *)seller;

@end
