
//
//  PlatformViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-11-28.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "Project.h"

@implementation Project

@synthesize projID, name;


+ (id)projectWithID:(NSString *)projID name:(NSString *)name
{
	Project *newProject = [[[self alloc] init] autorelease];
	
    newProject.projID = projID;
	newProject.name = name;
    
	return newProject;
}


- (void)dealloc
{
	[projID release];
	[name release];
    
	[super dealloc];
}

@end
