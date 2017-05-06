//
//  Building.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-6.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "Market.h"

@implementation Market

@synthesize mkID, name, address, developer, openingTime, handTime, type, modelArea, publicApportion, managerPrice, fitment, area, totalArea, countHouse, cubage, density, virescence, parking, time, mainModel, priceBetween, averagePrice, projectPlan, sellMeans, buildDesign, sightDesign, manager, sellProxy, ad, makeModel, summarize, ageFrame, buyUse, work, clientFrom, sellSay, sellAd, spreadPackaging, spreadSell, spreadAd, spreadSeller, itemGood, itemBad, projectUuid;

static Market *sharedInstance = nil;

+ (Market *) sharedInstance
{
    if(!sharedInstance) {
        sharedInstance = [[self alloc] init];
        // [[PlatformViewController alloc] initWithNibName:@"PlatformViewController" bundle:[NSBundle mainBundle]];
    }
    
    return sharedInstance;
}

+ (id)initWithID:(NSString *)mkID Name:(NSString *)name Address:(NSString *)address Developer:(NSString *)developer
{
	Market *newMarket = [[[self alloc] init] autorelease];
	
    newMarket.mkID = mkID;
    newMarket.name = name;
    newMarket.address = address;
    newMarket.developer = developer;
    
	return newMarket;
}

- (void)dealloc
{
	[mkID release];
	[name release];
    [address release];
    [developer release];
    [openingTime release];
    [handTime release];
    [type release];
	[modelArea release];
    [publicApportion release];
    [managerPrice release];
    [fitment release];
    [area release];
    [totalArea release];
	[countHouse release];
    [cubage release];
    [density release];
    [virescence release];
    [parking release];
    [time release];
	[mainModel release];
    [priceBetween release];
    [averagePrice release];
    [projectPlan release];
    [sellMeans release];
    [buildDesign release];
	[sightDesign release];
    [manager release];
    [sellProxy release];
    [ad release];
    [makeModel release];
    [summarize release];
	[ageFrame release];
    [buyUse release];
    [work release];
    [clientFrom release];
    [sellSay release];
    [sellAd release];
	[spreadPackaging release];
    [spreadSell release];
    [spreadAd release];
    [spreadSeller release];
    [itemGood release];
    [itemBad release];
	[projectUuid release];
    
	[super dealloc];
}

@end
