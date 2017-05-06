//
//  AdvInfo.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-9.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdvInfo : NSObject
{
    NSString *name;
    NSString *type;
    NSString *time;
    NSString *sellerName;
    
    NSString *modeDemand;
    NSString *areaDemand;
    NSString *callPoint;
    NSString *visitIntent;

    NSString *intention;
    NSString *totalAcceptPrice;
    NSString *visitPoint;
    NSString *firstCase;
    NSString *bargain;
    NSString *unbargainElse;
    
    NSString *reVisitType;
    NSString *reVisitDesc;
    
    NSString *feastDay;
    NSString *clientUuid;
    NSString *content;
    NSString *response;
    
    NSString *wcjhx;
    NSString *wcjxm;
}

@property (retain, nonatomic) NSString *name, *type, *time, *sellerName, *modeDemand, *areaDemand, *callPoint, *visitIntent, *intention, *totalAcceptPrice, *visitPoint, *firstCase, *bargain, *unbargainElse, *reVisitType, *reVisitDesc, *feastDay, *clientUuid, *content, *response, *wcjhx, *wcjxm;

+ (AdvInfo *)sharedInstance;

+ (id)initWithType:(NSString *)type Time:(NSString *)time ModeDemand:(NSString *)modeDemand AreaDemand:(NSString *)areaDemand CallPoint:(NSString *)callPoint VisitIntent:(NSString *)visitIntent SellerName:(NSString *)sellerName;

+ (id)initWithType:(NSString *)type Time:(NSString *)time intention:(NSString *)intention totalAcceptPrice:(NSString *)totalAcceptPrice visitPoint:(NSString *)visitPoint firstCase:(NSString *)firstCase bargain:(NSString *)bargain unbargainElse:(NSString *)unbargainElse wcjhx:(NSString *)wcjhx wcjxm:(NSString *)wcjxm SellerName:(NSString *)sellerName;

+ (id)initWithType:(NSString *)type Time:(NSString *)time reVisitType:(NSString *)reVisitType reVisitDesc:(NSString *)reVisitDesc;

+ (id)initWithType:(NSString *)type Time:(NSString *)time feastDay:(NSString *)feastDay clientUuid:(NSString *)clientUuid content:(NSString *)content response:(NSString *)response;

@end
