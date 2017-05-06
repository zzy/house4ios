//
//  COMMON.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-1.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "COMMON.h"

@implementation COMMON

static COMMON *sharedInstance = nil;

+ (COMMON *) sharedInstance
{
    if(!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }
    
    return sharedInstance;
}

- (NSString *)md5:(NSString *)string
{
    const char *charUTF8 = [string UTF8String];
    unsigned char result[32];
    
    CC_MD5( charUTF8, strlen(charUTF8), result);
    
    return [NSString stringWithFormat: 
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], 
            result[4], result[5], result[6], result[7], 
            result[8], result[9], result[10], result[11], 
            result[12], result[13], result[14], result[15] 
            ]; 
}

- (NSString *)curDay
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];     
    [dateFormatter setDateFormat:@"今天是yyyy年MM月dd日"];
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

- (NSString *)cur_day
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

- (void)def_tbf:(UITabBar *)tb
{
    for (UIView *lf in [tb subviews]) {
        
        if (![lf isKindOfClass:NSClassFromString(@"UITabBarButton")])
            continue;
        
        for (id ls in [lf subviews]) {            
            if (![ls isKindOfClass:NSClassFromString(@"UITabBarButtonLabel")])
                continue;
            
            [ls setFont: [UIFont boldSystemFontOfSize:20]]; 
            [ls setFrame: CGRectMake(0, 0, 96, 48)];
            [ls setTextAlignment:UITextAlignmentCenter];
        }
    }
}

+ (NSString *)iso8859str:(NSString *)str
{
    NSStringEncoding utf8 = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingUTF8);
    NSStringEncoding iso8859_1= CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingISOLatin1);
    
    const char *converted = [str cStringUsingEncoding:utf8];
    
    return [NSString stringWithCString:converted encoding:iso8859_1];
}

@end
