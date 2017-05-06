//
//  Building.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-6.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Building : NSObject {
	NSString *bNO;
    NSString *houseCount;
    NSString *sellCount;
    NSString *licence;
    NSString *state;
    NSString *stateDesc;
}

@property (nonatomic, copy) NSString *bNO, *houseCount, *sellCount, *licence, *state, *stateDesc;

+ (id)initWithNO:(NSString *)bNO hCount:(NSString *)houseCount sCount:(NSString *)sellCount lic:(NSString *)license state:(NSString *) state stateDesc:(NSString *)stateDesc;

@end
