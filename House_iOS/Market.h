//
//  Building.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-6.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Market : NSObject {
    NSString *mkID;	 	//UUID	 
    NSString *name;	 	//楼盘项目名称 
    NSString *address;	 	//地址 
    NSString *developer;	 	//开发商 
    NSString *openingTime;	 	//开盘时间	 
    NSString *handTime;	 	//交房时间 
    NSString *type;	 	//物业类型	 
    NSString *modelArea;	 //户型区间 
    NSString *publicApportion; //公摊率 
    NSString *managerPrice; 	//物管费 
    NSString *fitment;	 	//装修标准	 
    NSString *area;	 	//土地面积	 
    NSString *totalArea;	 //总建筑面积 
    NSString *countHouse;	 	//总户数 
    NSString *cubage;	 	//容积率 
    NSString *density;	 	//建筑密度	 
    NSString *virescence;	 	//绿化率 
    NSString *parking;	 	//车位配比 
    NSString *time;	 	//时间	 
    NSString *mainModel; 	//主力户型 
    NSString *priceBetween;	 	//价格区间	 
    NSString *averagePrice;	 	//均价	 
    NSString *projectPlan;	 	//工程进度	 
    NSString *sellMeans;	 	//促销手段 
    NSString *buildDesign;	 	//建筑设计 
    NSString *sightDesign;	 	//景观设计	 
    NSString *manager;	 	//物业管理	 
    NSString *sellProxy;	 	//销售代理	 
    NSString *ad; 	//广告推广	 
    NSString *makeModel; 	//模型制作	 
    NSString *summarize;	 	//总体户型总结	 
    NSString *ageFrame; 	//年龄结构 
    NSString *buyUse;	 	//购买用途 
    NSString *work;	 	//职业	 
    NSString *clientFrom;	 	//客户来源地 
    NSString *sellSay;	 	//卖点分析 销售说辞 
    NSString *sellAd;	 	//卖点分析 广告 
    NSString *spreadPackaging;	 	//市场推广评价 现场包装 
    NSString *spreadSell;	 	//市场推广评价 销售工具 
    NSString *spreadAd;	 //市场推广评价 媒介宣传 
    NSString *spreadSeller;	 	//市场推广评价 销售人员 
    NSString *itemGood;	 	//项目优劣分析 优势 
    NSString *itemBad;	 	//项目优劣分析 劣势 
    NSString *projectUuid;	 	//项目UUID 
}

@property (nonatomic, copy) NSString *mkID, *name, *address, *developer, *openingTime, *handTime, *type, *modelArea, *publicApportion, *managerPrice, *fitment, *area, *totalArea, *countHouse, *cubage, *density, *virescence, *parking, *time, *mainModel, *priceBetween, *averagePrice, *projectPlan, *sellMeans, *buildDesign, *sightDesign, *manager, *sellProxy, *ad, *makeModel, *summarize, *ageFrame, *buyUse, *work, *clientFrom, *sellSay, *sellAd, *spreadPackaging, *spreadSell, *spreadAd, *spreadSeller, *itemGood, *itemBad, *projectUuid;

+ (Market *) sharedInstance;

+ (id)initWithID:(NSString *)mkID Name:(NSString *)name Address:(NSString *)address Developer:(NSString *)developer;

@end
