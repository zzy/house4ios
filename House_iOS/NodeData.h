//
//  NodeData.h
//  ObjCLib
//
//  Created by Zhongyu Zhang on 11-11-24.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

@interface NodeData : NSObject
{
    NodeData      *parent;
    NSMutableArray  *children;
    NSString        *key;
    NSString        *leafvalue;
}

@property (nonatomic, retain)   NodeData      *parent;
@property (nonatomic, retain)   NSMutableArray  *children;
@property (nonatomic, retain)   NSString        *key;
@property (nonatomic, retain)   NSString        *leafvalue;


+ (NodeData *) nodeData;

- (NodeData *) objectForKey: (NSString *) aKey;
- (NSString *) leafForKey: (NSString *) aKey;
- (NSMutableArray *) objectsForKey: (NSString *) aKey;

@end
