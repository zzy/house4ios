//
//  LoginViewController.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-11-28.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "XmlParser.h"


@implementation XmlResolve

@synthesize objName;
@synthesize isList;
@synthesize currentResult;
@synthesize map;
@synthesize list;

- (void)dealloc
{
    [objName release];
    [currentResult release];
    [map release];
    [list release];
    isList = nil;
    [super dealloc];
}

-(NSMutableDictionary *)getObject:(NSString *)elName xmlData:(NSData *)xmlData
{
    self.objName = elName;
    self.isList = NO;
    NSXMLParser *xmlRead = [[NSXMLParser alloc] initWithData:xmlData];
    [xmlRead setDelegate:self];
    [xmlRead parse];
    [xmlRead release];
    return map;
}

-(NSMutableArray *)getList:(NSString *)elName xmlData:(NSData *)xmlData
{
    self.objName = elName;
    self.isList = YES;
    self.currentResult = [[NSMutableString alloc] init];
    self.list = [[NSMutableArray alloc]init];
    NSXMLParser *xmlRead = [[NSXMLParser alloc] initWithData:xmlData];
    [xmlRead setDelegate:self];
    [xmlRead parse];
    [xmlRead release];
    if ([list count]>0) {
        return list;
    }
    return nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    NSString *text = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (text==nil||[text isEqualToString:@""]||[text isEqualToString:@"\n"]) {
        self.currentResult = nil;
    }else{
        self.currentResult = [[[NSMutableString alloc] init]autorelease];
        [self.currentResult appendString:text];
    }
    [text release];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (currentResult!=nil) {
        if (map!=nil) {
            [map setObject:currentResult forKey:elementName];
        }
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:objName]) {
        map = [[[NSMutableDictionary alloc]init]autorelease];
        if(isList&&list!=nil&&map!=nil){
            [list addObject:map];
        }
    }else{
        
    }
    
}

/*
 XML *xml = [[XML alloc]init];
 
 NSString *path = [[NSBundle mainBundle] pathForResource:@"test1" ofType:@"xml"];//得到xml文件路径
 NSFileHandle *file = [NSFileHandle fileHandleForReadingAtPath:path];//得到xml文件
 NSData *data = [file readDataToEndOfFile];//读取到nsdata中
 [file closeFile];
 NSMutableDictionary *map = [xml getObject:@"book1" xmlData:data];
 NSLog(@"%@",[map objectForKey:@"author"]);
 [data release];
 [xml release];
 
 path = [[NSBundle mainBundle] pathForResource:@"test2" ofType:@"xml"];//得到xml文件路径
 file = [NSFileHandle fileHandleForReadingAtPath:path];//得到xml文件
 data = [file readDataToEndOfFile];//读取到nsdata中
 NSMutableArray *list = [xml getList:@"book1" xmlData:data];
 for (int i=0;i<[list count];i++) {
 NSMutableDictionary *map = [list objectAtIndex:i];
 NSLog(@"%@",[map objectForKey:@"author"]);
 }
 [data release];
 [xml release];
 */
 
@end
