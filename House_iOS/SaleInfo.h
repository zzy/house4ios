//
//  Building.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-6.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaleInfo : NSObject {
    NSString *title;	 	//标题 
    NSString *state;	 	//状态（0有效，1失效） 
    NSString *type;	 	//优惠方式：0折扣、1返现 
    NSString *price;	 	//优惠额度：百分比、数额 
    NSString *time;	 	//发布时间 
    NSString *detail;	    //详情
}

@property (nonatomic, copy) NSString *title, *state, *type, *price, *time, *detail;

+ (id)initWithTitle:(NSString *)title State:(NSString *)state Type:(NSString *)type Price:(NSString *)price Time:(NSString *)time Detail:(NSString *) detail;

@end
