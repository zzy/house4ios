//
//  COMMON.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-1.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COMMON : NSObject

+ (COMMON *) sharedInstance;

- (NSString *)md5:(NSString *)string;
- (NSString *)curDay;
- (NSString *)cur_day;
- (void)def_tbf:(UITabBar *)tb;
+ (NSString *)iso8859str:(NSString *)str;

@end
