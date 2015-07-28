//
//  OPMLParser.m
//  RSSReader
//
//  Created by LJ on 15/7/28.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "OPMLParser.h"
#import "OPMLItem.h"

@interface OPMLParser ()<NSXMLParserDelegate>{
    NSXMLParser *_parser;
    
    NSMutableArray *_itemArr;
}

@end


@implementation OPMLParser

- (id)initWithOPMLURL:(NSURL *)url{
    if (self = [super init]) {
        _opmlURL = url;
        _parser = [[NSXMLParser alloc]initWithContentsOfURL:_opmlURL];
        _parser.delegate = self;
        _itemArr = [NSMutableArray array];
    }
    return self;
}

- (void)parser{
    [_parser parse];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if ([elementName isEqualToString:@"outline"]) {
        if (![attributeDict[@"title"] isEqualToString:@"ios"]) {
            OPMLItem *item = [[OPMLItem alloc]init];
            [item setValuesForKeysWithDictionary:attributeDict];
            [_itemArr addObject:item];
        }
        
    }else{
        NSLog(@"没有值");
    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    
    if ([_delegate respondsToSelector:@selector(opmlParser:didFinishedWithItemAttributes:)]) {
        [_delegate opmlParser:self didFinishedWithItemAttributes:_itemArr];
    }
}


@end

