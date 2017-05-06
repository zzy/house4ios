//
//  Customer.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-13.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Customer : NSObject {
    NSString *customerID;
    NSString *name;
    NSString *phone;
    NSString *updateTime;
    NSString *type;
    
    NSString *isEdit;
    NSString *age;
    NSString *gfmd;
    NSString *jzqy;
    NSString *jzz;
    NSString *bgqy;
    NSString *cszy;
    NSString *czr;
    NSString *jcnl;
    NSString *rztj;
    NSString *zygw;
    NSString *zyID;
    NSString *remark;
    NSString *hztj;
    NSString *zysx;
}

@property (nonatomic, copy) NSString *customerID, *name, *phone, *updateTime, *type;
@property (nonatomic, copy) NSString *isEdit, *age, *gfmd, *jzqy, *jzz, *bgqy, *cszy, *czr, *jcnl, *rztj, *zygw, *zyID, *remark, *hztj, *zysx;

+ (Customer *) sharedInstance;

+ (id)initWithID:(NSString *)customerID Name:(NSString *)name phone:(NSString *)phone UpdateTime:(NSString *)updateTime Type:(NSString *)type;

@end
