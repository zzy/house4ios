//
//  Policy.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-26.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Policy : NSObject
{
    NSString *policyID;
	NSString *detail;
    NSString *state;
    NSString *time;
    NSString *title;
}

@property (nonatomic, copy) NSString *policyID, *detail, *state, *time, *title;

+ (id)initWithID:(NSString *)policyID Detail:(NSString *)detail State:(NSString *)state Time:(NSString *)time Title:(NSString *)title;

@end
