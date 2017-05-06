//
//  House.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-1.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface House : NSObject
{
    NSString *hNO;
    NSString *hID;
    NSString *sellState;
    NSString *stateDesc;
    
    NSString *hDesc;
    NSString *hArea;
    NSString *unitPrice;
    NSString *totalPrice;
    
    NSString *hPic;
}

@property (nonatomic, copy) NSString *hNO, *hID, *sellState, *stateDesc;
@property (nonatomic, copy) NSString *hDesc, *hArea, *unitPrice, *totalPrice, *hPic;

+ (House *) sharedInstance;

+ (id)initWithID:(NSString *)hID hNO:(NSString *)hNO sellState:(NSString *)sellState stateDesc:(NSString *)stateDesc;

@end
