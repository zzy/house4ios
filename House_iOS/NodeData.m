//
//  NodeData.m
//  ObjCLib
//
//  Created by Zhongyu Zhang on 11-11-24.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "NodeData.h"

#define STRIP(X) [X stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]

@implementation NodeData
@synthesize parent;
@synthesize children;
@synthesize key;
@synthesize leafvalue;

#pragma mark Create and Initialize NodeData

- (NodeData *) init
{
    if (self = [super init])
    {
        self.key = nil;
        self.leafvalue = nil;
        self.parent = nil;
        self.children = nil;
    }
    return self;
}

+ (NodeData *) nodeData
{
    return [[[self alloc] init] autorelease];
}

- (NSArray *) uniqArray: (NSArray *) anArray
{
    NSMutableArray *array = [NSMutableArray array];
    for (id object in [anArray sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)])
        if (![[array lastObject] isEqualToString:object]) [array addObject:object];
    return array;
}

- (NodeData *) objectForKey: (NSString *) aKey
{
    NodeData *result = nil;
    for (NodeData *node in self.children)
        if ([node.key isEqualToString: aKey])
        {
            result = node;
            break;
        }
    if (result) return result;
    for (NodeData *node in self.children)
    {
        result = [node objectForKey:aKey];
        if (result) break;
    }
    return result;
}

- (NSString *) leafForKey: (NSString *) aKey
{
    NodeData *node = [self objectForKey:aKey];
    return node.leafvalue;
}

- (NSMutableArray *) objectsForKey: (NSString *) aKey
{
    NSMutableArray *result = [NSMutableArray array];
    for (NodeData *node in self.children)
    {
        if ([node.key isEqualToString: aKey]) [result addObject:node];
        [result addObjectsFromArray:[node objectsForKey:aKey]];
    }
    return result;
}

- (void) dumpAtIndent: (int) indent into:(NSMutableString *) outstring
{
    for (int i = 0; i < indent; i++) [outstring appendString:@"--"];
    
    [outstring appendFormat:@"[%2d] Key: %@ ", indent, key];
    if (self.leafvalue) [outstring appendFormat:@"(%@)", STRIP(self.leafvalue)];
    [outstring appendString:@"\n"];
    
    for (NodeData *node in self.children) [node dumpAtIndent:indent + 1 into: outstring];
}

- (id)forwardingTargetForSelector:(SEL)sel
{
    if ([self.children respondsToSelector:sel]) return self.children;
    return nil;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ( [super respondsToSelector:aSelector] ) return YES;
    if ([self.children respondsToSelector:aSelector]) return YES;
    return NO;
}

- (BOOL)isKindOfClass:(Class)aClass
{
    if (aClass == [NodeData class]) return YES;
    if ([super isKindOfClass:aClass]) return YES;
    if ([self.children isKindOfClass:aClass]) return YES;
    
    return NO;
}

- (void) dealloc
{
    self.parent = nil;
    self.children = nil;
    self.key = nil;
    self.leafvalue = nil;
    
    [super dealloc];
}

@end
