//
//  CKHShareTCDelegate.h
//  ShareDemo
//
//  Created by cenkh on 14-7-12.
//  Copyright (c) 2014年 cenkh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBBaseRequest;
@class WBBaseResponse;

@protocol CKHShareTCDelegate <NSObject>

-(BOOL)handleOpenURL:(NSURL *) url;
-(BOOL)handleSinaOpenURL:(NSURL *)url;
@end

@protocol SinaRequestDelegate <NSObject>

-(void)didReceiveSinaWeiboRequest:(WBBaseRequest *)request;
-(void)didReceiveSinaWeiboResponse:(WBBaseResponse *)response;

@end
