//
//  XMLParser.m
//  ObjCLib
//
//  Created by Zhongyu Zhang on 11-11-24.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "XMLParser.h"

@implementation XMLParser

static XMLParser *sharedInstance = nil;

+ (XMLParser *) sharedInstance
{
    if(!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

- (NodeData *) parse: (NSXMLParser *) parser
{
    stack = [NSMutableArray array];
    
    NodeData *root = [NodeData nodeData];
    root.parent = nil;
    root.leafvalue = nil;
    root.children = [NSMutableArray array];
    
    [stack addObject:root];
    
    [parser setDelegate:self];
    [parser parse];
    [parser release];
    
    // pop down to real root
    NodeData *realroot = [[root children] lastObject];
    root.children = nil;
    root.parent = nil;
    root.leafvalue = nil;
    root.key = nil;
    
    realroot.parent = nil;
    return realroot;
}

- (NodeData *)parseXMLFromData: (NSData *) data
{  
    NodeData *results;
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    results = [self parse:parser];
    [pool drain];
    return results;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) elementName = qName;
    
    NodeData *leaf = [NodeData nodeData];
    leaf.parent = [stack lastObject];
    [(NSMutableArray *)[[stack lastObject] children] addObject:leaf];
    
    leaf.key = [NSString stringWithString:elementName];
    leaf.leafvalue = nil;
    leaf.children = [NSMutableArray array];
    
    [stack addObject:leaf];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    [stack removeLastObject];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (![[stack lastObject] leafvalue])
    {
        [[stack lastObject] setLeafvalue:[NSString stringWithString:string]];
        return;
    }
    [[stack lastObject] setLeafvalue:[NSString stringWithFormat:@"%@%@", [[stack lastObject] leafvalue], string]];
}

@end

