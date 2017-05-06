//
//  Photo.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-21.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject {
    NSString *isB;
    NSString *name;
	NSString *path;
    NSMutableArray *pArr;
}

@property (nonatomic, retain) NSString *isB, *name, *path;
@property (nonatomic, retain) NSMutableArray *pArr;

+ (Photo *) sharedInstance;

@end
