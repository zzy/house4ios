//
//  Calculator.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-19.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject
{
    NSString *fromHouse;
    NSString *type; // -1 优惠选项；0 还款方式；1 贷款类型
    NSString *lendLimit;

}

@property (nonatomic, retain) NSString *fromHouse, *type, *lendLimit;

+ (Calculator *)sharedInstance;

@end
