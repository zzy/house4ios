//
//  Sex.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-16.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sex : NSObject

@property (nonatomic, copy) NSString *key, *value;

+ (Sex *) sharedInstance;

+ (id)initWithKey:(NSString *)key Value:(NSString *)value;

@end
