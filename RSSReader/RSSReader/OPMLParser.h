//
//  OPMLParser.h
//  RSSReader
//
//  Created by LJ on 15/7/28.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OPMLParserDelegate;


@interface OPMLParser : NSObject

@property (nonatomic, strong, readonly) NSURL *opmlURL;
@property (nonatomic)id<OPMLParserDelegate>delegate;

- (id)initWithOPMLURL:(NSURL *)url;
- (void)parser;

@end

@protocol OPMLParserDelegate <NSObject>
- (void)opmlParser:(OPMLParser *)parser didFinishedWithItemAttributes:(NSArray *)attributes;

@end
