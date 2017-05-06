//
//  House.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-1.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Floor : NSObject
{
    NSString *fNO;
    NSMutableArray *fRow;
}

@property (nonatomic, copy) NSString *fNO;
@property (nonatomic, copy) NSMutableArray *fRow;

+ (id)initWithNO:(NSString *)fNO hRow:(NSMutableArray *)fRow;

@end
