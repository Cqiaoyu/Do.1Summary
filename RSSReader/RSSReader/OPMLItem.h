//
//  OPMLItem.h
//  RSSReader
//
//  Created by LJ on 15/7/28.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OPMLItem : NSObject
@property (nonatomic, strong) NSString *htmlUrl;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *xmlUrl;

@end


/*
 htmlUrl = "http://casatwy.com/";
 text = "Casa Taloyum";
 title = "Casa Taloyum";
 type = rss;
 xmlUrl = "http://casatwy.com/feeds/all.atom.xml";
 */