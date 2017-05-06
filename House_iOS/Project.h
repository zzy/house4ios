//
//  PlatformViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-11-28.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

@interface Project : NSObject 
{
	NSString *projID;
	NSString *name;
}

@property (nonatomic, copy) NSString *projID, *name;

+ (id)projectWithID:(NSString *)projID name:(NSString *)name;

@end
