//
//  Value.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-14.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Value : NSObject
{
    NSString *vID;
    NSString *vName;
}

@property (copy, nonatomic) NSString *vID, *vName;

+ (Value *) sharedInstance;

@end
