//
//  Group.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-6.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject
{
	NSString *name;
	NSMutableArray *cList;
//    NSMutableArray *cstmList;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSMutableArray *cList; //, *cstmList;

+ (Group *)sharedInstance;

+ (id)initWithName:(NSString *)name cList:(NSMutableArray *)cList;

@end
