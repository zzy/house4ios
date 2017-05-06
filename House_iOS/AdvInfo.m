//
//  AdvInfo.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 12-1-9.
//  Copyright (c) 2012年 OUDS. All rights reserved.
//

#import "AdvInfo.h"

@implementation AdvInfo

@synthesize name, type, time, sellerName, modeDemand, areaDemand, callPoint, visitIntent, intention, totalAcceptPrice, visitPoint, firstCase, bargain, unbargainElse, reVisitType, reVisitDesc, feastDay, clientUuid, content, response, wcjhx, wcjxm;

static AdvInfo *sharedInstance = nil;

+ (AdvInfo *)sharedInstance
{
    if (!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }
    
    return sharedInstance;
}

+ (id)initWithType:(NSString *)type Time:(NSString *)time ModeDemand:(NSString *)modeDemand AreaDemand:(NSString *)areaDemand CallPoint:(NSString *)callPoint VisitIntent:(NSString *)visitIntent SellerName:(NSString *)sellerName
{
    AdvInfo *newAdv = [[[AdvInfo alloc] init] autorelease];
    
    newAdv.type = type;
    newAdv.time = time;
    newAdv.modeDemand = modeDemand;
    newAdv.areaDemand = areaDemand;
    newAdv.callPoint = callPoint;
    newAdv.visitIntent = visitIntent;
    newAdv.sellerName = sellerName;
    
    return newAdv;
}

+ (id)initWithType:(NSString *)type Time:(NSString *)time intention:(NSString *)intention totalAcceptPrice:(NSString *)totalAcceptPrice visitPoint:(NSString *)visitPoint firstCase:(NSString *)firstCase bargain:(NSString *)bargain unbargainElse:(NSString *)unbargainElse wcjhx:(NSString *)wcjhx wcjxm:(NSString *)wcjxm SellerName:(NSString *)sellerName
{
    AdvInfo *newAdv = [[[AdvInfo alloc] init] autorelease];
    
    newAdv.type = type;
    newAdv.time = time;
    newAdv.intention = intention;
    newAdv.totalAcceptPrice = totalAcceptPrice;
    newAdv.visitPoint = visitPoint;
    newAdv.firstCase = firstCase;
    newAdv.bargain = bargain;
    newAdv.unbargainElse = unbargainElse;
    newAdv.sellerName = sellerName;
    newAdv.wcjhx = wcjhx;
    newAdv.wcjxm = wcjxm;
    
    return newAdv;
}

+ (id)initWithType:(NSString *)type Time:(NSString *)time reVisitType:(NSString *)reVisitType reVisitDesc:(NSString *)reVisitDesc
{
    AdvInfo *newAdv = [[[AdvInfo alloc] init] autorelease];
    
    newAdv.type = type;
    newAdv.time = time;
    newAdv.reVisitType = reVisitType;
    newAdv.reVisitDesc = reVisitDesc;
    
    return newAdv;
}

+ (id)initWithType:(NSString *)type Time:(NSString *)time feastDay:(NSString *)feastDay clientUuid:(NSString *)clientUuid content:(NSString *)content response:(NSString *)response
{
    AdvInfo *newAdv = [[[AdvInfo alloc] init] autorelease];
    
    newAdv.type = type;
    newAdv.time = time;
    newAdv.feastDay = feastDay;
    newAdv.clientUuid = clientUuid;
    newAdv.content = content;
    newAdv.response = response;
    
    return newAdv;
}

- (void)dealloc
{
	[type release];
	[time release];
    [modeDemand release];
    [areaDemand release];
    [callPoint release];
    [visitIntent release];
    [sellerName release];
    [intention release];
    [totalAcceptPrice release];
    [visitPoint release];
    [firstCase release];
    [bargain release];
    [unbargainElse release];
    [reVisitType release];
    [reVisitDesc release];
    [feastDay release];
    [clientUuid release];
    [content release];
    [response release];
    
	[super dealloc];
}

@end
