//
//  XMLParser.h
//  ObjCLib
//
//  Created by Zhongyu Zhang on 11-11-24.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "NodeData.h"

@interface XMLParser : NSObject
{
    NSMutableArray      *stack;
}

+ (XMLParser *) sharedInstance;

- (NodeData *) parseXMLFromData: (NSData*) data;

@end
